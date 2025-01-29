import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcfs_banking_app/core/theme/colors.dart';
import 'package:fcfs_banking_app/core/utils/app_helpers.dart';
import 'package:fcfs_banking_app/core/utils/constant/app_assets_constant.dart';
import 'package:fcfs_banking_app/services/router/routes_name.dart';
import 'package:fcfs_banking_app/src/controllers/transaction_controller.dart';
import 'package:fcfs_banking_app/src/controllers/user_controller.dart';
import 'package:fcfs_banking_app/src/views/widget/custom_app_bar.dart';
import 'package:fcfs_banking_app/src/views/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

class QrPaymentScreen extends StatefulWidget {
  final String phoneNumber;
  final double amount;

  const QrPaymentScreen({
    super.key,
    required this.phoneNumber,
    required this.amount,
  });

  @override
  State<QrPaymentScreen> createState() => _QrPaymentScreenState();
}

class _QrPaymentScreenState extends State<QrPaymentScreen> {
  final userController = Get.find<UserController>();
  final transactionController = Get.find<TransactionController>();

  String? receiverName;

  @override
  void initState() {
    super.initState();
    fetchReceiverName();
  }

  Future<void> fetchReceiverName() async {
    try {
      var userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('phoneNumber', isEqualTo: widget.phoneNumber)
          .limit(1)
          .get();

      if (userSnapshot.docs.isNotEmpty) {
        var userDoc = userSnapshot.docs.first;
        var firstName = userDoc['firstName'];
        var lastName = userDoc['lastName'];

        setState(() {
          receiverName = "$firstName $lastName";
        });
      } else {
        setState(() {
          receiverName = "Unknown Recipient";
        });
      }
    } catch (e) {
      AppHelpers.toast("Error fetching receiver's name");
      setState(() {
        receiverName = "Unknown Recipient";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar:  CustomAppBar(
        title: "Make Payment",
        showMoreVertIcon: false,
        showNotificationIcon: false,
        showProfilePic: false,
      ),
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppAssetsConstant.upperBackground),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              color: AppColors.black,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Payment title
                Text(
                  "You are paying",
                  style: theme.textTheme.displayMedium
                      ?.copyWith(color: AppColors.white, fontSize: 16.sp),
                ),
                const SizedBox(height: 20),

                // Recipient Info
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.white, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Phone Number
                      Text(
                        widget.phoneNumber,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontSize: 18,
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 1.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 4),
                    const Icon(Icons.verified, color: Colors.green, size: 12),
                    const SizedBox(width: 4),
                    Text(
                      receiverName ?? "Loading...",
                      style: theme.textTheme.bodyLarge
                          ?.copyWith(color: AppColors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Amount
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.white, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "\$${widget.amount.toStringAsFixed(2)}",
                    style: theme.textTheme.displayMedium
                        ?.copyWith(color: AppColors.white),
                  ),
                ),
                const Spacer(),
                // Pay Button
                CustomButtonWidget(
                  onTap: () async {
                    String currentUserId = userController.user.value!.uid;

                    // Ensure that we have a valid user ID
                    if (currentUserId.isEmpty) {
                      AppHelpers.toast('Invalid user');
                      return;
                    }
                    transactionController.payNow(
                        widget.phoneNumber, widget.amount);
                    context.goNamed(RoutesName.mainPage, pathParameters: {
                      'initialIndex': '1',
                    });
                  },
                  width: MediaQuery.of(context).size.width * 0.9,
                  text: "Pay Now",
                  isIconAvailable: false,
                  borderColor: AppColors.pinkColor,
                  fontSize: 17.sp,
                  fontFamily: "Montserrat",
                  color: AppColors.pinkColor,
                  textColor: AppColors.white,
                  radius: 10,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
