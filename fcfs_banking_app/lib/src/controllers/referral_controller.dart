import 'package:fcfs_banking_app/services/firebase/referral_service.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class ReferralController extends GetxController {
  final ReferralService _referralService = ReferralService();
  var logger = Logger();
  RxString userReferralCode = ''.obs;
  RxBool loading = false.obs;
  RxString errorMessage = ''.obs;
  RxString successMessage = ''.obs;

  // Initialize referral data for a new user
  Future<void> initializeReferral(String userId) async {
    loading.value = true;
    try {
      await _referralService.initializeReferral(userId);
      successMessage.value = 'Referral code initialized successfully!';
    } catch (e) {
      logger.e('Error initializing referral: $e');
      errorMessage.value = 'Error initializing referral: $e';
    } finally {
      loading.value = false;
    }
  }

  // fetch user referral code
  Future<void> fetchUserReferralCode(String userId) async {
    loading.value = true;
    try {
      userReferralCode.value =
          await _referralService.fetchUserReferralCode(userId);
    } catch (e) {
      logger.e('Error fetching user referral code: $e');
      errorMessage.value = 'Error fetching user referral code: $e';
    } finally {
      loading.value = false;
    }
  }

  // Redeem referral code
  Future<void> redeemReferralCode(
      String referredUserId, String referralCode) async {
    loading.value = true;
    try {
      await _referralService.redeemReferralCode(referredUserId, referralCode);
      successMessage.value = 'Referral code redeemed successfully!';
    } catch (e) {
      logger.e('Error redeeming referral code: $e');
      errorMessage.value = 'Error redeeming referral code: $e';
    } finally {
      loading.value = false;
    }
  }
}
