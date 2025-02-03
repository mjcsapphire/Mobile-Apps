import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:fcfs_banking_app/src/models/transactions_model.dart';

class TransactionService {
  final CollectionReference transactionsRef =
      FirebaseFirestore.instance.collection('transactions');
  final CollectionReference usersRef =
      FirebaseFirestore.instance.collection('users');

// new transaction and daily limit
  Future<Either<String, TransactionModel>> addTransactionWithBalanceUpdate(
      TransactionModel transaction) async {
    try {
      // Get the user's current balance and daily limit
      final userDoc = await usersRef.doc(transaction.userId).get();
      double currentBalance = (userDoc['balance'] ?? 0).toDouble();
      double dailyLimit = (userDoc['dailyLimit'] ?? 0).toDouble();
      final double monthlyLimit = (userDoc['monthlyLimit'] ?? 0).toDouble();

      // Calculate the user's daily transaction total
      final today = DateTime.now();
      final startOfDay = DateTime(today.year, today.month, today.day);
      final transactionsSnapshot = await transactionsRef
          .where('userId', isEqualTo: transaction.userId)
          .where('date', isGreaterThanOrEqualTo: startOfDay)
          .get();

      double dailyTransactionTotal = transactionsSnapshot.docs.fold(
        0.0,
        (sum, doc) => doc['type'] == 'debit'
            ? sum + (doc['amount'] as num).toDouble()
            : sum,
      );

      final transactionsThisMonth = await transactionsRef
          .where('userId', isEqualTo: transaction.userId)
          .where('date',
              isGreaterThanOrEqualTo: DateTime(today.year, today.month, 1))
          .get();

      double monthlyTotal = transactionsThisMonth.docs.fold(
        0.0,
        (sum, doc) => doc['type'] == 'debit'
            ? sum + (doc['amount'] as num).toDouble()
            : sum,
      );

      if (monthlyTotal + transaction.amount > monthlyLimit) {
        return const Left('Monthly transaction limit exceeded');
      }

      // Check if the transaction would exceed the daily limit
      if (dailyTransactionTotal + transaction.amount > dailyLimit) {
        return const Left('Daily transaction limit exceeded');
      }

      // Check transaction type and calculate new balance
      double newBalance = transaction.type == 'credit'
          ? currentBalance + transaction.amount
          : currentBalance - transaction.amount;

      // Ensure balance does not go negative (optional)
      if (newBalance < 0) {
        return const Left('Insufficient balance for this transaction');
      }

      // Update the user's balance in Firestore
      await usersRef.doc(transaction.userId).update({
        'balance': newBalance,
      });

      // Add the transaction to the transactions collection
      final docRef = await transactionsRef.add(transaction.toMap());

      return Right(transaction.copyWith(id: docRef.id));
    } catch (e) {
      return Left('Failed to add transaction: $e');
    }
  }

  // Get all transactions for a specific user
  Future<Either<String, List<TransactionModel>>> getUserTransactions(
      String userId) async {
    try {
      final snapshot =
          await transactionsRef.where('userId', isEqualTo: userId).get();
      final transactions = snapshot.docs
          .map((doc) => TransactionModel.fromMap(
              doc.data() as Map<String, dynamic>, doc.id))
          .toList();

      return Right(transactions);
    } catch (e) {
      return Left('Failed to fetch transactions: $e');
    }
  }

  // Get current daily limit for user
  Future<double> getUserDailyLimit(String userId) async {
    try {
      final userDoc = await usersRef.doc(userId).get();
      if (userDoc.exists) {
        final data = userDoc.data() as Map<String, dynamic>?;
        print('daily limit: ${data?['dailyLimit']}');
        return data?['dailyLimit'] ?? 0.0;
      }
      return 0.0;
    } catch (e) {
      return 0.0;
    }
  }

