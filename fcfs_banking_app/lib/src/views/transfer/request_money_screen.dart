import 'package:cached_network_image/cached_network_image.dart';
import 'package:fcfs_banking_app/core/theme/colors.dart';
import 'package:fcfs_banking_app/core/utils/app_helpers.dart';
import 'package:fcfs_banking_app/core/utils/constant/app_assets_constant.dart';
import 'package:fcfs_banking_app/src/controllers/money_request_controller.dart';
import 'package:fcfs_banking_app/src/controllers/theme_controller.dart';
import 'package:fcfs_banking_app/src/controllers/transaction_controller.dart';
import 'package:fcfs_banking_app/src/controllers/user_controller.dart';
import 'package:fcfs_banking_app/src/models/money_request_model.dart';
import 'package:fcfs_banking_app/src/views/widget/slider_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

class RequestMoneyScreen extends StatefulWidget {
  const RequestMoneyScreen({super.key});

  @override
  State<RequestMoneyScreen> createState() => _RequestMoneyScreenState();
}

class _RequestMoneyScreenState extends State<RequestMoneyScreen> {
  final themeController = Get.find<ThemeController>();
  final userController = Get.find<UserController>();
  final transactionController = Get.find<TransactionController>();
  final paymentController = Get.find<PaymentController>();
  final ScrollController scrollController = ScrollController();

  bool isContactsSelected = true;
  String selectedCountryCode = '+1-268';

