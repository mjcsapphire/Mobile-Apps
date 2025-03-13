import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcfs_banking_app/core/utils/app_helpers.dart';
import 'package:fcfs_banking_app/services/notification/admin/send_notification.dart';
import 'package:fcfs_banking_app/src/controllers/transaction_controller.dart';
import 'package:fcfs_banking_app/src/controllers/user_controller.dart';
import 'package:fcfs_banking_app/src/models/money_request_model.dart';
import 'package:fcfs_banking_app/src/models/user_model.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class PaymentController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TransactionController transactionController =
      Get.find<TransactionController>();

  var logger = Logger();
  UserController userController = Get.find<UserController>();
  var moneyRequest = <MoneyRequest>[].obs;

  Future<void> requestMoney(MoneyRequest moneyRequest) async {
    if (moneyRequest.amount <= 0) {
      AppHelpers.toast("Amount must be greater than zero.");
      return;
    }
    try {
      await _firestore.collection('moneyRequests').add(moneyRequest.toMap());

      var senderData = await _firestore
          .collection('users')
          .doc(moneyRequest.requesterId)
          .get();
      var sender = UserModel.fromMap(senderData.data()!);

      var receiverData = await _firestore
          .collection('users')
          .doc(moneyRequest.receiverId)
          .get();
      var receiver = UserModel.fromMap(receiverData.data()!);

      SendNotification().sendPushNotification(
        receiver,
        sender,
        "You have a new money request from ${sender.firstName}.",
      );

      AppHelpers.toast("Money request sent successfully.");
    } catch (e) {
      AppHelpers.toast("Error sending money request: $e");
      logger.e("Error sending money request: $e");
    }
  }

  Future<void> payRequestedMoney(String requestId) async {
    try {
      DocumentSnapshot requestDoc =
          await _firestore.collection('moneyRequests').doc(requestId).get();

      if (!requestDoc.exists || requestDoc.data() == null) {
        throw Exception("Request not found or invalid data.");
      }

      var data =
          MoneyRequest.fromMap(requestDoc.data()! as Map<String, dynamic>);

      if (data.status == 'Paid') {
        throw Exception("This request has already been processed.");
      }

      await _firestore.runTransaction((transaction) async {
        var requesterRef = _firestore.collection('users').doc(data.requesterId);
        var receiverRef = _firestore.collection('users').doc(data.receiverId);

        var requesterDoc = await transaction.get(requesterRef);
        var receiverDoc = await transaction.get(receiverRef);

        if (requesterDoc['balance'] < data.amount) {
          throw Exception("Insufficient balance.");
        }

        transaction.update(requesterRef, {
          'balance': FieldValue.increment(-data.amount),
        });
        transaction.update(receiverRef, {
          'balance': FieldValue.increment(data.amount),
        });

        transaction.update(requestDoc.reference, {'status': 'Paid'});

        transaction.set(_firestore.collection('transactions').doc(), {
          'fromUserId': data.requesterId,
          'toUserId': data.receiverId,
          'amount': data.amount,
          'type': 'debit',
          'date': DateTime.now().toIso8601String(),
          'status': 'Completed',
          'description': 'Money request payment',
        });
      });

      var requesterData =
          await _firestore.collection('users').doc(data.requesterId).get();
      var receiverData =
          await _firestore.collection('users').doc(data.receiverId).get();

      var requester = UserModel.fromMap(requesterData.data()!);
      var receiver = UserModel.fromMap(receiverData.data()!);

      SendNotification().sendPushNotification(
        requester,
        receiver,
        "Your money request of \$${data.amount.toStringAsFixed(2)} has been paid.",
      );

      AppHelpers.toast("Payment successful.");
    } on FirebaseException catch (_, e) {
      AppHelpers.toast("Firebase error: ${e.toString()}");
      logger.e("Firebase error: ${e.toString()}");
    }
  }

  // fetch money request
  Future<void> fetchMoneyRequests() async {
    try {
      var data = await _firestore.collection('moneyRequests').get();
      moneyRequest.value = data.docs.map((doc) {
        return MoneyRequest.fromMap(doc.data());
      }).toList();
    } catch (e) {
      AppHelpers.toast("Error fetching money requests: $e");
      logger.e("Error fetching money requests: $e");
    }
  }
}
