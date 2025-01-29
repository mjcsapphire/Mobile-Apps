import 'package:cached_network_image/cached_network_image.dart';
import 'package:fcfs_banking_app/core/theme/colors.dart';
import 'package:fcfs_banking_app/core/theme/radialBg.dart';
import 'package:fcfs_banking_app/core/utils/constant/app_assets_constant.dart';
import 'package:fcfs_banking_app/services/router/routes_name.dart';
import 'package:fcfs_banking_app/src/controllers/direct_debit_controller.dart';
import 'package:fcfs_banking_app/src/controllers/theme_controller.dart';
import 'package:fcfs_banking_app/src/controllers/user_controller.dart';
import 'package:fcfs_banking_app/src/views/widget/slider_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

class ProcessDebitReqScreen extends StatefulWidget {
  final String contactName;
  final String selectedBusinessId;
  final double amount;
  const ProcessDebitReqScreen({
    super.key,
    required this.contactName,
    required this.selectedBusinessId,
    required this.amount,
  });

  @override
  State<ProcessDebitReqScreen> createState() => _ProcessDebitReqScreenState();
}

Rx<String> frequency = "".obs;
Rx<bool> isFrequencySelected = false.obs;
Rx<bool> showFrequencyCalendar = false.obs;
final isPamentConfirmed = false.obs;
final UserController userController = Get.find<UserController>();
ThemeController themeController = Get.find<ThemeController>();
final DirectDebitController directDebitController =
    Get.find<DirectDebitController>();

String? selectedBusinessId;
double? amount;

class _ProcessDebitReqScreenState extends State<ProcessDebitReqScreen> {
  bool isEnabled = false;
  @override
  void initState() {
    super.initState();
    selectedBusinessId = widget.selectedBusinessId;
    amount = widget.amount;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          CustomPaint(
            size: Size(
              MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height,
            ),
            painter: themeController.themeMode == ThemeMode.dark
                ? DarkGradientBackgroundPainter()
                : GradientBackgroundPainter(),
          ),
          // Main content
          Container(
            height: MediaQuery.of(context).size.height * 0.8,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
              gradient: themeController.themeMode == ThemeMode.dark
                  ? AppColors.darkStackContainerBackground
                  : AppColors.stackContainerBackground,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Obx(() {
                final user = userController.user.value;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).padding.top + 10),
                    // Header Icons
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.pushNamed(RoutesName.profileScreen);
                          },
                          child: CircleAvatar(
                            radius: 5.w,
                            backgroundColor: Colors.white24,
                            backgroundImage: user?.profileImageUrl != null
                                ? CachedNetworkImageProvider(
                                    user!.profileImageUrl!)
                                : const AssetImage(AppAssetsConstant.profile2),
                          ),
                        ),
                        const Spacer(),
                        SizedBox(width: 10.w),
                        GestureDetector(
                          onTap: () {
                            context.pushNamed(RoutesName.scanScreen);
                          },
                          child: Icon(Icons.qr_code,
                              color: Colors.white, size: 8.w),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: Image.asset(
                            AppAssetsConstant.notification,
                            width: 6.w,
                          ),
                          onPressed: () {
                            context.pushNamed(RoutesName.notificationScreen);
                          },
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () {},
                          child: const Icon(Icons.more_vert,
                              color: Colors.white, size: 30),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      user?.role == "Business"
                          ? "${user?.businessName}"
                          : "${user?.firstName} ${user?.lastName}",
                      style: theme.textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      user?.phoneNumber ?? '',
                      style: theme.textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 3.5.h),

                    Text(
                      "Transfer \$${widget.amount} ",
                      style: theme.textTheme.displayMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 3.5.h),

                    Text(
                      "to",
                      style: theme.textTheme.displayMedium
                          ?.copyWith(fontWeight: FontWeight.normal),
                    ),
                    SizedBox(height: 3.5.h),

