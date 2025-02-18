import 'package:cached_network_image/cached_network_image.dart';
import 'package:fcfs_banking_app/core/theme/colors.dart';
import 'package:fcfs_banking_app/core/theme/radialBg.dart';
import 'package:fcfs_banking_app/core/utils/app_helpers.dart';
import 'package:fcfs_banking_app/core/utils/constant/app_assets_constant.dart';
import 'package:fcfs_banking_app/services/router/routes_name.dart';
import 'package:fcfs_banking_app/src/controllers/direct_debit_controller.dart';
import 'package:fcfs_banking_app/src/controllers/theme_controller.dart';
import 'package:fcfs_banking_app/src/controllers/transaction_controller.dart';
import 'package:fcfs_banking_app/src/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

class NewDirectDebitRequestScreen extends StatefulWidget {
  const NewDirectDebitRequestScreen({super.key});

  @override
  State<NewDirectDebitRequestScreen> createState() =>
      _NewDirectDebitRequestScreenState();
}

class _NewDirectDebitRequestScreenState
    extends State<NewDirectDebitRequestScreen> {
  final TextEditingController amountController = TextEditingController();
  final DirectDebitController controller = Get.find();
  final UserController userController = Get.find<UserController>();
  final ScrollController scrollController = ScrollController();
  final TransactionController transactionController =
      Get.find<TransactionController>();
  final ThemeController themeController = Get.find<ThemeController>();

  String? selectedBusinessId;
  String selectedBusinessName = '';

  @override
  void initState() {
    super.initState();
    userController.fetchAllUsers();
    userController.fetchBusinessUsers();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Stack(
        children: [
          CustomPaint(
            size: Size(
              MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height,
            ),
            painter: themeController.themeMode == ThemeMode.dark
                ? DarkGradientBackgroundPainter()
                : GradientBackgroundPainter(),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.36,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
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
                    SizedBox(height: 3.h),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: amountController,
                        obscureText: false,
                        maxLines: 1,
                        enabled: true,
                        textAlign: TextAlign.center,
                        cursorColor: AppColors.transparent,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          hintText: "\$0.00",
                          hintStyle: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                          border: InputBorder.none,
                          enabledBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 0.5),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 0.5),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 3.h),

                    Text(
                      user?.role == "Business"
                          ? "${user?.businessName}"
                          : "${user?.firstName} ${user?.lastName}",
                      style: theme.textTheme.displayMedium?.copyWith(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      user?.phoneNumber ?? '',
                      style: theme.textTheme.displayMedium?.copyWith(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),

                    Text(
                      "\$ ${user!.balance}",
                      style: theme.textTheme.displayMedium?.copyWith(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),

                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () {
                              context.pop();
                            },
                            child: Text(
                              "Cancel",
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium
                                  ?.copyWith(
                                    color: AppColors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                            )),
                        TextButton(
                          onPressed: () {
                            // Validate if business is selected
                            if (selectedBusinessId == null ||
                                selectedBusinessId!.isEmpty) {
                              AppHelpers.toast("Please select a business.");
                              return;
                            }
                            // Validate if amount is entered
                            if (amountController.text.isEmpty) {
                              AppHelpers.toast("Please enter an amount.");
                              return;
                            }

                            // Convert amount to double and validate
                            final amount =
                                double.tryParse(amountController.text);
                            if (amount == null || amount <= 0) {
                              AppHelpers.toast(
                                  "Please enter a valid amount greater than 0.");
                              return;
                            }

                            context.pushNamed(
                              RoutesName.processDebitRequestScreen,
                              pathParameters: {
                                'contactName':
                                    selectedBusinessName ?? 'Unknown',
                                'selectedBusinessId':
                                    selectedBusinessId ?? 'Unknown',
                                'amount': amount.toString(),
                              },
                            );

                            selectedBusinessName = '';
                            amountController.clear();
                          },
                          child: Text(
                            "Confirm",
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 1.h)
                  ],
                );
              }),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.4,
            left: 16,
            right: 16,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0.5.w),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: themeController.themeMode == ThemeMode.dark
                            ? AppColors.darkBackground
                            : AppColors.stackContainerBackground2,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Obx(() {
                        if (userController.isLoading.value) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (userController.allUsers.isEmpty) {
                          return Center(
                            child: Text(
                              'No users',
                              style: theme.textTheme.displayMedium?.copyWith(
                                fontSize: 14.sp,
                                fontFamily: "Montserrat",
                                color: Colors.grey,
                              ),
                            ),
                          );
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              decoration: BoxDecoration(
                                  color: themeController.themeMode ==
                                          ThemeMode.dark
                                      ? AppColors.blueDark
                                      : AppColors.purple),
                              child: Text(
                                "Manually type recipient",
                                style: theme.textTheme.displayMedium?.copyWith(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Scrollbar(
                                thumbVisibility: true,
                                interactive: true,
                                radius: const Radius.circular(8),
                                thickness: 6,
                                controller: scrollController,
                                child: ListView.builder(
                                  controller: scrollController,
                                  padding: EdgeInsets.zero,
                                  itemCount: userController.allUsers.length,
                                  itemBuilder: (context, index) {
                                    final allUsers =
                                        userController.allUsers[index];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0, horizontal: 8.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          // Handle user selection
                                          setState(() {
                                            selectedBusinessId = allUsers.uid;
                                            selectedBusinessName =
                                                '${allUsers.firstName} ${allUsers.lastName}';
                                          });
                                          AppHelpers.toast(
                                              "Selected: $selectedBusinessName");
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: selectedBusinessId ==
                                                    allUsers.uid
                                                ? themeController.themeMode ==
                                                        ThemeMode.dark
                                                    ? AppColors.blueDark
                                                    : AppColors.purple
                                                        .withOpacity(0.8)
                                                : Colors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                              color: selectedBusinessId ==
                                                      allUsers.uid
                                                  ? themeController.themeMode ==
                                                          ThemeMode.dark
                                                      ? AppColors.blueDark
                                                      : AppColors.purple
                                                  : Colors.transparent,
                                              width: 1.5,
                                            ),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0, horizontal: 12.0),
                                          child: Row(
                                            children: [
                                              FutureBuilder<String>(
                                                future: userController
                                                    .fetchReceiverImage(
                                                        allUsers.uid),
                                                builder:
                                                    (context, imageSnapshot) {
                                                  if (imageSnapshot.hasData &&
                                                      imageSnapshot.data !=
                                                          null &&
                                                      imageSnapshot
                                                          .data!.isNotEmpty) {
                                                    return CircleAvatar(
                                                      radius: 24,
                                                      backgroundColor:
                                                          AppColors.white,
                                                      backgroundImage:
                                                          CachedNetworkImageProvider(
                                                        imageSnapshot.data!,
                                                      ),
                                                    );
                                                  } else {
                                                    return const CircleAvatar(
                                                      radius: 24,
                                                      backgroundColor:
                                                          AppColors.white,
                                                      backgroundImage:
                                                          AssetImage(
                                                        AppAssetsConstant
                                                            .profile2,
                                                      ),
                                                    );
                                                  }
                                                },
                                              ),
                                              const SizedBox(width: 12),
                                              Expanded(
                                                child: Text(
                                                  "${allUsers.firstName} ${allUsers.lastName}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displaySmall
                                                      ?.copyWith(
                                                        color: AppColors.white,
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
