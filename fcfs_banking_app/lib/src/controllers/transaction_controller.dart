import 'package:fcfs_banking_app/core/utils/app_helpers.dart';
import 'package:fcfs_banking_app/services/firebase/transaction_service.dart';
import 'package:fcfs_banking_app/services/router/router.dart';
import 'package:fcfs_banking_app/services/router/routes_name.dart';
import 'package:fcfs_banking_app/src/models/transactions_model.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import 'user_controller.dart';

class TransactionController extends GetxController {
  final TransactionService _transactionService = TransactionService();

  var transactions = <TransactionModel>[].obs;
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  RxDouble totalBalance = 0.0.obs;
  RxMap<int, double> monthlyBalances = <int, double>{}.obs;
  RxDouble currentMonthBalance = 0.0.obs;
  double dailyLimit = 50000.00;
  var logger = Logger();
  var filteredTransaction = <TransactionModel>[].obs;
  RxDouble remainingDailyLimit = 0.0.obs;
  RxDouble remainingMonthlyLimit = 0.0.obs;
  RxDouble monthlyLimit = 10000.0.obs;

  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration.zero, () {
      final userController = Get.find<UserController>();
      if (userController.user.value != null) {
        fetchUserTransactions(userController.user.value!.uid);
        //  await _transactionService.getUserMonthlyLimit(userController.user.value!.uid);
      }
    });
    calculateCurrentMonthBalance();
    calculateRemainingDailyLimit();
    calculateRemainingMonthlyLimit();
  }

  // Fetch user transactions
  Future<void> fetchUserTransactions(String userId) async {
    isLoading.value = true;
    final result = await _transactionService.getUserTransactions(userId);
    result.fold(
      (error) {
        errorMessage.value = error;
        // AppHelpers.toast('Error: $error');
        logger.e('Error fetching user transactions: $error');
      },
      (fetchedTransactions) {
        fetchedTransactions.sort((a, b) => b.date.compareTo(a.date));

        transactions.value = fetchedTransactions;
        // Adjust to 0-based index
        calculateTotalBalance();
        calculateCurrentMonthBalance();
        calculateMonthlyBalances();
        calculateRemainingDailyLimit();
        calculateRemainingMonthlyLimit();
      },
    );
    isLoading.value = false;
  }

  void calculateCurrentMonthBalance() {
    final DateTime now = DateTime.now();
    currentMonthBalance.value = transactions
        .where((transaction) =>
            transaction.date.year == now.year &&
            transaction.date.month == now.month)
        .fold(
            0.0,
            (sum, transaction) => transaction.type == 'debit'
                ? sum - transaction.amount
                : sum + transaction.amount);
  }

