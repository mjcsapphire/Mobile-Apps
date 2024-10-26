import 'package:action_slider/action_slider.dart';
import 'package:fcfs_banking_app/core/theme/colors.dart';
import 'package:fcfs_banking_app/core/utils/constant/app_assets_constant.dart';
import 'package:fcfs_banking_app/services/router/routes_name.dart';
import 'package:fcfs_banking_app/src/views/widget/custom_app_bar.dart';
import 'package:fcfs_banking_app/src/views/widget/custom_button.dart';
import 'package:fcfs_banking_app/src/views/widget/custom_textfield.dart';
import 'package:fcfs_banking_app/src/views/widget/dummy/people.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
// import 'package:slider_button/slider_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController accountIdentifierController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  String amount = '';
  final _controller = ActionSliderController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: CustomAppBar(
        profilePicUrl: AppAssetsConstant.profile,
        title: 'Percy Jackson',
        onNotificationTap: () {
          // Handle notification tap
          context.pushNamed(RoutesName.notificationScreen);
        },
        onMoreVertTap: () {
          // Handle more_vert tap
        },
        onProfileTap: () {
          context.pushNamed(RoutesName.profileScreen);
        },
      ),
      body: Stack(children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppAssetsConstant.upperBackground),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: const BoxDecoration(
              color: AppColors.black,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Name of company',
                                style: theme.textTheme.bodyLarge?.copyWith(
                                    color: AppColors.textGreyColor,
                                    fontSize: 13.sp),
                              ),
                              const SizedBox(height: 10),
                              Text('\$4,223.22',
                                  style: theme.textTheme.headlineLarge),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('+32% ↗',
                                  style: theme.textTheme.headlineSmall
                                      ?.copyWith(
                                          color: Colors.green,
                                          fontSize: 16.sp)),
                              const SizedBox(height: 5),
                              Text(
                                'Less spending this month',
                                style: theme.textTheme.titleLarge?.copyWith(
                                    color: AppColors.textGreyColor,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _actionButton(
                            'Top Up',
                            Icons.add,
                            onpressed: () {},
                          ),
                          _actionButton(
                            'Send',
                            Icons.call_made_sharp,
                            onpressed: () {
                              _transferSendBottomSheet(context);
                            },
                          ),
                          _actionButton(
                            'Receive',
                            Icons.call_received,
                            onpressed: () {
                              _transferReceiveBottomSheet(context);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 1.h),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.black,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 8, right: 10, left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Recent Activity',
                                style: theme.textTheme.displayMedium?.copyWith(
                                  fontSize: 16.sp,
                                  fontFamily: "RobotoMono",
                                )),
                            TextButton(
                                onPressed: () {
                                  _showTransactions(context);
                                },
                                child: Text('See all',
                                    style:
                                        theme.textTheme.displayMedium?.copyWith(
                                      fontSize: 14.sp,
                                      fontFamily: "RobotoMono",
                                    )))
                          ],
                        ),
                      ),
                      SizedBox(height: 1.h),
                      ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          _activityItem('Microsoft', '\$5.99',
                              AppAssetsConstant.microsoft, "Jan 5th 2024"),
                          _activityItem('Amazon inc', '\$2.99',
                              AppAssetsConstant.amazon, "Jan 5th 2024"),
                          _activityItem('Transfer - Send', '\$12.39',
                              AppAssetsConstant.arrow, "Jan 5th 2024"),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 1.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _actionButton(
                      'Set Limit',
                      Icons.arrow_upward,
                      onpressed: () {},
                    ),
                    _actionButton(
                      'Refferal',
                      Icons.emoji_people_rounded,
                      onpressed: () {
                        context.pushNamed(RoutesName.referralScreen);
                      },
                    ),
                    _actionButton(
                      'Help',
                      Icons.help_outline_sharp,
                      onpressed: () {},
                    ),
                  ],
                ),
                SizedBox(height: 1.h),
                _promoCard('Refer to earn',
                    'Refer a friend and both you and them receive rewards.',
                    onTap: () {
                  context.pushNamed(RoutesName.referralScreen);
                }),
                _promoCard('Learn how to budget',
                    'Get quick tips on how to manage money using our features.',
                    onTap: () {}),
                _promoCard('Learn how to save',
                    'Save money using our tools, gain interest and manage your finances.',
                    onTap: () {}),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Widget _actionButton(String label, IconData icon,
      {required VoidCallback onpressed}) {
    final theme = Theme.of(context);
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.28,
      child: OutlinedButton.icon(
        iconAlignment: IconAlignment.end,
        onPressed: onpressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          side: const BorderSide(color: Colors.white),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        icon: Icon(icon, size: 16),
        label: Text(
          label,
          style: theme.textTheme.titleLarge?.copyWith(fontSize: 14.sp),
        ),
      ),
    );
  }

  Widget _activityItem(
      String title, String amount, String imageUrl, String date) {
    return ListTile(
      leading: Image(
        image: AssetImage(imageUrl),
        height: 30,
        width: 30,
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .displayMedium
                ?.copyWith(fontSize: 15.sp, color: AppColors.pinkColor),
          ),
          Text(
            date,
            style: Theme.of(context)
                .textTheme
                .displayMedium
                ?.copyWith(fontSize: 14.sp, color: AppColors.textGreyColor),
          ),
        ],
      ),
      trailing: Text(
        "- $amount",
        style: Theme.of(context)
            .textTheme
            .displayMedium
            ?.copyWith(fontSize: 16.sp, color: AppColors.lightRed),
      ),
    );
  }

  Widget _promoCard(String title, String description,
      {required VoidCallback onTap}) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.textGreyColor)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontSize: 16.sp,
                      color: AppColors.pinkColor,
                      fontFamily: "RobotoMono",
                    ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Text(
                  description,
                  // maxLines: 2,
                  overflow: TextOverflow.visible,
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontSize: 14.5.sp, color: AppColors.textGreyColor),
                ),
              ),
            ],
          ),
          Align(
              alignment: Alignment.centerRight,
              child: CustomButtonWidget(
                onTap: onTap,
                width: 100,
                text: "Learn More",
                isIconAvailable: false,
              )),
        ],
      ),
    );
  }

  void _transferSendBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      barrierColor: AppColors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: false,
          maxChildSize: 0.72,
          minChildSize: 0.72,
          initialChildSize: 0.72,
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
                    'Transfer - Send ',
                    style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w500,
                        fontFamily: "RobotoMono",
                        color: Colors.black),
                  ),
                ),
                SizedBox(height: 1.h),
                Align(
                  alignment: Alignment.center,
                  child: CustomButtonWidget(
                    onTap: () {
                      _manuallyTransferSendBottomSheet(context);
                    },
                    width: MediaQuery.of(context).size.width * 0.9,
                    text: "Send Manually",
                    isIconAvailable: false,
                    borderColor: AppColors.black.withOpacity(0.5),
                    textColor: AppColors.black,
                    fontSize: 16.sp,
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Friends',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontFamily: "RobotoMono",
                    ),
                  ),
                ),

                // Scrollable list of people
                Expanded(
                  child: RawScrollbar(
                    controller: scrollController,
                    thumbVisibility: true,
                    interactive: true,
                    trackVisibility: true,
                    thumbColor: AppColors.pinkColor,
                    thickness: 3,
                    radius: const Radius.circular(10),
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: people.length,
                      itemBuilder: (context, index) {
                        final person = people[index];
                        return ListTile(
                          leading: CircleAvatar(
                            maxRadius: 20,
                            backgroundImage: AssetImage(
                              person['image']!,
                            ),
                          ),
                          title: Text(
                            person['name']!,
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall
                                ?.copyWith(
                                  color: AppColors.black,
                                  fontSize: 14.sp,
                                ),
                          ),
                          onTap: () {
                            // Handle person tap
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _manuallyTransferSendBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      barrierColor: AppColors.transparent,
      backgroundColor: AppColors.black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: false,
          maxChildSize: 0.63,
          initialChildSize: 0.63,
          builder: (context, scrollController) {
            return StatefulBuilder(builder: (context, setState) {
              // Function to handle keypad inputs
              void onKeyTap(String value) {
                setState(() {
                  if (value == 'DEL') {
                    // Handle delete: remove the last character
                    if (amount.isNotEmpty) {
                      amount = amount.substring(0, amount.length - 1);
                      amountController.text = amount;
                      amountController.selection = TextSelection.fromPosition(
                          TextPosition(offset: amountController.text.length));
                    }
                  } else if (value == '.') {
                    // Allow only one decimal point
                    if (!amount.contains('.')) {
                      amount += value;
                      amountController.text = amount;
                      amountController.selection = TextSelection.fromPosition(
                          TextPosition(offset: amountController.text.length));
                    }
                  } else {
                    // Append numbers with a maximum length of 10 digits
                    if (amount.length < 10) {
                      amount += value;
                      amountController.text = amount;
                      amountController.selection = TextSelection.fromPosition(
                          TextPosition(offset: amountController.text.length));
                    }
                  }
                });
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 1.h),
                  Align(
                    alignment: Alignment.center,
                    child: Text("Account Identifier",
                        style:
                            Theme.of(context).textTheme.displayMedium?.copyWith(
                                  color: AppColors.textGreyColor,
                                  fontSize: 14.sp,
                                )),
                  ),
                  SizedBox(height: 1.h),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: CustomTextField(
                        controller: accountIdentifierController,
                        hintText: "00-00-00-00-00",
                        obscureText: false,
                        keyboardType: TextInputType.phone,
                        validator: (value) => null,
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),

                  // Currency and Amount display
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'USD',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                              ),
                            ),
                            Text(
                              amountController.text.isEmpty
                                  ? '0.00'
                                  : amountController.text,
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 40,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 1.h),

                  // Custom Keypad
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildKeypadRow(context, ['1', '2', '3'], onKeyTap),
                        _buildKeypadRow(context, ['4', '5', '6'], onKeyTap),
                        _buildKeypadRow(context, ['7', '8', '9'], onKeyTap),
                        _buildKeypadRow(context, ['.', '0', 'DEL'], onKeyTap),
                      ],
                    ),
                  ),

                  // Swipe to confirm button
                  Center(
                      child: Container(
                          width: MediaQuery.of(context).size.width * 0.82,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.textGreyColor,
                              width: 0.5,
                            ),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Center(
                            child: ActionSlider.standard(
                              sliderBehavior: SliderBehavior.move,
                              controller: _controller,
                              loadingIcon: const CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColors.white),
                              ),
                              successIcon: const Image(
                                image: AssetImage(
                                    AppAssetsConstant.paymentSuccess),
                                height: 50,
                                width: 50,
                              ),
                              failureIcon: const Image(
                                image:
                                    AssetImage(AppAssetsConstant.paymentFailed),
                                height: 50,
                                width: 50,
                              ),
                              icon: const Image(
                                image: AssetImage(AppAssetsConstant.swipeToPay),
                                height: 50,
                                width: 50,
                              ),
                              width: MediaQuery.of(context).size.width * 0.8,
                              backgroundColor: AppColors.transparent,
                              toggleColor: AppColors.transparent,
                              action: (controller) async {
                                controller.loading();
                                await Future.delayed(
                                    const Duration(seconds: 3));
                                controller.success();
                                await Future.delayed(
                                    const Duration(seconds: 1));
                                amountController.clear();
                                context.pop();
                                controller.reset();
                              },
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "Slide to Confirm  ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium
                                      ?.copyWith(
                                          color: AppColors.textGreyColor,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w300),
                                ),
                              ),
                            ),
                          ))),

                  const SizedBox(height: 30),
                ],
              );
            });
          },
        );
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
          border: Border.all(color: Colors.grey, width: 0.5),
        ),
        child: Center(
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }

  // receive money bottom sheet
  void _transferReceiveBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      barrierColor: AppColors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: false,
          maxChildSize: 0.43,
          minChildSize: 0.43,
          initialChildSize: 0.43,
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
                        fontFamily: "RobotoMono",
                        color: Colors.black),
                  ),
                ),
                SizedBox(height: 1.h),
                const Align(
                  alignment: Alignment.center,
                  child: Image(
                    image: AssetImage(AppAssetsConstant.qrcode),
                    height: 250,
                    width: 250,
                  ),
                ),
                SizedBox(height: 1.h),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    '32-35-52-77-22',
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        fontFamily: "RobotoMono",
                        color: Colors.black),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showTransactions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      barrierColor: AppColors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: false,
          maxChildSize: 0.72,
          minChildSize: 0.72,
          initialChildSize: 0.72,
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
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      const Text(
                        'Transactions',
                        style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.w500,
                            fontFamily: "RobotoMono",
                            color: Colors.black),
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.filter_alt_rounded))
                    ],
                  ),
                ),
                SizedBox(height: 1.h),
                ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _activityItem('Microsoft', '\$5.99',
                        AppAssetsConstant.microsoft, "Jan 5th 2024"),
                    _activityItem('Amazon inc', '\$2.99',
                        AppAssetsConstant.amazon, "Jan 5th 2024"),
                    _activityItem('Transfer - Send', '\$12.39',
                        AppAssetsConstant.arrow, "Jan 5th 2024"),
                    _activityItem('Transfer - Receive', '\$50.19',
                        AppAssetsConstant.receive, "Jan 5th 2024"),
                    _activityItem('Amazon inc', '\$23.99',
                        AppAssetsConstant.amazon, "Jan 5th 2024 - refunded"),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }
}