  // Update the daily limit for a user in Firestore
  Future<void> updateUserDailyLimit(String userId, double limit) async {
    try {
      await usersRef.doc(userId).update({
        'dailyLimit': limit,
      });
    } catch (e) {
      throw Exception("Failed to update daily limit: $e");
    }
  }

  Future<double> getUserMonthlyLimit(String userId) async {
    try {
      final userDoc = await usersRef.doc(userId).get();
      if (userDoc.exists) {
        final data = userDoc.data() as Map<String, dynamic>?;
        return data?['monthlyLimit'] ?? 0.0;
      }
      return 0.0;
    } catch (e) {
      return 0.0;
    }
  }

  Future<void> updateUserMonthlyLimit(String userId, double limit) async {
    try {
      await usersRef.doc(userId).update({
        'monthlyLimit': limit,
      });
    } catch (e) {
      throw Exception("Failed to update monthly limit: $e");
    }
  }

  // Update a transaction
  Future<Either<String, bool>> updateTransaction(
      TransactionModel transaction) async {
    try {
      await transactionsRef.doc(transaction.id).update(transaction.toMap());
      return const Right(true);
    } catch (e) {
      return Left('Failed to update transaction: $e');
    }
  }

  // Delete a transaction
  Future<Either<String, bool>> deleteTransaction(String transactionId) async {
    try {
      await transactionsRef.doc(transactionId).delete();
      return const Right(true);
    } catch (e) {
      return Left('Failed to delete transaction: $e');
    }
  }

  // Transaction for payment
  Future<Either<String, bool>> performPaymentTransaction(
      String senderId, String receiverPhone, double amount) async {
    try {
      // Get sender's current balance and ensure it's a double
      final senderDoc = await usersRef.doc(senderId).get();
      double senderBalance = (senderDoc['balance'] ?? 0).toDouble();

      if (senderBalance < amount) {
        return const Left('Insufficient balance');
      }

      // find the receiver by phone number
      final receiverSnapshot = await usersRef
          .where('phoneNumber', isEqualTo: receiverPhone)
          .limit(1)
          .get();

      // Determine receiver details
      String? receiverId;
      double receiverBalance = 0;
      if (receiverSnapshot.docs.isNotEmpty) {
        final receiverDoc = receiverSnapshot.docs.first;
        receiverId = receiverDoc.id;
        receiverBalance = (receiverDoc['balance'] ?? 0).toDouble();
      }

      // Perform transaction
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        // Deduct from sender
        transaction.update(
            usersRef.doc(senderId), {'balance': senderBalance - amount});

        if (receiverId != null) {
          // Add to receiver if they exist
          transaction.update(
              usersRef.doc(receiverId), {'balance': receiverBalance + amount});
        }

        // Log the transaction for the sender
        final senderTransaction = TransactionModel(
          userId: senderId,
          amount: amount,
          type: 'debit',
          date: DateTime.now(),
          description:
              // receiverId != null
              //     ?
              'Transfer - Send to $receiverPhone',
          // ? 'Transfer - Send'
          // : 'Payment (receiver not registered)',
          recipient: receiverId != null
              ? {"id": receiverId, "phone": receiverPhone}
              : null,
          fees: 0,
          id: receiverId ?? '',
          status: 'completed',
        ).toMap();
        transaction.set(transactionsRef.doc(), senderTransaction);

        if (receiverId != null) {
          // Log the transaction for the receiver
          final receiverTransaction = TransactionModel(
            userId: receiverId,
            amount: amount,
            type: 'credit',
            date: DateTime.now(),
            recipient: {"id": senderId, "phone": senderDoc['phoneNumber']},
            fees: 0,
            id: senderId,
            status: 'completed',
            // description: 'Received payment from ${senderDoc['firstName']}',
            description: 'Transfer - Received from ${senderDoc['firstName']}',
          ).toMap();
          transaction.set(transactionsRef.doc(), receiverTransaction);
        }
      });

      return const Right(true);
    } catch (e) {
      print("Error: $e");
      return Left('Failed to perform payment transaction: $e');
    }
  }
}
