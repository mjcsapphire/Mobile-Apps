import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcfs_banking_app/core/theme/colors.dart';
import 'package:fcfs_banking_app/core/theme/radialBg.dart';
import 'package:fcfs_banking_app/core/utils/app_helpers.dart';
import 'package:fcfs_banking_app/services/notification/admin/send_notification.dart';
import 'package:fcfs_banking_app/services/router/routes_name.dart';
import 'package:fcfs_banking_app/src/controllers/idea_submission_controller.dart';
import 'package:fcfs_banking_app/src/controllers/theme_controller.dart';
import 'package:fcfs_banking_app/src/controllers/transaction_controller.dart';
import 'package:fcfs_banking_app/src/controllers/user_controller.dart';
import 'package:fcfs_banking_app/src/models/community_funding_model.dart';
import 'package:fcfs_banking_app/src/models/transactions_model.dart';
import 'package:fcfs_banking_app/src/models/user_model.dart';
import 'package:fcfs_banking_app/src/views/widget/custom_app_bar.dart';
import 'package:fcfs_banking_app/src/views/widget/custom_button.dart';
import 'package:fcfs_banking_app/src/views/widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

class PitchDetailsView extends StatelessWidget {
  final IdeaSubmissionModel idea;

  PitchDetailsView({super.key, required this.idea});

  final UserController userController = Get.find<UserController>();
  final TransactionController transactionController =
      Get.find<TransactionController>();
  IdeaSubmissionController ideaSubmissionController =
      Get.find<IdeaSubmissionController>();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  TextEditingController investmentAmountController = TextEditingController();
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final user = userController.user.value;