                    Text(
                      "${widget.contactName}?",
                      style: theme.textTheme.displayMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 4.h),

                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: buildPermissionTile(
                        theme,
                        permission: 'Make a standing order',
                        isEnabled: isEnabled,
                        onChanged: (newValue) {
                          setState(() {
                            isEnabled = !isEnabled;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 1.h),

                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Frequency",
                            style: theme.textTheme.displayMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          Row(
                            children: [
                              isFrequencySelected.value
                                  ? Text(
                                      frequency.value,
                                      style: theme.textTheme.displayMedium
                                          ?.copyWith(
                                              fontWeight: FontWeight.w600),
                                    )
                                  : const SizedBox.shrink(),
                              SizedBox(width: 2.w),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    showFrequencyCalendar.value =
                                        !showFrequencyCalendar.value;
                                  });
                                },
                                icon: Icon(
                                  Icons.calendar_month_outlined,
                                  color: AppColors.white,
                                  size: 24.sp,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 2.h),
                    isFrequencySelected.value
                        ? SlideButton(
                            onPanEnd: (position) {
                              directDebitController.sendRequest(
                                personalUserId: user!.uid,
                                businessUserId: selectedBusinessId!,
                                amount: amount!,
                                requestType: isEnabled
                                    ? RequestType.standingOrder
                                    : RequestType.directDebit,
                              );
                              context.pushNamed(RoutesName.paymentSuccess);
                            },
                          )
                        : const SizedBox.shrink(),

                    const Spacer(),
                    TextButton(
                        onPressed: () {
                          context.pop();
                          context.pop();
                        },
                        child:
                            Text("Back", style: theme.textTheme.displayMedium)),
                    SizedBox(height: 1.h),
                  ],
                );
              }),
            ),
          ),
          if (showFrequencyCalendar.value)
            Positioned(
              top: MediaQuery.of(context).size.height * 0.51,
              left: 15.w,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    showFrequencyCalendar.value = !showFrequencyCalendar.value;
                  });
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.7,
                  color: Colors.transparent,
                  child: frequencyCalendar(context),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

Widget buildPermissionTile(
  ThemeData theme, {
  required String permission,
  required bool isEnabled,
  required ValueChanged<bool> onChanged,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              permission,
              style: theme.textTheme.displayMedium
                  ?.copyWith(fontSize: 18.sp, fontWeight: FontWeight.w600),
            ),
            Switch(
              activeColor: AppColors.white,
              value: isEnabled,
              onChanged: onChanged,
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: Colors.transparent,
              activeTrackColor: AppColors.secondaryColor,
            ),
          ],
        ),
      ],
    ),
  );
}

Widget frequencyCalendar(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: themeController.themeMode == ThemeMode.dark
          ? AppColors.darkBgColor2
          : AppColors.purple,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        bottomLeft: Radius.circular(20),
      ),
    ),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                Icons.calendar_month_outlined,
                color: Colors.white,
                size: 24.sp,
              ),
            ],
          ),
          GestureDetector(
              onTap: () {
                frequency.value = "Weekly";
                isFrequencySelected.value = true;
                showFrequencyCalendar.value = !showFrequencyCalendar.value;
              },
              child: Text("Weekly",
                  style: Theme.of(context).textTheme.displayMedium)),
          const SizedBox(height: 8),
          GestureDetector(
              onTap: () {
                frequency.value = "2 Weeks";
                isFrequencySelected.value = true;
                showFrequencyCalendar.value = !showFrequencyCalendar.value;
              },
              child: Text("Every 2 Weeks",
                  style: Theme.of(context).textTheme.displayMedium)),
          const SizedBox(height: 8),
          GestureDetector(
              onTap: () {
                frequency.value = "Monthly";
                isFrequencySelected.value = true;
                showFrequencyCalendar.value = !showFrequencyCalendar.value;
              },
              child: Text("Monthly",
                  style: Theme.of(context).textTheme.displayMedium)),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () {
              frequency.value = "Custom";
              isFrequencySelected.value = true;
              showFrequencyCalendar.value = !showFrequencyCalendar.value;
            },
            child: Text("Custom",
                style: Theme.of(context).textTheme.displayMedium),
          ),
        ],
      ),
    ),
  );
}

class RequestType {
  static const String standingOrder = "StandingOrder";
  static const String directDebit = "DirectDebit";
}
