import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcfs_banking_app/core/utils/app_helpers.dart';
import 'package:fcfs_banking_app/services/notification/admin/send_notification.dart';
import 'package:fcfs_banking_app/src/controllers/transaction_controller.dart';
import 'package:fcfs_banking_app/src/controllers/user_controller.dart';
import 'package:fcfs_banking_app/src/models/transactions_model.dart';
import 'package:fcfs_banking_app/src/models/user_model.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class DirectDebitController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TransactionController transactionController =
      Get.find<TransactionController>();

  var requests = <Map<String, dynamic>>[].obs;
  RxBool isLoading = false.obs;
  var logger = Logger();
  final CollectionReference transactionsRef =
      FirebaseFirestore.instance.collection('transactions');

  UserController userController = Get.find<UserController>();

  /// Fetch requests based on user role and user ID
  Future<void> fetchRequests(String userId, String role) async {
    isLoading.value = true;
    try {
      Stream<QuerySnapshot> requestStream;
      if (role == 'personal') {
        // Listen for requests sent by personal user
        requestStream = _firestore
            .collection('directDebitRequests')
            .where('personalUserId', isEqualTo: userId)
            .snapshots();
      } else if (role == 'business') {
        // Listen for requests received by business user
        requestStream = _firestore
            .collection('directDebitRequests')
            .where('businessUserId', isEqualTo: userId)
            .snapshots();
      } else {
        throw Exception("Invalid role: $role");
      }

      // Use the stream to update the requests list when data changes
      requestStream.listen((snapshot) {
        requests.value = snapshot.docs.map((doc) {
          var data = doc.data()! as Map<String, dynamic>;
          return {...data, 'id': doc.id};
        }).toList();
      });
    } catch (e) {
      AppHelpers.toast("Error listening for requests: $e");
      logger.e("Error listening for requests: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// Handle standing order or direct debit request
  Future<void> handleRequest(String requestId, String requestType) async {
    try {
      DocumentSnapshot requestDoc = await _firestore
          .collection('directDebitRequests')
          .doc(requestId)
          .get();

      var data = requestDoc.data()! as Map<String, dynamic>;
      String personalUserId = data['personalUserId'];
      String businessUserId = data['businessUserId'];
      double amount = data['amount'];

      if (requestType == 'StandingOrder') {
        // Deduct money immediately for Standing Order
        await processTransfer(
          personalUserId: personalUserId,
          businessUserId: businessUserId,
          amount: amount,
        );

        // Update the request status
        await _firestore
            .collection('directDebitRequests')
            .doc(requestId)
            .update({'status': 'Processed'});

        AppHelpers.toast("Standing order processed successfully.");
      } else if (requestType == 'DirectDebit') {
        // Requires approval (handled through the updateRequestStatus method)
        logger.i("Direct debit requires approval.");
      } else {
        throw Exception("Invalid request type: $requestType");
      }
    } catch (e) {
      AppHelpers.toast("Error handling request: $e");
      logger.e("Error handling request: $e");
    }
  }

  // Approve or reject a direct debit request
  Future<void> updateRequestStatus(String requestId, String status) async {
    try {
      DocumentSnapshot requestDoc = await _firestore
          .collection('directDebitRequests')
          .doc(requestId)
          .get();

      var data = requestDoc.data()! as Map<String, dynamic>;
      String personalUserId = data['personalUserId'];
      String businessUserId = data['businessUserId'];
      double amount = data['amount'];

      if (status == 'Approved') {
        // Process the transfer
        await processTransfer(
          personalUserId: personalUserId,
          businessUserId: businessUserId,
          amount: amount,
        );

        // Notify users about approval
        var personalUserData =
            await _firestore.collection('users').doc(personalUserId).get();
        var personalUser = UserModel.fromMap(personalUserData.data()!);

        var businessUserData =
            await _firestore.collection('users').doc(businessUserId).get();
        var businessUser = UserModel.fromMap(businessUserData.data()!);

        SendNotification().sendPushNotification(
          businessUser,
          personalUser,
          "Your direct debit request has been approved by ${businessUser.firstName}.",
        );
      } else if (status == 'Rejected') {
        // Notify users about rejection
        var personalUserData =
            await _firestore.collection('users').doc(personalUserId).get();
        var personalUser = UserModel.fromMap(personalUserData.data()!);

        var businessUserData =
            await _firestore.collection('users').doc(businessUserId).get();
        var businessUser = UserModel.fromMap(businessUserData.data()!);

        SendNotification().sendPushNotification(
          businessUser,
          personalUser,
          "Your direct debit request has been rejected by ${businessUser.firstName}.",
        );
      }

      // Update request status
      await _firestore
          .collection('directDebitRequests')
          .doc(requestId)
          .update({'status': status});

      AppHelpers.toast("Request $status successfully.");
    } catch (e) {
      AppHelpers.toast("Error updating request status: $e");
      logger.e("Error updating request status: $e");
    }
  }

  /// Process the transfer: Deduct from personal, add to business
  Future<void> processTransfer({
    required String personalUserId,
    required String businessUserId,
    required double amount,
  }) async {
    try {
      await _firestore.runTransaction((transaction) async {
        var personalRef = _firestore.collection('users').doc(personalUserId);
        var businessRef = _firestore.collection('users').doc(businessUserId);

        var personalDoc = await transaction.get(personalRef);
        var businessDoc = await transaction.get(businessRef);

        if (personalDoc['balance'] < amount) {
          throw Exception("Insufficient balance in personal account.");
        }

        transaction.update(personalRef, {
          'balance': personalDoc['balance'] - amount,
        });

        transaction.update(businessRef, {
          'balance': businessDoc['balance'] + amount,
        });

        transaction.set(_firestore.collection('transactions').doc(), {
          'fromUserId': personalUserId,
          'toUserId': businessUserId,
          'amount': amount,
          'type': 'debit',
          'date': DateTime.now().toIso8601String(),
          'description': 'Transfer',
          'status': 'Completed',
        });

        var personalUserData =
            await _firestore.collection('users').doc(personalUserId).get();
        var personalUser = UserModel.fromMap(personalUserData.data()!);

        var businessUserData =
            await _firestore.collection('users').doc(businessUserId).get();
        var businessUser = UserModel.fromMap(businessUserData.data()!);

        SendNotification().sendPushNotification(
          businessUser,
          personalUser,
          "An amount of $amount has been deducted from your account and credited to ${businessUser.firstName}.",
        );

        SendNotification().sendPushNotification(
          personalUser,
          businessUser,
          "You have received a payment of $amount from ${personalUser.firstName}.",
        );

        transactionController.addTransaction(TransactionModel(
          userId: personalUserId,
          amount: amount,
          type: 'debit',
          date: DateTime.now(),
          description: 'Transfer - DD or SO',
          recipient: {"id": businessUserId},
          fees: 0,
          status: 'Completed',
        ));

        transactionController.addTransaction(TransactionModel(
          userId: businessUserId,
          amount: amount,
          type: 'credit',
          date: DateTime.now(),
          description: 'Transfer - DD or SO',
          recipient: {"id": personalUserId},
          fees: 0,
          status: 'Completed',
        ));
      });
    } catch (e) {
      AppHelpers.toast("Error processing transfer: $e");
      logger.e("Error processing transfer: $e");
    }
  }

  // Send a request (Direct Debit or Standing Order)
  Future<void> sendRequest({
    required String personalUserId,
    required String businessUserId,
    required double amount,
    required String requestType,
  }) async {
    if (amount <= 0) {
      AppHelpers.toast("Amount must be greater than zero.");
      return;
    }
    try {
      final now = DateTime.now();
      final nextMonth = DateTime(now.year, now.month + 1, now.day);
      await _firestore.collection('directDebitRequests').add({
        'personalUserId': personalUserId,
        'businessUserId': businessUserId,
        'amount': amount,
        'status': requestType == 'StandingOrder' ? 'Processed' : 'Pending',
        'requestType': requestType,
        'date': now.toIso8601String(),
        'nextPaymentDate': nextMonth.toIso8601String(),
      });

      if (requestType == 'StandingOrder') {
        await processTransfer(
          personalUserId: personalUserId,
          businessUserId: businessUserId,
          amount: amount,
        );
      }

      var senderUserData = await _firestore
          .collection('users')
          .doc(userController.user.value!.uid)
          .get();

      var senderUser = UserModel.fromMap(senderUserData.data()!);

      var receiverUserData =
          await _firestore.collection('users').doc(businessUserId).get();

      var receiverUser = UserModel.fromMap(receiverUserData.data()!);

      SendNotification().sendPushNotification(
        senderUser,
        receiverUser,
        "You have a new $requestType request from ${senderUser.firstName}.",
      );
      AppHelpers.toast("Request sent successfully.");
    } catch (e) {
      AppHelpers.toast("Error sending request: $e");
      logger.e("Error sending request: $e");
    }
  }
}