    return Scaffold(
      appBar: CustomAppBar(
        title: "Pitch Details",
        showMoreVertIcon: false,
        showNotificationIcon: false,
        showProfilePic: false,
      ),
      body: Stack(
        children: [
          // Background Image
          CustomPaint(
            size: Size(
              MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height,
            ),
            painter: themeController.themeMode == ThemeMode.dark
                ? DarkGradientBackgroundPainter()
                : GradientBackgroundPainter(),
          ),

          // Main Content
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (idea.thumbnailUrl.isNotEmpty)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CachedNetworkImage(
                        imageUrl: idea.thumbnailUrl,
                        fit: BoxFit.cover,
                        height: 30.h,
                        width: double.infinity,
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error, color: AppColors.pinkColor),
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.pinkColor,
                          ),
                        ),
                      ),
                    ),
                  SizedBox(height: 2.h),
                  Text(
                    idea.headline,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 0.6.h),
                  Text(idea.description,
                      style: theme.textTheme.displayMedium
                          ?.copyWith(fontSize: 16.sp)),
                  // SizedBox(height: 1.h),
                  _buildSectionTitle("Purpose", theme),
                  SizedBox(height: 0.6.h),
                  Text(
                    idea.purpose,
                    style: theme.textTheme.displayMedium
                        ?.copyWith(fontSize: 16.sp),
                  ),
                  SizedBox(height: 2.h),
                  _buildSectionTitle("Highlights", theme),
                  SizedBox(height: 1.h),
                  ..._buildBulletPoints(idea.highlights, theme),
                  SizedBox(height: 1.h),
                  _buildSectionTitle("Overview", theme),
                  SizedBox(height: 1.h),
                  ..._buildOverviewDetails(theme),
                  SizedBox(height: 7.h)
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Obx(() {
              if (transactionController.isLoading.value) {
                return const CircularProgressIndicator(
                  color: AppColors.pinkColor,
                );
              }
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: CustomButtonWidget(
                  onTap: () async {
                    // _submitForm(userController.user.value!.uid);
                    if (user.role == "Business") {
                      context.pushNamed(RoutesName.ideaSubmission, extra: idea);
                    } else {
                      _investMoneyBottomSheet(context);
                    }
                  },
                  width: MediaQuery.of(context).size.width * 0.95,
                  text: user!.role == "Business"
                      ? "Edit Pitch Details"
                      : "Invest Now",
                  isIconAvailable: false,
                  fontSize: 16.sp,
                  color: themeController.themeMode == ThemeMode.dark
                      ? AppColors.darkBorderColor
                      : AppColors.red,
                  borderColor: themeController.themeMode == ThemeMode.dark
                      ? AppColors.darkBorderColor
                      : AppColors.red,
                  radius: 8,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, ThemeData theme) {
    return Text(
      title,
      style: theme.textTheme.headlineSmall?.copyWith(
        fontFamily: "Montserrat",
        color: AppColors.pinkColor,
      ),
    );
  }

  List<Widget> _buildBulletPoints(String highlights, ThemeData theme) {
    final bulletPoints = highlights
        .split(',')
        .map((point) => point.trim())
        .where((point) => point.isNotEmpty)
        .toList();
    return bulletPoints
        .map(
          (point) => Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.circle_sharp,
                size: 8,
                color: AppColors.white,
              ),
              SizedBox(width: 0.8.w),
              Expanded(
                child: Text(point,
                    style: theme.textTheme.displayMedium
                        ?.copyWith(fontSize: 16.sp)),
              ),
            ],
          ),
        )
        .toList();
  }

  List<Widget> _buildOverviewDetails(ThemeData theme) {
    return [
      _buildKeyValueRow(
          "Target", "\$${idea.targetAmount.toStringAsFixed(2)}", theme),
      _buildKeyValueRow("Investment Raised",
          "\$${idea.raisedAmount.toStringAsFixed(2)}", theme),
      _buildKeyValueRow("Minimum Investment",
          "\$${idea.minimumInvestment.toStringAsFixed(2)}", theme),
      _buildKeyValueRow("Equity Offered", "${idea.equityOffered}%", theme),
      _buildKeyValueRow("Investment Type", idea.investorRole, theme),
      _buildKeyValueRow("Stage", idea.stage, theme),
    ];
  }

  Widget _buildKeyValueRow(String key, String value, ThemeData theme) {
    return Container(
      margin: EdgeInsets.only(bottom: 0.6.h),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.white.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Text(key,
              style: theme.textTheme.displayMedium?.copyWith(fontSize: 15.sp)),
          const Spacer(),
          Text(
            value,
            style: theme.textTheme.displayMedium?.copyWith(fontSize: 16.sp),
          ),
        ],
      ),
    );
  }

  void _investMoneyBottomSheet(BuildContext context) {
    final user = userController.user.value;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      barrierColor: AppColors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: themeController.themeMode == ThemeMode.dark
                  ? AppColors.darkStackContainerBackground
                  : AppColors.stackContainerBackground,
            ),
            child: DraggableScrollableSheet(
              expand: false,
              maxChildSize: 0.30,
              minChildSize: 0.30,
              initialChildSize: 0.30,
              builder: (context, scrollController) {
                return SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 1.h),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          height: 4,
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Invest Now',
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.88,
                          child: CustomTextField(
                            controller: investmentAmountController,
                            hintText: "Enter investment amount ",
                            obscureText: false,
                            keyboardType: TextInputType.number,
                            cursorColor: AppColors.white,
                            inputTextColor: AppColors.white,
                            hintTextColor: AppColors.white,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter amount';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Center(
                        child: Obx(() {
                          if (transactionController.isLoading.value) {
                            return const CircularProgressIndicator(
                              color: AppColors.pinkColor,
                            );
                          }
                          return CustomButtonWidget(
                            onTap: () async {
                              double? investmentAmountValue = double.tryParse(
                                  investmentAmountController.text);

                              if (investmentAmountValue! <
                                  idea.minimumInvestment) {
                                AppHelpers.toast(
                                    "Minimum investment amount is ${idea.minimumInvestment}");
                                return;
                              }

                              if (investmentAmountController.text.isNotEmpty) {
                                transactionController
                                    .addTransaction(TransactionModel(
                                  id: idea.userId,
                                  userId: userController
                                      .user.value!.uid, // inverstor user id
                                  amount: investmentAmountValue,
                                  description: 'Invested in ${idea.headline}',
                                  date: DateTime.now(),
                                  type: 'debit',
                                  status: 'completed',
                                  recipient: {
                                    'name': idea.headline,
                                    'id': idea.userId
                                  },
                                  fees: 0,
                                ));

                                ideaSubmissionController.updateInvesters(
                                    idea.id, idea.totalInvestors + 1);

                                var senderUserData = await firestore
                                    .collection('users')
                                    .doc(user!.uid)
                                    .get();
                                var senderUser =
                                    UserModel.fromMap(senderUserData.data()!);

                                var receiverUserData = await firestore
                                    .collection('users')
                                    .doc(idea.userId)
                                    .get();
                                var receiverUser =
                                    UserModel.fromMap(receiverUserData.data()!);
                                SendNotification().sendPushNotification(
                                    senderUser,
                                    receiverUser,
                                    "Investment : ${senderUser.firstName} have invested \$$investmentAmountValue in ${idea.headline}");
                                SendNotification().sendPushNotification(
                                    receiverUser,
                                    senderUser,
                                    "Investment : you have invested \$$investmentAmountValue in ${idea.headline}");
                                ideaSubmissionController.updateRaisedMoney(
                                    idea.id, investmentAmountValue);
                                context.pop();
                              } else {
                                AppHelpers.toast("Please enter amount");
                              }
                            },
                            color: themeController.themeMode == ThemeMode.dark
                                ? AppColors.darkBorderColor
                                : AppColors.red,
                            borderColor:
                                themeController.themeMode == ThemeMode.dark
                                    ? AppColors.darkBorderColor
                                    : AppColors.red,
                            width: MediaQuery.of(context).size.width * 0.88,
                            text: "invest now",
                            fontSize: 18.sp,
                            isIconAvailable: false,
                          );
                        }),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
