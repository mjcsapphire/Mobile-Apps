import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:fcfs_banking_app/src/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // fetch curent user
  Future<Either<String, UserModel>> getCurrentUserData() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        return const Left('No authenticated user');
      }
      String uid = currentUser.uid;
      return await getUserData(uid);
    } on FirebaseAuthException catch (e) {
      return Left('Error fetching current user data: $e');
    }
  }

  // Fetch user data by UID with Either for error handling
  Future<Either<String, UserModel>> getUserData(String uid) async {
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(uid).get();
      if (userDoc.exists) {
        return Right(UserModel.fromMap(userDoc.data() as Map<String, dynamic>));
      } else {
        return const Left("User not found");
      }
    } catch (e) {
      return Left("Error fetching user data: $e");
    }
  }

  // Update user data in Firestore with Either for error handling
  Future<Either<String, void>> updateUserData(
      String uid, Map<String, dynamic> data) async {
    try {
      await _firestore.collection('users').doc(uid).update(data);
      return const Right(null);
    } catch (e) {
      return Left("Error updating user data: $e");
    }
  }

  // Delete user data from Firestore with Either for error handling
  Future<Either<String, void>> deleteUserData(String uid) async {
    try {
      await _firestore.collection('users').doc(uid).delete();
      return const Right(null);
    } catch (e) {
      return Left("Error deleting user data: $e");
    }
  }

  Future<void> addFcmToken(String uid, String fcmToken) async {
    await _firestore
        .collection('users')
        .doc(uid)
        .update({'fcmToken': fcmToken});
  }

  Future<Either<String, double>> getDailySpending(String uid) async {
    try {
      // Get start and end timestamps for today
      final now = DateTime.now();
      final startOfDay = DateTime(now.year, now.month, now.day);
      final endOfDay = startOfDay.add(const Duration(days: 1));

      // Query transactions for the current day
      QuerySnapshot transactionsSnapshot = await _firestore
          .collection('users')
          .doc(uid)
          .collection('transactions')
          .where('timestamp',
              isGreaterThanOrEqualTo: startOfDay.toIso8601String())
          .where('timestamp', isLessThan: endOfDay.toIso8601String())
          .get();

      // Sum up the transaction amounts
      double totalSpent = transactionsSnapshot.docs.fold(0.0, (sum, doc) {
        final data = doc.data() as Map<String, dynamic>;
        return sum + (data['amount'] ?? 0.0);
      });
      print('Total spent today: $totalSpent');

      return Right(totalSpent);
    } catch (e) {
      return Left("Error calculating daily spending: $e");
    }
  }
}