// Add a transaction with an immediate balance refresh
  Future<void> addTransaction(TransactionModel transaction) async {
    isLoading.value = true;

    // Check if the transaction exceeds the daily limit
    if (dailyLimit >= 0) {
      double totalTransactionAmount = transactions
          .where((t) => t.date == transaction.date)
          .fold(0.0, (sum, t) => sum + t.amount);

      if (totalTransactionAmount + transaction.amount > dailyLimit) {
        errorMessage.value = 'Transaction exceeds daily limit!';
        AppHelpers.toast('Transaction exceeds daily limit');
        isLoading.value = false;
        return;
      }
    }

    final result =
        await _transactionService.addTransactionWithBalanceUpdate(transaction);
    result.fold(
      (error) {
        errorMessage.value = error;
        AppHelpers.toast('Error: $error');
        logger.e('Error adding transaction: $error');
      },
      (addedTransaction) {
        transactions.add(addedTransaction);
        // Fetch transactions to update balance
        fetchUserTransactions(transaction.userId!);
        calculateTotalBalance();
        calculateCurrentMonthBalance();
        calculateRemainingDailyLimit();
        calculateRemainingMonthlyLimit();

        AppHelpers.toast('Transaction successful');
      },
    );
    isLoading.value = false;
  }

  // Set the daily limit for a user
  Future<void> setDailyLimit(
      double limit, UserController userController) async {
    dailyLimit = limit;
    await _transactionService.updateUserDailyLimit(
        userController.user.value!.uid, limit);
    userController.updateDailyLimit(limit);
    AppHelpers.toast('Daily limit set successfully');
  }

  // set monthly limit for user
  Future<void> setMonthlyLimit(
      double limit, UserController userController) async {
    await _transactionService.updateUserMonthlyLimit(
        userController.user.value!.uid, limit);
    userController.updateMonthlyLimit(limit);
    AppHelpers.toast('Monthly limit set successfully');
  }

  // Update a transaction
  Future<void> updateTransaction(TransactionModel transaction) async {
    isLoading.value = true;
    final result = await _transactionService.updateTransaction(transaction);
    result.fold(
      (error) {
        errorMessage.value = error;
        AppHelpers.toast('Error: $error');
        logger.e('Error updating transaction: $error');
      },
      (_) {
        final index = transactions.indexWhere((t) => t.id == transaction.id);
        if (index != -1) {
          transactions[index] = transaction;
          AppHelpers.toast('Transaction updated successfully');
        }
      },
    );
    isLoading.value = false;
  }

  // Delete transaction
  Future<void> deleteTransaction(String transactionId) async {
    isLoading.value = true;
    final result = await _transactionService.deleteTransaction(transactionId);
    result.fold(
      (error) {
        errorMessage.value = error;
        AppHelpers.toast('Error: $error');
        logger.e('Error deleting transaction: $error');
      },
      (_) {
        transactions
            .removeWhere((transaction) => transaction.id == transactionId);
        AppHelpers.toast('Transaction deleted successfully');
      },
    );
    isLoading.value = false;
  }

  // Calculate the total balance based on the transactions
  void calculateTotalBalance() {
    double balance = 0.0;
    for (var transaction in transactions) {
      if (transaction.type == 'credit') {
        balance += transaction.amount;
      } else if (transaction.type == 'debit') {
        balance -= transaction.amount;
      }
    }
    totalBalance.value = balance;
  }

  List<TransactionModel> getRecentTransactions(int count) {
    List<TransactionModel> sortedTransactions = List.from(transactions);
    sortedTransactions.sort((a, b) => b.date.compareTo(a.date));
    return sortedTransactions.take(count).toList();
  }

  Future<void> payNow(String receiverPhone, double amount) async {
    isLoading.value = true;
    final userController = Get.find<UserController>();
    String senderId = userController.user.value!.uid;

    final result = await _transactionService.performPaymentTransaction(
        senderId, receiverPhone, amount);
    result.fold(
      (error) {
        errorMessage.value = error;
        AppHelpers.toast('Error: $error');
        // debugPrint('Error:s $error');
        logger.e('Error performing payment: $error');
      },
      (success) {
        // Refresh transactions to update UI
        fetchUserTransactions(senderId);
        calculateTotalBalance();
        AppHelpers.toast('Payment successful');
        router.goNamed(RoutesName.mainPage, pathParameters: {
          'initialIndex': '1',
        });
      },
    );
    isLoading.value = false;
  }

  // Filter transactions for today
  List<TransactionModel> getTodayTransactions() {
    final DateTime today = DateTime.now();
    return transactions.where((transaction) {
      return transaction.date.year == today.year &&
          transaction.date.month == today.month &&
          transaction.date.day == today.day;
    }).toList();
  }

  // Filter transactions for yesterday
  List<TransactionModel> getYesterdayTransactions() {
    final DateTime today = DateTime.now();
    return transactions.where((transaction) {
      return transaction.date.year == today.year &&
          transaction.date.month == today.month &&
          transaction.date.day == today.day - 1;
    }).toList();
  }

  // Filter transactions for this week
  List<TransactionModel> getThisWeekTransactions() {
    final DateTime now = DateTime.now();
    final DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    return transactions.where((transaction) {
      return transaction.date
              .isAfter(startOfWeek.subtract(const Duration(days: 1))) &&
          transaction.date.isBefore(now.add(const Duration(days: 1)));
    }).toList();
  }

  // Filter transactions for this month
  List<TransactionModel> getThisMonthTransactions() {
    final DateTime now = DateTime.now();
    return transactions.where((transaction) {
      return transaction.date.year == now.year &&
          transaction.date.month == now.month;
    }).toList();
  }

  // Filter transactions for the last 6 months
  List<TransactionModel> getLastSixMonthsTransactions() {
    final DateTime now = DateTime.now();
    final DateTime sixMonthsAgo = DateTime(now.year, now.month - 5);
    return transactions.where((transaction) {
      return transaction.date
              .isAfter(sixMonthsAgo.subtract(const Duration(days: 1))) &&
          transaction.date.isBefore(now.add(const Duration(days: 1)));
    }).toList();
  }

//calculate mothnly balance
  void calculateMonthlyTransactionAmounts() {
    monthlyBalances.clear();

    for (var transaction in transactions) {
      int month = transaction.date.month;
      int year = transaction.date.year;
      int key = year * 100 +
          month; // Unique key for each month (e.g., 202401 for Jan 2024)

      if (!monthlyBalances.containsKey(key)) {
        monthlyBalances[key] = 0.0;
      }

      if (transaction.type == 'debit') {
        monthlyBalances[key] = monthlyBalances[key]! - transaction.amount;
      } else {
        monthlyBalances[key] = monthlyBalances[key]! + transaction.amount;
      }
    }
  }

  void calculateMonthlyBalances() {
    monthlyBalances.clear();
    final now = DateTime.now();
    for (var transaction in transactions) {
      int monthKey = transaction.date.year * 100 + transaction.date.month;
      if (!monthlyBalances.containsKey(monthKey)) {
        monthlyBalances[monthKey] = 0.0;
      }
      if (transaction.type == 'credit') {
        monthlyBalances[monthKey] =
            (monthlyBalances[monthKey] ?? 0.0) + transaction.amount;
      } else {
        monthlyBalances[monthKey] =
            (monthlyBalances[monthKey] ?? 0.0) - transaction.amount;
      }
    }

    // Ensure all months are present, set to 0 if no transactions
    for (int i = 1; i <= 12; i++) {
      int monthKey = now.year * 100 + i;
      monthlyBalances[monthKey] ??= 0.0;
    }
  }

  void calculateRemainingDailyLimit() {
    final DateTime today = DateTime.now();
    double totalDailySpent = transactions
        .where((t) =>
            t.type == 'debit' &&
            t.date.year == today.year &&
            t.date.month == today.month &&
            t.date.day == today.day)
        .fold(0.0, (sum, t) => sum + t.amount);

    remainingDailyLimit.value = dailyLimit - totalDailySpent;
  }

  void calculateRemainingMonthlyLimit() {
    final DateTime now = DateTime.now();
    double totalMonthlySpent = transactions
        .where((t) =>
            t.type == 'debit' &&
            t.date.year == now.year &&
            t.date.month == now.month)
        .fold(0.0, (sum, t) => sum + t.amount);

    // Ensure monthlyLimit has been set before calculation
    remainingMonthlyLimit.value =
        monthlyLimit.value > 0 ? monthlyLimit.value - totalMonthlySpent : 0.0;
  }

  // fetch monthly limit
}
