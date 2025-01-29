import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcfs_banking_app/core/utils/app_helpers.dart';
import 'package:fcfs_banking_app/services/notification/admin/send_notification.dart';
import 'package:fcfs_banking_app/src/models/referral_model.dart';
import 'package:fcfs_banking_app/src/models/user_model.dart';

class ReferralService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Generate unique referral code
  Future<String> generateReferralCode() async {
    const String chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
    final Random random = Random();
    String code;

    do {
      code =
          List.generate(8, (_) => chars[random.nextInt(chars.length)]).join();
    } while (await _referralCodeExists(code));

    return code;
  }

  // Check if referral code exists
  Future<bool> _referralCodeExists(String code) async {
    final query = await _firestore
        .collection('referrals')
        .where('referralCode', isEqualTo: code)
        .limit(1)
        .get();
    return query.docs.isNotEmpty;
  }

  // Initialize referral data for a new user
  Future<void> initializeReferral(String userId) async {
    try {
      final referralCode = await generateReferralCode();

      ReferralModel referralData = ReferralModel(
        referralCode: referralCode,
        referredUserIds: [],
        bonusEarned: 0,
        referredBy: null,
      );

      await _firestore
          .collection('referrals')
          .doc(userId)
          .set(referralData.toMap());
    } catch (e) {
      print('Error initializing referral data: $e');
      rethrow;
    }
  }

  // fetch user referral code
  Future<String> fetchUserReferralCode(String userId) async {
    try {
      final doc = await _firestore.collection('referrals').doc(userId).get();
      final referralData = ReferralModel.fromMap(doc.data() ?? {});
      return referralData.referralCode;
    } catch (e) {
      print('Error fetching user referral code: $e');
      rethrow;
    }
  }

  Future<void> redeemReferralCode(
      String referredUserId, String referralCode) async {
    try {
      // Fetch referrer
      final referrerQuery = await _firestore
          .collection('referrals')
          .where('referralCode', isEqualTo: referralCode)
          .limit(1)
          .get();

      if (referrerQuery.docs.isEmpty) {
        AppHelpers.toast('Invalid referral code.');
        throw Exception('Invalid referral code.');
      }

      final referrerDoc = referrerQuery.docs.first;
      final referrerId = referrerDoc.id;

      // Check if the referred user is not self-referring
      if (referredUserId == referrerId) {
        AppHelpers.toast('You cannot use your own referral code.');
        throw Exception('You cannot use your own referral code.');
      }

      // Check if the referred user already has a referrer
      final referredUserDoc =
          await _firestore.collection('referrals').doc(referredUserId).get();
      if (referredUserDoc.exists &&
          referredUserDoc.data()?['referredBy'] != null) {
        AppHelpers.toast('You have already redeemed a referral code.');
        throw Exception('You have already redeemed a referral code.');
      }

      // Start Firestore transaction for updates and notifications
      await _firestore.runTransaction((transaction) async {
        // Update referrer's data
        final referrerData = ReferralModel.fromMap(referrerDoc.data());
        final updatedReferrerData = referrerData.copyWith(
          referredUserIds: [...referrerData.referredUserIds, referredUserId],
          bonusEarned: referrerData.bonusEarned + 5, // Add $5 reward
        );

        // Update referral data for the referrer
        transaction.set(
          _firestore.collection('referrals').doc(referrerId),
          updatedReferrerData.toMap(),
          SetOptions(merge: true),
        );
        AppHelpers.toast('Referral code redeemed successfully!');

        // Update referred user's data
        transaction.update(
          _firestore.collection('referrals').doc(referredUserId),
          {'referredBy': referrerId, 'bonusEarned': FieldValue.increment(5)},
        );

        // Update user balances (Add $5 to referrer's balance and to referred user's balance)
        final referrerUserDoc =
            await _firestore.collection('users').doc(referrerId).get();
        final referredUserDoc =
            await _firestore.collection('users').doc(referredUserId).get();

        if (referrerUserDoc.exists && referredUserDoc.exists) {
          double referrerBalance = referrerUserDoc['balance'];
          double referredUserBalance = referredUserDoc['balance'];

          transaction.update(
            _firestore.collection('users').doc(referrerId),
            {'balance': referrerBalance + 5},
          );

          transaction.update(
            _firestore.collection('users').doc(referredUserId),
            {'balance': referredUserBalance + 5},
          );
        }

        // Create a transaction record for the referral bonus for both users
        transaction.set(
          _firestore.collection('transactions').doc(),
          {
            'fromUserId': referrerId,
            'toUserId': referredUserId,
            'amount': 5,
            'type': 'bonus',
            'date': DateTime.now().toIso8601String(),
            'description': 'Referral Bonus',
            'status': 'Completed',
          },
        );
      });

      // Send notifications
      final referrerData =
          await _firestore.collection('users').doc(referrerId).get();
      final referredUserData =
          await _firestore.collection('users').doc(referredUserId).get();

      UserModel referrerUser = UserModel.fromMap(referrerData.data()!);
      UserModel referredUser = UserModel.fromMap(referredUserData.data()!);

      // Notify referrer
      SendNotification().sendPushNotification(
        referredUser,
        referrerUser,
        "You have received a \$5 bonus for referring ${referredUser.firstName}.",
      );

      // Notify referred user
      SendNotification().sendPushNotification(
        referrerUser,
        referredUser,
        "You have received a \$5 bonus for using the referral code from ${referrerUser.firstName}.",
      );
    } catch (e) {
      print('Error redeeming referral code: $e');
      rethrow;
    }
  }
}
