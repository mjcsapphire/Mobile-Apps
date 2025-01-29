import 'package:fcfs_banking_app/core/theme/colors.dart';
import 'package:fcfs_banking_app/services/router/routes_name.dart';
import 'package:fcfs_banking_app/src/controllers/theme_controller.dart';
import 'package:fcfs_banking_app/src/views/direct_debit/process_debit_req_screen.dart';
import 'package:fcfs_banking_app/src/views/qr_code/generate_qr.dart';
import 'package:fcfs_banking_app/src/views/widget/custom_button.dart';
import 'package:fcfs_banking_app/src/views/widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

class ReceiveInitialPage extends StatefulWidget {
  const ReceiveInitialPage({super.key});

  @override
  State<ReceiveInitialPage> createState() => _ReceiveInitialPageState();
}

class _ReceiveInitialPageState extends State<ReceiveInitialPage> {
  int _selectedIndex = -1;
  final themeController = Get.find<ThemeController>();
  String qrAmount = '';
  GlobalKey<FormState> qrFormKey = GlobalKey<FormState>();
  TextEditingController qrAmountController = TextEditingController();

  void _onCardTap(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 1.h),
                Text(
                  'Transfer - Receive',
                  style: theme.textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6.h),
                TransferOptionCard(
                    title: 'Receive money from Fantasy app user',
                    subtitle: '',
                    actionText: 'View all options',
                    isSelected: _selectedIndex == 0,
                    onTap: () {
                      _onCardTap(0);
                      _transferReceiveBottomSheet(context);
                    }),
                const SizedBox(height: 20),
                TransferOptionCard(
                  title: 'Request money from Fantasy app user',
                  subtitle: '',
                  actionText: 'View details',
                  isSelected: _selectedIndex == 1,
                  onTap: () {
                    _onCardTap(1);
                    context.pushNamed(RoutesName.requestMoney);
                  },
                ),
                const SizedBox(height: 20),
                TransferOptionCard(
                    title: 'Transfer money from my accounts',
                    subtitle: '',
                    actionText: 'View details',
                    isSelected: _selectedIndex == 2,
                    onTap: () {
                      _onCardTap(2);
                      context.pushNamed(RoutesName.topUpAccount);
                    }),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        context.pop();
                      },
                      child: Text(
                        'Back',
                        style: theme.textTheme.displayMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Handle proceed action
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                      ),
                      child: Text(
                        'Proceed',
                        style: theme.textTheme.displayMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

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

class TransferOptionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String actionText;
  final VoidCallback onTap;
  final bool isSelected;

  const TransferOptionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.actionText,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(
              color: isSelected
                  ? themeController.themeMode == ThemeMode.dark
                      ? Colors.blueAccent
                      : AppColors.bgColor1
                  : Colors.white70,
              width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                title,
                style: theme.textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (subtitle.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  subtitle,
                  style: theme.textTheme.displaySmall
                      ?.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w600),
                ),
              ),
            if (actionText.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  actionText,
                  style: theme.textTheme.displaySmall?.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.blueAccent),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
