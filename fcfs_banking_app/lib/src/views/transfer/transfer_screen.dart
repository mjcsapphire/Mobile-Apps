import 'package:action_slider/action_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fcfs_banking_app/core/theme/colors.dart';
import 'package:fcfs_banking_app/core/theme/radialBg.dart';
import 'package:fcfs_banking_app/core/utils/constant/app_assets_constant.dart';
import 'package:fcfs_banking_app/services/router/routes_name.dart';
import 'package:fcfs_banking_app/src/controllers/theme_controller.dart';
import 'package:fcfs_banking_app/src/controllers/transaction_controller.dart';
import 'package:fcfs_banking_app/src/controllers/user_controller.dart';
import 'package:fcfs_banking_app/src/views/payment_success_page.dart';
import 'package:fcfs_banking_app/src/views/qr_code/generate_qr.dart';
import 'package:fcfs_banking_app/src/views/widget/custom_button.dart';
import 'package:fcfs_banking_app/src/views/widget/custom_textfield.dart';
import 'package:fcfs_banking_app/src/views/widget/slider_button.dart';
import 'package:fcfs_banking_app/src/views/widget/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  UserController userController = Get.find<UserController>();
  ThemeController themeController = Get.find<ThemeController>();
  TransactionController transactionController =
      Get.find<TransactionController>();
  TextEditingController qrAmountController = TextEditingController();
  TextEditingController receiverNameController = TextEditingController();

  String qrAmount = '';
  TextEditingController amountController = TextEditingController();
  String amount = '';
  String? receiverName;
  String accountIdentifier = "";
  TextEditingController accountIdentifierController = TextEditingController();

  final _controller = ActionSliderController();

  GlobalKey<FormState> qrFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final recentSentTransactions = transactionController.transactions
        .where((transaction) => transaction.type == 'debit')
        .toList();

    // A Set to track unique recipients based on their ID
    final Set<String> displayedRecipientIds = {};
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
        Column(
          children: [
            // Top Container with Gradient and Rounded Borders
            Container(
              height: MediaQuery.of(context).size.height * 0.37,
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
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.h),
                      // Balance Box
                      Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          width: MediaQuery.of(context).size.width * 0.6,
                          height: MediaQuery.of(context).size.height * 0.15,
                          decoration: BoxDecoration(
                            color: AppColors.textEditingBoxColor,
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(color: AppColors.white, width: 1),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Current Balance",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                        color: AppColors.white,
                                        fontSize: 15.sp),
                              ),
                              const Spacer(),
                              Center(
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            '\$${transactionController.totalBalance.value.floor()}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineLarge
                                            ?.copyWith(
                                                color:
                                                    themeController.themeMode ==
                                                            ThemeMode.dark
                                                        ? AppColors.white
                                                        : AppColors.red,
                                                fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text:
                                            '.${(transactionController.totalBalance.value % 1).toStringAsFixed(2).substring(2)}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium
                                            ?.copyWith(
                                                color: AppColors.white,
                                                fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Text(
                                "**** **** **** 9765",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                        color: AppColors.white,
                                        fontSize: 15.sp),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 5.h),
                      // Send and Receive Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 5.h,
                            child: CustomButtonWidget(
                              onTap: () {
                                // _manuallyTransferSendBottomSheet(context);
                                context.pushNamed(
                                    RoutesName.newDirectDebitRequestScreen);
                              },
                              width: MediaQuery.of(context).size.width * 0.3,
                              text: "Send",
                              isIconAvailable: false,
                              color: themeController.themeMode == ThemeMode.dark
                                  ? AppColors.darkBorderColor
                                  : AppColors.purple,
                              borderColor:
                                  themeController.themeMode == ThemeMode.dark
                                      ? AppColors.darkBorderColor
                                      : AppColors.purple,
                              fontSize: 16.sp,
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                            child: CustomButtonWidget(
                              onTap: () {
                                // _transferReceiveBottomSheet(context);
                                context.pushNamed(RoutesName.receiveInitial);
                              },
                              width: MediaQuery.of(context).size.width * 0.3,
                              text: "Receive",
                              isIconAvailable: false,
                              color: themeController.themeMode == ThemeMode.dark
                                  ? AppColors.darkBorderColor
                                  : AppColors.purple,
                              borderColor:
                                  themeController.themeMode == ThemeMode.dark
                                      ? AppColors.darkBorderColor
                                      : AppColors.purple,
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }),
              ),
            ),
            SizedBox(height: 2.h),
            // Quick Transfer Section and Subsequent Data
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 4.w),
                    child: Text(
                      "Quick Transfer",
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium
                          ?.copyWith(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Expanded(
                    child: ListView.builder(
                      itemCount: recentSentTransactions.length,
                      itemBuilder: (context, index) {
                        final transaction = recentSentTransactions[index];
                        print(
                            "Transaction Recipient: ${transaction.recipient}");

                        // Extract recipient ID safely
                        final recipientId = transaction.recipient != null &&
                                transaction.recipient!.isNotEmpty &&
                                transaction.recipient!.containsKey('id')
                            ? transaction.recipient!['id']
                            : null;

                        if (recipientId == null ||
                            displayedRecipientIds.contains(recipientId)) {
                          return const SizedBox.shrink();
                        } else {
                          displayedRecipientIds.add(recipientId);
                        }

                        return FutureBuilder<String>(
                          future:
                              userController.fetchReceiverName2(recipientId),
                          builder: (context, snapshot) {
                            String userName = 'Unknown'; // Default value

                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.hasData &&
                                  snapshot.data!.isNotEmpty) {
                                userName = snapshot.data!;
                              }
                            }

                            return Container(
                              margin: const EdgeInsets.only(
                                  left: 16, right: 16, bottom: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.white, width: 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListTile(
                                contentPadding: EdgeInsets.all(2.w),
                                leading: FutureBuilder<String>(
                                  future: userController
                                      .fetchReceiverImage(recipientId),
                                  builder: (context, imageSnapshot) {
                                    if (imageSnapshot.hasData &&
                                        imageSnapshot.data != null &&
                                        imageSnapshot.data!.isNotEmpty) {
                                      return CircleAvatar(
                                        maxRadius: 20,
                                        backgroundImage:
                                            CachedNetworkImageProvider(
                                                imageSnapshot.data!),
                                      );
                                    } else {
                                      return const CircleAvatar(
                                        maxRadius: 20,
                                        backgroundImage: AssetImage(
                                            AppAssetsConstant.profile2),
                                      );
                                    }
                                  },
                                ),
                                title: Text(
                                  userName,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall
                                      ?.copyWith(fontSize: 16.sp),
                                ),
                                onTap: () {
                                  _manuallyTransferSendBottomSheet(context);
                                },
                              ),
                            );
                          },
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    ));
  }

  // receive money bottom sheet
  void _transferReceiveBottomSheet(BuildContext context) {
    final user = userController.user.value;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      barrierColor: AppColors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            gradient: themeController.themeMode == ThemeMode.dark
                ? AppColors.darkStackContainerBackground
                : AppColors.stackContainerBackground,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: DraggableScrollableSheet(
            expand: false,
            maxChildSize: 0.55,
            minChildSize: 0.55,
            initialChildSize: 0.55,
            builder: (context, scrollController) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 1.h),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppColors.textGreyColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Transfer - Receive ',
                      style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Montserrat",
                          color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Phone Number: ${user!.phoneNumber}",
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium
                          ?.copyWith(
                              color: AppColors.white,
                              fontSize: 16.sp,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Align(
                    alignment: Alignment.center,
                    child: qrAmount.isEmpty
                        ? Opacity(
                            opacity: 0.6,
                            child: QRGeneratorWidget(
                              amount: 0.0,
                              phoneNumber: user.phoneNumber,
                              size: 250,
                              color: themeController.themeMode == ThemeMode.dark
                                  ? AppColors.white
                                  : AppColors.black,
                            ),
                          )
                        : QRGeneratorWidget(
                            amount: double.tryParse(qrAmount) ?? 0.0,
                            phoneNumber: user.phoneNumber,
                            size: 250,
                            color: themeController.themeMode == ThemeMode.dark
                                ? AppColors.white
                                : AppColors.black,
                          ),
                  ),
                  SizedBox(height: 1.h),
                  Align(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () {
                        _showSetAmountDialog();
                      },
                      child: Text(
                        qrAmount.isEmpty
                            ? 'Set Amount'
                            : '\$$qrAmount - Change Amount',
                        style:
                            Theme.of(context).textTheme.displayMedium?.copyWith(
                                  color: AppColors.white,
                                  fontSize: 16.sp,
                                  fontFamily: "Montserrat",
                                ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  void _manuallyTransferSendBottomSheet(BuildContext context) {
    final theme = Theme.of(context);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      barrierColor: AppColors.transparent,
      // backgroundColor: AppColors.black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              gradient: themeController.themeMode == ThemeMode.dark
                  ? AppColors.darkStackContainerBackground
                  : AppColors.stackContainerBackground,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: DraggableScrollableSheet(
                expand: false,
                maxChildSize: 0.8,
                initialChildSize: 0.53,
                minChildSize: 0.53,
                builder: (context, scrollController) {
                  return SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 3.h),
                        Text(
                          "Send Manually",
                          style: theme.textTheme.headlineMedium,
                        ),
                        SizedBox(height: 3.h),
                        TextfieldWidget(
                          label: "Account Identifier ",
                          controller: accountIdentifierController,
                          keyboardType: TextInputType.text,
                          obscureText: false,
                          textAlign: TextAlign.start,
                          floatingLabelAlignment: FloatingLabelAlignment.start,
                          onChanged: (value) {
                            setState(() {
                              accountIdentifier = value;
                            });
                            userController.fetchReceiverName(value);
                          },
                        ),
                        SizedBox(height: 0.6.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(width: 4),
                            userController.receiverName.value.isNotEmpty
                                ? const Icon(Icons.verified,
                                    color: Colors.green, size: 12)
                                : const SizedBox.shrink(),
                            const SizedBox(width: 4),
                            Text(
                              userController.receiverName.value.toString() ??
                                  "Loading...",
                              style: theme.textTheme.bodyLarge
                                  ?.copyWith(color: AppColors.white),
                            ),
                          ],
                        ),
                        SizedBox(height: 1.h),
                        TextfieldWidget(
                          label: "Receiver Name",
                          controller: receiverNameController,
                          keyboardType: TextInputType.name,
                          obscureText: false,
                          floatingLabelAlignment: FloatingLabelAlignment.start,
                          textAlign: TextAlign.start,
                          onChanged: (value) {
                            setState(() {
                              accountIdentifier = value;
                            });
                            userController.fetchReceiverName(value);
                          },
                        ),
                        SizedBox(height: 2.h),
                        TextfieldWidget(
                          label: "Amount",
                          controller: amountController,
                          keyboardType: TextInputType.number,
                          obscureText: false,
                          textAlign: TextAlign.start,
                          floatingLabelAlignment: FloatingLabelAlignment.start,
                          onChanged: (value) {
                            setState(() {
                              accountIdentifier = value;
                            });
                            userController.fetchReceiverName(value);
                          },
                        ),
                        SizedBox(height: 3.h),
                        SlideButton(onPanEnd: (position) async {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return const PaymentConfirmation();
                            },
                          ));
                          await Future.delayed(const Duration(seconds: 1));
                          double? amount =
                              double.tryParse(amountController.text);
                          transactionController.payNow(
                              accountIdentifier, amount!);
                        }),
                        const SizedBox(height: 30),
                      ],
                    ),
                  );
                }));
      },
    );
  }

