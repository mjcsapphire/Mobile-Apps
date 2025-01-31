import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcfs_banking_app/services/firebase/user_service.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../models/user_model.dart';

class UserController extends GetxController {
  final UserService _userService = UserService();

  var user = Rx<UserModel?>(null);
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  RxString receiverName = ''.obs;
  RxString receiverName2 = ''.obs;
  RxString receiverProfileImage = ''.obs;
  var dailySpending = 0.0.obs;
  var businessUsers = <UserModel>[].obs;
  var allUsers = <UserModel>[].obs;
  var logger = Logger();

  @override
  void onInit() {
    super.onInit();
    fetchCurrentUserData();
  }

  // Fetch user data by UID with fold for error handling
  Future<void> fetchUserData(String uid) async {
    isLoading.value = true;
    (await _userService.getUserData(uid)).fold(
      (error) {
        errorMessage.value = error;
      },
      (fetchedUser) {
        user.value = fetchedUser;
        errorMessage.value = '';
      },
    );
    isLoading.value = false;
  }

  Future<void> fetchReceiverName(String phoneNumber) async {
    try {
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .where('phoneNumber', isEqualTo: phoneNumber)
          .limit(1)
          .get();

      if (userDoc.docs.isNotEmpty) {
        // If a user is found, get the receiver's name
        final userData = userDoc.docs.first.data();
        receiverName.value = '${userData['firstName']} ${userData['lastName']}';
      } else {
        receiverName.value = "Reciver is not on FCFS Banking App";
      }
    } catch (e) {
      receiverName.value = "Error fetching receiver";
    }
  }

  Future<String> fetchReceiverImage(String phoneNumber) async {
    try {
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .where('phoneNumber', isEqualTo: phoneNumber)
          .limit(1)
          .get();

      if (userDoc.docs.isNotEmpty) {
        // If a user is found, get the receiver's name
        final userData = userDoc.docs.first.data();
        receiverProfileImage.value = '${userData['profileImageUrl']} ';
      }

      return receiverProfileImage.value;
    } catch (e) {
      receiverProfileImage.value = "Error fetching receiver";
      return receiverProfileImage.value;
    }
  }

  Future<String> fetchReceiverName2(String phoneNumber) async {
    try {
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .where('phoneNumber', isEqualTo: phoneNumber)
          .limit(1)
          .get();

      if (userDoc.docs.isNotEmpty) {
        final userData = userDoc.docs.first.data();
        receiverName2.value =
            '${userData['firstName']} ${userData['lastName']}';
      } else {
        receiverName2.value = "Unknown Recipient";
      }

      return receiverName2.value;
    } catch (e) {
      return "Unknown Recipient";
    }
  }

  Future<String> fetchReceiverNameById(String userId) async {
    try {
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userDoc.exists) {
        final userData = userDoc.data();
        return '${userData?['firstName']} ${userData?['lastName']}';
      } else {
        return "Unknown Recipient";
      }
    } catch (e) {
      return "Unknown Recipient";
    }
  }

  // Fetch the current authenticated user's data
  Future<void> fetchCurrentUserData() async {
    isLoading.value = true;
    (await _userService.getCurrentUserData()).fold(
      (error) {
        errorMessage.value = error;
        // print('Error: $error');
        logger.e('Error fetching current user data: $error');
      },
      (currentUser) {
        user.value = currentUser;
        // print('User fetched: ${currentUser.firstName} ${currentUser.uid}');
        logger.i('User fetched: ${currentUser.firstName} ${currentUser.uid}');
        errorMessage.value = '';
      },
    );
    isLoading.value = false;
  }

  // Update user data by UID with fold for error handling
  Future<void> updateUserData(Map<String, dynamic> data) async {
    isLoading.value = true;
    if (user.value != null) {
      (await _userService.updateUserData(user.value!.uid, data)).fold(
        (error) {
          errorMessage.value = error;
        },
        (_) async {
          await fetchUserData(user.value!.uid); // Refresh user data
          errorMessage.value = '';
        },
      );
    }
    isLoading.value = false;
  }

  // Delete current user data with fold for error handling
  Future<void> deleteUserData() async {
    isLoading.value = true;
    if (user.value != null) {
      (await _userService.deleteUserData(user.value!.uid)).fold(
        (error) {
          errorMessage.value = error;
        },
        (_) {
          user.value = null;
          errorMessage.value = '';
        },
      );
    }
    isLoading.value = false;
  }

  Future<void> updateDailyLimit(double limit) async {
    isLoading.value = true;
    if (user.value != null) {
      // Update the daily limit in Firestore
      final data = {'dailyLimit': limit};
      (await _userService.updateUserData(user.value!.uid, data)).fold(
        (error) {
          errorMessage.value = error;
        },
        (_) async {
          await fetchUserData(user.value!.uid); // Refresh user data
          errorMessage.value = '';
        },
      );
    }
    isLoading.value = false;
  }

  // update monthly limit
  Future<void> updateMonthlyLimit(double limit) async {
    isLoading.value = true;
    if (user.value != null) {
      // Update the daily limit in Firestore
      final data = {'monthlyLimit': limit};
      (await _userService.updateUserData(user.value!.uid, data)).fold(
        (error) {
          errorMessage.value = error;
        },
        (_) async {
          await fetchUserData(user.value!.uid); // Refresh user data
          errorMessage.value = '';
        },
      );
    }
    isLoading.value = false;
  }

  Future<void> fetchBusinessUsers() async {
    isLoading.value = true;
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('role', isEqualTo: 'Business')
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        businessUsers.value = querySnapshot.docs
            .map((doc) => UserModel.fromMap(doc.data()))
            .toList();
      } else {
        businessUsers.clear();
      }
    } catch (e) {
      errorMessage.value = "Error fetching business users: $e";
      logger.e('Error fetching business users: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchAllUsers() async {
    isLoading.value = true;
    try {
      final querySnapshot =
          await FirebaseFirestore.instance.collection('users').get();

      if (querySnapshot.docs.isNotEmpty) {
        allUsers.value = querySnapshot.docs
            .map((doc) => UserModel.fromMap(doc.data()))
            .toList();
      } else {
        allUsers.clear();
      }
    } catch (e) {
      errorMessage.value = "Error fetching all users: $e";
      logger.e('Error fetching all users: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<String> fetchUserName(String id) async {
    try {
      final userDoc =
          await FirebaseFirestore.instance.collection('users').doc(id).get();
      final userData = userDoc.data();

      if (userData != null) {
        if (userData['role'] == 'Business') {
          return userData['businessName'] ?? 'Business User';
        } else {
          return '${userData['firstName']}${userData['lastName']}' ?? 'User';
        }
      } else {
        return 'User not found';
      }
    } catch (e) {
      logger.e('Error fetching user: $e');
      return 'Error fetching user';
    }
  }

  Future<void> updateFcmToken(String fcmToken) async {
    _userService.addFcmToken(user.value!.uid, fcmToken);
  }

  // fetch daily spent amount
  Future<void> fetchDailySpending(String uid) async {
    isLoading.value = true;
    errorMessage.value = '';

    final result = await _userService.getDailySpending(uid);

    result.fold(
      (error) {
        // Handle error
        errorMessage.value = error;
        dailySpending.value = 0.0;
      },
      (totalSpent) {
        dailySpending.value = totalSpent;
      },
    );

    isLoading.value = false;
  }
}