  final List<String> countryCodes = [
    '+1-268', // Antigua and Barbuda
    '+1-246', // Barbados
    '+1-441', // Bermuda
    '+1-876', // Jamaica
  ];
  String? selectedBusinessId;
  String selectedBusinessName = '';
  @override
  initState() {
    super.initState();
    userController.fetchAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: themeController.themeMode == ThemeMode.dark
                  ? AppColors.darkAppBarGradient
                  : AppColors.background,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 2.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          context.pop();
                        },
                        color: Colors.white,
                      ),
                      Text(
                        'Request Money',
                        style: theme.textTheme.displayMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 10.w),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildToggleButtons(),
                  const SizedBox(height: 20),
                  isContactsSelected
                      ? _buildContactsView()
                      : _buildPhoneNumberView(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleButtons() {
    return Container(
      height: 40,
      width: MediaQuery.of(context).size.width * 0.6,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white.withOpacity(0.2),
      ),
      child: Row(
        children: [
          _toggleButton('CONTACTS', isContactsSelected, () {
            setState(() {
              isContactsSelected = true;
            });
          }),
          _toggleButton('PHONE NUMBER', !isContactsSelected, () {
            setState(() {
              isContactsSelected = false;
            });
          }),
        ],
      ),
    );
  }

  Widget _toggleButton(String text, bool isSelected, VoidCallback onPressed) {
    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            text,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: isSelected ? Colors.black : Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
    );
  }

  Widget _buildContactsView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'All Contacts',
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 10),
        Container(
          height: MediaQuery.of(context).size.height * 0.75,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: themeController.themeMode == ThemeMode.dark
                ? AppColors.darkStackContainerBackground
                : AppColors.stackContainerBackground,
          ),
          child: Scrollbar(
            thumbVisibility: true,
            interactive: true,
            radius: const Radius.circular(8),
            thickness: 6,
            controller: scrollController,
            child: Obx(() {
              return ListView.builder(
                controller: scrollController,
                padding: EdgeInsets.zero,
                itemCount: userController.allUsers.length,
                itemBuilder: (context, index) {
                  final user = userController.allUsers[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedBusinessId = user.uid;
                          selectedBusinessName =
                              '${user.firstName} ${user.lastName}';
                        });

                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            TextEditingController amountController =
                                TextEditingController();

                            return AlertDialog(
                              backgroundColor: AppColors.darkBgColor2,
                              title: Text(
                                "Request Money",
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Enter amount to request from $selectedBusinessName",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(),
                                  ),
                                  const SizedBox(height: 16),
                                  TextField(
                                    controller: amountController,
                                    keyboardType: TextInputType.number,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                    decoration: InputDecoration(
                                        labelText: "Amount",
                                        labelStyle: Theme.of(context)
                                            .textTheme
                                            .displayMedium,
                                        prefixText: "\$ ",
                                        prefixStyle: Theme.of(context)
                                            .textTheme
                                            .displayMedium,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        )),
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context); // Close the dialog
                                  },
                                  child: Text(
                                    "Cancel",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    if (amountController.text.isNotEmpty) {
                                      double amount = double.tryParse(
                                              amountController.text) ??
                                          0.0;
                                      if (amount > 0) {
                                        MoneyRequest moneyRequest =
                                            MoneyRequest(
                                          requesterId:
                                              userController.user.value!.uid,
                                          receiverId: selectedBusinessId!,
                                          phoneNumber: user.phoneNumber,
                                          name:
                                              "${userController.user.value!.firstName} ${userController.user.value!.lastName}",
                                          amount: amount,
                                          note:
                                              "Requesting money from $selectedBusinessName",
                                          status: "Pending",
                                          date: DateTime.now(),
                                        );

                                        await paymentController
                                            .requestMoney(moneyRequest);

                                        context.pop();
                                      } else {
                                        AppHelpers.toast(
                                            "Please enter a valid amount");
                                      }
                                    } else {
                                      AppHelpers.toast(
                                          "Amount cannot be empty");
                                    }
                                  },
                                  child: Text(
                                    "send",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium
                                        ?.copyWith(color: Colors.white),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: selectedBusinessId == user.uid
                              ? themeController.themeMode == ThemeMode.dark
                                  ? AppColors.blueDark
                                  : AppColors.purple.withOpacity(0.8)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: selectedBusinessId == user.uid
                                ? themeController.themeMode == ThemeMode.dark
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
                              future:
                                  userController.fetchReceiverImage(user.uid),
                              builder: (context, imageSnapshot) {
                                if (imageSnapshot.hasData &&
                                    imageSnapshot.data != null &&
                                    imageSnapshot.data!.isNotEmpty) {
                                  return CircleAvatar(
                                    radius: 24,
                                    backgroundColor: AppColors.white,
                                    backgroundImage: CachedNetworkImageProvider(
                                      imageSnapshot.data!,
                                    ),
                                  );
                                } else {
                                  return const CircleAvatar(
                                    radius: 24,
                                    backgroundColor: AppColors.white,
                                    backgroundImage: AssetImage(
                                      AppAssetsConstant.profile2,
                                    ),
                                  );
                                }
                              },
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                "${user.firstName} ${user.lastName}",
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall
                                    ?.copyWith(
                                      color: AppColors.white,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneNumberView() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.1),
                Colors.white.withOpacity(0.05),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              // Amount Input
              TextField(
                style: Theme.of(context).textTheme.displayLarge,
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                  prefixText: '\$ ',
                  prefixStyle: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  hintText: '0.00',
                  hintStyle: Theme.of(context).textTheme.displayLarge,
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.number,
              ),
              const Divider(color: Colors.white38),
              const SizedBox(height: 20),

              // Phone number input row
              Row(
                children: [
                  // Country code dropdown with flag placeholder
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.black.withOpacity(0.2),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedCountryCode,
                        dropdownColor: Colors.black,
                        icon: const Icon(Icons.arrow_drop_down,
                            color: Colors.white),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18),
                        items: countryCodes.map((code) {
                          return DropdownMenuItem(
                            value: code,
                            child: Row(
                              children: [
                                const Icon(Icons.flag,
                                    color:
                                        Colors.white), // Placeholder flag icon
                                const SizedBox(width: 8),
                                Text(code),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedCountryCode = value!;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Phone Number Input
                  Expanded(
                    child: TextField(
                      style: Theme.of(context).textTheme.displayMedium,
                      textAlign: TextAlign.center,
                      maxLength: 10,
                      decoration: InputDecoration(
                        hintText: '000 000 000',
                        hintStyle:
                            TextStyle(color: Colors.white.withOpacity(0.5)),
                        filled: true,
                        fillColor: Colors.black.withOpacity(0.2),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),

              // Reference Input
              TextField(
                style: Theme.of(context).textTheme.displayMedium,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'Reference',
                  hintStyle:
                      Theme.of(context).textTheme.displayMedium?.copyWith(),
                  filled: true,
                  fillColor: Colors.black.withOpacity(0.2),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.h),
        SlideButton(onPanEnd: (position) {
          print('Slide button pressed');
        }),
      ],
    );
  }
}