//  rows of the keypad
  Widget _buildKeypadRow(
      BuildContext context, List<String> values, Function(String) onKeyTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: values.map((value) {
          return _buildKeypadButton(context, value, onKeyTap);
        }).toList(),
      ),
    );
  }

//  individual keypad button
  Widget _buildKeypadButton(
      BuildContext context, String value, Function(String) onKeyTap) {
    return GestureDetector(
      onTap: () => onKeyTap(value),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.white, width: 1),
        ),
        child: Center(
          child: Text(
            value,
            style: const TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  void _showSetAmountDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 200,
          child: AlertDialog(
            backgroundColor: themeController.themeMode == ThemeMode.dark
                ? AppColors.grey
                : AppColors.white,
            title: Text(
              "Set Amount for QR",
              style: TextStyle(
                  color: themeController.themeMode == ThemeMode.dark
                      ? Colors.white
                      : Colors.black,
                  fontSize: 16),
            ),
            content: SizedBox(
              height: 130,
              child: Column(
                children: [
                  Form(
                    key: qrFormKey,
                    child: CustomTextField(
                      controller: qrAmountController,
                      hintText: "Enter amount",
                      cursorColor: AppColors.black,
                      obscureText: false,
                      inputTextColor: AppColors.black,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter amount";
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 2.h),
                  CustomButtonWidget(
                    onTap: () {
                      if (qrFormKey.currentState!.validate()) {
                        setState(() {
                          qrAmount = qrAmountController.text;
                          context.pop();
                          context.pop();
                        });
                      }
                    },
                    width: MediaQuery.of(context).size.width * 0.5,
                    text: "Set Amount",
                    isIconAvailable: false,
                    color: AppColors.pinkColor,
                    textColor: AppColors.white,
                    fontSize: 16.sp,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
