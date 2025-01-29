import 'package:cached_network_image/cached_network_image.dart';
import 'package:fcfs_banking_app/core/theme/colors.dart';
import 'package:fcfs_banking_app/core/utils/constant/app_assets_constant.dart';
import 'package:fcfs_banking_app/services/router/routes_name.dart';
import 'package:fcfs_banking_app/src/controllers/money_request_controller.dart';
import 'package:fcfs_banking_app/src/controllers/theme_controller.dart';
import 'package:fcfs_banking_app/src/controllers/user_controller.dart';
import 'package:fcfs_banking_app/src/views/widget/slider_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

class RequestReceivedScreen extends StatefulWidget {
  const RequestReceivedScreen({super.key});

  @override
  State<RequestReceivedScreen> createState() => _RequestReceivedScreenState();
}

class _RequestReceivedScreenState extends State<RequestReceivedScreen> {
  final themeController = Get.find<ThemeController>();
  final userController = Get.find<UserController>();
  final paymentController = Get.find<PaymentController>();
  @override
  initState() {
    super.initState();
    paymentController.fetchMoneyRequests();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final user = userController.user.value;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: themeController.themeMode == ThemeMode.dark
                  ? AppColors.darkAppBarGradient
                  : AppColors.background,
            ),
          ),
          Container(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height - 14.h,
              ),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                gradient: themeController.themeMode == ThemeMode.dark
                    ? AppColors.darkStackContainerBackground
                    : AppColors.stackContainerBackground,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Obx(() {
                  final user = userController.user.value;
                  return SingleChildScrollView(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: MediaQuery.of(context).padding.top + 10),
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
                                  : const AssetImage(
                                      AppAssetsConstant.profile2),
                            ),
                          ),
                          const Spacer(),
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
                        ],
                      ),
                      SizedBox(height: 3.h),
                      Obx(() {
                        if (paymentController.moneyRequest.isEmpty) {
                          return Text(
                            "No requests available",
                            style: theme.textTheme.displayMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          );
                        }
                        return Text(
                          paymentController.moneyRequest.last.name,
                          style: theme.textTheme.displayMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        );
                      }),
                      SizedBox(height: 1.h),
                      Obx(() {
                        if (paymentController.moneyRequest.isEmpty) {
                          return Text(
                            "",
                            style: theme.textTheme.displayMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          );
                        }
                        return Text(
                          "has requested \$${paymentController.moneyRequest.last.amount}",
                          style: theme.textTheme.displayMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        );
                      }),
                      SizedBox(height: 3.h),
                      Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                            gradient:
                                themeController.themeMode == ThemeMode.dark
                                    ? AppColors.darkAppBarGradient
                                    : AppColors.background,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            // mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 20),
                                decoration: BoxDecoration(
                                  color: themeController.themeMode ==
                                          ThemeMode.dark
                                      ? Colors.blueGrey
                                      : AppColors.red,
                                  borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(10)),
                                ),
                                child: Text(
                                  'Select account to transfer from',
                                  style: theme.textTheme.displayMedium
                                      ?.copyWith(fontWeight: FontWeight.w500),
                                ),
                              ),
                              SizedBox(
                                height: 30.h,
                                child: SingleChildScrollView(
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    itemCount: 3,
                                    separatorBuilder: (_, __) => const Divider(
                                        color: Colors.white24, thickness: 0.5),
                                    itemBuilder: (context, index) {
                                      return SingleChildScrollView(
                                        child: ListTile(
                                          title: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Account ${index + 1} ',
                                                style: theme
                                                    .textTheme.displayMedium
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w500),
                                              ),
                                              Text(
                                                '00-00-00-00-00',
                                                style: theme
                                                    .textTheme.displayMedium
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 5.h),
                      SlideButton(onPanEnd: (position) {
                        paymentController.payRequestedMoney(
                            paymentController.moneyRequest.last.phoneNumber);
                      }),
                      SizedBox(height: 5.h),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 20.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: Text("amend",
                                  style: theme.textTheme.displayMedium),
                            ),
                            TextButton(
                              onPressed: () {
                                context.pop();
                              },
                              child: Text("Close",
                                  style: theme.textTheme.displayMedium),
                            )
                          ],
                        ),
                      )
                    ],
                  ));
                }),
              ))
        ],
      ),
    );
  }
}
