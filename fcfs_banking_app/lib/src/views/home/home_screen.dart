import 'package:cached_network_image/cached_network_image.dart';
import 'package:fcfs_banking_app/core/theme/colors.dart';
import 'package:fcfs_banking_app/core/theme/radialBg.dart';
import 'package:fcfs_banking_app/core/utils/app_helpers.dart';
import 'package:fcfs_banking_app/core/utils/constant/app_assets_constant.dart';
import 'package:fcfs_banking_app/core/utils/constant/app_string.dart';
import 'package:fcfs_banking_app/services/router/routes_name.dart';
import 'package:fcfs_banking_app/src/controllers/currency_exchange_controller.dart';
import 'package:fcfs_banking_app/src/controllers/theme_controller.dart';
import 'package:fcfs_banking_app/src/controllers/transaction_controller.dart';
import 'package:fcfs_banking_app/src/controllers/user_controller.dart';
import 'package:fcfs_banking_app/src/models/transactions_model.dart';
import 'package:fcfs_banking_app/src/views/home/spending_limit.dart';
import 'package:fcfs_banking_app/src/views/widget/custom_button.dart';
import 'package:fcfs_banking_app/src/views/widget/textfield_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController accountIdentifierController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController receiverNameController = TextEditingController();
  TextEditingController limitAmountController = TextEditingController();
  TextEditingController topUpAmountController = TextEditingController();
  UserController userController = Get.find<UserController>();
  ThemeController themeController = Get.find<ThemeController>();
  TransactionController transactionController =
      Get.find<TransactionController>();
  String amount = '';
  TextEditingController qrAmountController = TextEditingController();
  String qrAmount = '';
  String? receiverName;
  String accountIdentifier = "";
  GlobalKey<FormState> qrFormKey = GlobalKey<FormState>();
  final ScrollController scrollController = ScrollController();
  bool showExchangeRateContainer = false;

  TextEditingController exchangeAmountController = TextEditingController();
  TextEditingController resultAmountController = TextEditingController();
  String? selectedCurrency = 'JMD';
  String? resultCurrency = 'JMD';
  String currencyAmount = '';
  String resultAmount = '';
  final bool _showExchangeRate = true;
  final currencyController = Get.find<CurrencyController>();
  final PageController pageController = PageController();
  int selectedIndex = -1;

  // Default selected tab index
  int tabselectedIndex = 1;

  final List<FlSpot> spots = [
    const FlSpot(0, 300),
    const FlSpot(1, 700),
    const FlSpot(2, 200),
    const FlSpot(3, 500),
  ];

  @override
  void dispose() {
    accountIdentifierController.dispose();
    amountController.dispose();
    limitAmountController.dispose();
    topUpAmountController.dispose();
    qrAmountController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    userController.fetchCurrentUserData().then((_) {
      final user = userController.user.value;
      if (user != null) {
        transactionController.fetchUserTransactions(user.uid);
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      currencyController.fetchCurrency();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final user = userController.user.value;

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final screenHeight = constraints.maxHeight;
          final screenWidth = constraints.maxWidth;

          return Stack(
            children: [
              // Gradient Background
              Positioned.fill(
                child: CustomPaint(
                  painter: themeController.themeMode == ThemeMode.dark
                      ? DarkGradientBackgroundPainter()
                      : GradientBackgroundPainter(),
                ),
              ),

              // Top Section (User Info & Tabs)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
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
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).padding.top + 10),

                      // Profile, QR, Notifications
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () =>
                                context.pushNamed(RoutesName.profileScreen),
                            child: CircleAvatar(
                              radius: screenWidth * 0.07,
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
                            onTap: () =>
                                context.pushNamed(RoutesName.scanScreen),
                            child: Icon(Icons.qr_code,
                                color: Colors.white, size: screenWidth * 0.08),
                          ),
                          const Spacer(),
                          IconButton(
                            icon: Image.asset(AppAssetsConstant.notification,
                                width: screenWidth * 0.06),
                            onPressed: () => context
                                .pushNamed(RoutesName.notificationScreen),
                          ),
                        ],
                      ),

                      SizedBox(height: 1.h),

                      // User Name & Phone
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          user?.role == "Business"
                              ? "${user?.businessName}"
                              : "${user?.firstName} ${user?.lastName}",
                          style: theme.textTheme.displayMedium?.copyWith(
                              fontSize: 18.sp, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          user?.phoneNumber ?? '',
                          style: theme.textTheme.displayMedium
                              ?.copyWith(fontSize: 17.sp),
                        ),
                      ),

                      SizedBox(height: 1.h),

                      // Tabs
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _tabBox(0, tabselectedIndex == 0),
                            const SizedBox(width: 8),
                            _tabBox(1, tabselectedIndex == 1),
                            const SizedBox(width: 8),
                            _tabBox(2, tabselectedIndex == 2),
                            const SizedBox(width: 8),
                            _tabBox(3, tabselectedIndex == 3),
                          ],
                        ),
                      ),

                      SizedBox(height: 1.h),

                      // Balance
                      Center(
                        child: Column(
                          children: [
                            Text(
                              "\$${user?.balance.toStringAsFixed(2) ?? '0.00'}",
                              style: theme.textTheme.displayMedium?.copyWith(
                                  fontSize: 26.sp, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 0.5.h),
                            Text(
                              "+32% LESS SPENDING THIS MONTH",
                              style: theme.textTheme.displayMedium
                                  ?.copyWith(fontSize: 14.sp),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 1.h),

                      // Action Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _actionButton("SEND", Icons.upload, onpressed: () {
                            context.pushNamed(
                                RoutesName.newDirectDebitRequestScreen);
                          }),
                          _actionButton("RECEIVE", Icons.send, onpressed: () {
                            context.pushNamed(RoutesName.receiveInitial);
                          }),
                          _actionButton("CARDS", Icons.download, onpressed: () {
                            context.pushNamed(RoutesName.creditCard);
                          }),
                        ],
                      ),

                      SizedBox(height: 0.7.h),
                    ],
                  ),
                ),
              ),

              // Spending Limit Card (Positioned Relative to the Header)
              Positioned(
                top: screenHeight * 0.45,
                left: 16,
                right: 16,
                child: SpendingLimitCard(
                  limit: user!.monthlyLimit,
                  remaining: transactionController.remainingMonthlyLimit.value,
                  onTap: () => context.pushNamed(RoutesName.setLimit),
                ),
              ),

              // PageView for Transactions, Graph, Exchange Rates
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: screenHeight * 0.45,
                  width: screenWidth - 24,
                  child: Column(
                    children: [
                      Expanded(
                        child: PageView(
                          physics: const BouncingScrollPhysics(),
                          controller: pageController,
                          children: [
                            transactionBox(theme),
                            transactionGraph(theme),
                            exchangerateWidget(
                                context,
                                theme,
                                currencyController
                                    .getExchangeRate(resultCurrency!)),
                          ],
                        ),
                      ),
                      SizedBox(height: 0.6.h),
                      SmoothPageIndicator(
                        controller: pageController,
                        count: 3,
                        effect: WormEffect(
                          dotHeight: 5,
                          dotWidth: 10,
                          activeDotColor:
                              themeController.themeMode == ThemeMode.dark
                                  ? AppColors.darkBorderColor
                                  : AppColors.pinkGrey,
                          dotColor: AppColors.white.withOpacity(0.4),
                        ),
                      ),
                      SizedBox(height: 0.6.h),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _tabBox(int index, bool isSelected) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            tabselectedIndex = index;
          });
        },
        child: Container(
          height: isSelected ? 30 : 20,
          decoration: themeController.themeMode == ThemeMode.dark
              ? BoxDecoration(
                  color: isSelected
                      ? AppColors.darkTransferBgColor2
                      : AppColors.darkTileColor,
                  borderRadius: BorderRadius.circular(5),
                )
              : BoxDecoration(
                  color: isSelected ? const Color(0xFFF9AE50) : Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
        ),
      ),
    );
  }

// bar chart data

  Widget transactionBox(ThemeData theme) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.5.w),
      child: Container(
        decoration: BoxDecoration(
          gradient: themeController.themeMode == ThemeMode.dark
              ? AppColors.dakStackContainerBackground2
              : AppColors.stackContainerBackground2,
          // color: AppColors.white.withOpacity(0.3),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Obx(() {
          List<TransactionModel> recentTransactions =
              transactionController.getRecentTransactions(5);

          if (recentTransactions.isEmpty) {
            return Center(
              child: Text(
                'No recent transactions',
                style: theme.textTheme.displayMedium?.copyWith(
                  fontSize: 14.sp,
                  fontFamily: "Montserrat",
                  color: Colors.grey,
                ),
              ),
            );
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: recentTransactions.length,
                  itemBuilder: (context, index) {
                    final transaction = recentTransactions[index];

                    final recipientId = transaction.recipient != null &&
                            transaction.recipient!.entries.isNotEmpty
                        ? transaction.recipient!.entries.first.value
                        : '';
                    return FutureBuilder<String>(
                      future: userController.fetchReceiverNameById(recipientId),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(child: SizedBox());
                        } else if (snapshot.hasError) {
                          return Text("Error: ${snapshot.error}");
                        }

                        final userName = snapshot.data ?? 'Unknown';

                        return _activityItem(
                          userName ==
                                  '${userController.user.value!.firstName} ${userController.user.value!.lastName}'
                              ? 'Wallter Recharge - Self'
                              : userName,
                          transaction.type == 'credit'
                              ? '+ \$${transaction.amount}'
                              : '- \$${transaction.amount}',
                          transaction.type == 'credit'
                              ? Colors.green
                              : AppColors.white,
                          transaction.type == 'credit'
                              ? Icons.call_received
                              : Icons.call_made,
                          AppHelpers.formatDate(transaction.date),
                          transaction.type == 'credit'
                              ? Colors.green
                              : AppColors.white,
                          transaction.type == 'credit'
                              ? Colors.green
                              : themeController.themeMode == ThemeMode.dark
                                  ? AppColors.darkBorderColor
                                  : AppColors.red,
                        );
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 0.6.h),
              TextButton(
                onPressed: () {
                  context.pushNamed(RoutesName.mainPage, pathParameters: {
                    'initialIndex': '1',
                  });
                },
                child: Text(
                  'MORE',
                  style: theme.textTheme.displayMedium,
                ),
              ),
              SizedBox(height: 1.h),
            ],
          );
        }),
      ),
    );
  }

  Widget transactionGraph(ThemeData theme) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.5.w),
      child: Column(
        children: [
          SizedBox(
            height: 26.h,
            child: Container(
              decoration: BoxDecoration(
                gradient: themeController.themeMode == ThemeMode.dark
                    ? AppColors.dakStackContainerBackground2
                    : AppColors.stackContainerBackground2,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${DateTime.now().year}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Jan 1 - Apr 1",
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () {
                            // Handle date range selection
                          },
                          icon: Icon(
                            Icons.filter_list,
                            color: Colors.white,
                            size: 10.w,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  //   If no data available for the graph
                  // Center(
                  //   child: Text(
                  //     'No data available!',
                  //     style: theme.textTheme.displayMedium?.copyWith(
                  //       fontSize: 18.sp,
                  //       fontWeight: FontWeight.bold,
                  //       color: Colors.white,
                  //     ),
                  //   ),
                  // ),

                  // Line chart section
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: LineChart(
                        LineChartData(
                          gridData:
                              const FlGridData(show: false), // Hide grid lines
                          titlesData: FlTitlesData(
                            show: true,
                            leftTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            rightTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            topTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: _buildBottomTitles,
                                  interval: 1),
                            ),
                          ),
                          borderData: FlBorderData(
                            show: true,
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          lineBarsData: [
                            LineChartBarData(
                              spots: spots,
                              isCurved: true,
                              color: themeController.themeMode == ThemeMode.dark
                                  ? AppColors.grey.withOpacity(0.6)
                                  : Colors.orange, // Line color
                              dotData: const FlDotData(show: true),
                              belowBarData: BarAreaData(
                                show: true,
                                color:
                                    themeController.themeMode == ThemeMode.dark
                                        ? AppColors.darkBgColor2
                                        : Colors.orange.withOpacity(
                                            0.3), // Gradient under line
                              ),
                            ),
                          ],
                          minX: 0,
                          maxX: spots.length.toDouble() - 1,
                          minY: 0,
                          maxY: _getMaxY(spots),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 1.h),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 4,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                // Titles for each index
                List<String> titles = [
                  "Set Limit",
                  "Refer to earn",
                  "How to budget",
                  "How to save"
                ];

                return featureCard(
                    title: titles[index],
                    onTap: () {
                      if (index == 0) {
                        // _setLimitBottomSheet(context);
                        context.pushNamed(RoutesName.setLimit);
                      } else if (index == 1) {
                        context.pushNamed(RoutesName.referralScreen);
                      } else if (index == 2) {
                        AppHelpers.toast("upcoming feature");
                      } else {
                        AppHelpers.toast("upcoming feature");
                      }
                    });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomTitles(double value, TitleMeta meta) {
    const titles = ['Jan', 'Feb', 'Mar', 'Apr'];
    TextStyle style = TextStyle(
      color: Colors.white.withOpacity(0.7),
      fontSize: 12,
    );

    int index = value.round();
    String text = (index >= 0 && index < titles.length) ? titles[index] : '';

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  double _getMaxY(List<FlSpot> spots) {
    return spots.map((spot) => spot.y).reduce((a, b) => a > b ? a : b) + 1;
  }

// FeatureCard Widget
  Widget featureCard({required String title, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(right: 2.5.w),
        height: MediaQuery.of(context).size.height * 0.1,
        width: MediaQuery.of(context).size.width / 4.8,
        decoration: BoxDecoration(
          color: themeController.themeMode == ThemeMode.dark
              ? AppColors.darkBorderColor
              : Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(3.w)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Centered Image
            Expanded(
              child: Center(
                child: Image(
                  image: const AssetImage(AppAssetsConstant.applogo),
                  width: 16.w,
                  height: 3.h,
                  fit: BoxFit.contain,
                  color: themeController.themeMode == ThemeMode.dark
                      ? AppColors.white
                      : Colors.red,
                ),
              ),
            ),
            // Bottom Text
            Padding(
              padding: EdgeInsets.only(bottom: 1.h, left: 1.w, right: 1.w),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.center,
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: themeController.themeMode == ThemeMode.dark
                            ? AppColors.white
                            : AppColors.lightRed,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedOpacity exchangerateWidget(
      BuildContext context, ThemeData theme, double exchangeRate) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: _showExchangeRate ? 1.0 : 0.0,
      child: Visibility(
        visible: _showExchangeRate,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.35,
              // margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: themeController.themeMode == ThemeMode.dark
                    ? AppColors.dakStackContainerBackground2
                    : AppColors.stackContainerBackground2,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Live Exchange Rate',
                    style: theme.textTheme.displayMedium?.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 16),
                    decoration: BoxDecoration(
                      color: AppColors.transparent,
                      border: Border.all(color: AppColors.white),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 100,
                          child: TextField(
                            controller: exchangeAmountController,
                            cursorColor: AppColors.textGreyColor,
                            style: theme.textTheme.displaySmall,
                            keyboardType: TextInputType.number,
                            enabled: false,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "1",
                              hintStyle: theme.textTheme.displayMedium
                                  ?.copyWith(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.white),
                          ),
                          child: Text(
                            "USD",
                            style: theme.textTheme.displayMedium
                                ?.copyWith(color: AppColors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(height: 1.5.h),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.swap_vert,
                        color: AppColors.white, size: 30),
                  ),
                  // SizedBox(height: 1.5.h),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 16),
                    decoration: BoxDecoration(
                      color: AppColors.transparent,
                      border: Border.all(color: AppColors.white),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: TextField(
                            controller: resultAmountController,
                            textAlign: TextAlign.center,
                            cursorColor: AppColors.white,
                            style: theme.textTheme.displaySmall,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              setState(() {
                                resultAmount = value;
                              });
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: exchangeRate.toStringAsFixed(2),
                              enabled: false,
                              hintStyle: theme.textTheme.displayMedium
                                  ?.copyWith(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        DropdownButton<String>(
                          dropdownColor:
                              themeController.themeMode == ThemeMode.dark
                                  ? AppColors.darkBorderColor
                                  : AppColors.pinkColor,
                          value: resultCurrency,
                          hint: Text(
                            "Select",
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                            ),
                          ),
                          items: ['JMD', 'EUR', 'GBP', 'JPY', 'CAD']
                              .map((String value) => DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: theme.textTheme.displayMedium,
                                    ),
                                  ))
                              .toList(),
                          onChanged: (newValue) {
                            setState(() {
                              resultCurrency = newValue!;
                              exchangeRate = exchangeRate;
                            });
                          },
                          iconEnabledColor: AppColors.white,
                          iconSize: 24,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }

  Widget _actionButton(String label, IconData icon,
      {required VoidCallback onpressed}) {
    final theme = Theme.of(context);
    return SizedBox(
      width: 28.w,
      child: OutlinedButton.icon(
        iconAlignment: IconAlignment.end,
        onPressed: onpressed,
        style: OutlinedButton.styleFrom(
          // foregroundColor: Colors.white,
          backgroundColor: themeController.themeMode == ThemeMode.dark
              ? AppColors.darkBorderColor
              : AppColors.purple,
          side: BorderSide(
            color: themeController.themeMode == ThemeMode.dark
                ? AppColors.darkBorderColor
                : AppColors.purple,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        label: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            label,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.titleLarge
                ?.copyWith(fontSize: 15.sp, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  Widget _activityItem(
    String title,
    String amount,
    Color amountColor,
    IconData icon,
    String date,
    Color textcolor,
    Color iconColor,
  ) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: iconColor,
        child: Icon(icon, color: Colors.white),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .displayMedium
                ?.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 0.5.h),
          Text(
            date,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontSize: 16.sp,
                ),
          ),
        ],
      ),
      trailing: Text(
        amount,
        style: Theme.of(context).textTheme.displayMedium?.copyWith(
            fontSize: 17.sp, fontWeight: FontWeight.bold, color: amountColor),
      ),
    );
  }

  Widget buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.white),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: AppColors.white.withOpacity(0.7),
                    )),
            Text(value,
                style: Theme.of(context)
                    .textTheme
                    .displaySmall
                    ?.copyWith(fontSize: 15.sp, color: AppColors.white)),
          ],
        ),
      ),
    );
  }

// topup wallet money
  void _topUpMoneyBottomSheet(BuildContext context) {
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
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: DraggableScrollableSheet(
              expand: false,
              maxChildSize: 0.6,
              minChildSize: 0.35,
              initialChildSize: 0.35,
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
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          AppString.addMoney,
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Montserrat",
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.88,
                            child: TextfieldWidget(
                              controller: topUpAmountController,
                              label: "Enter amount",
                              obscureText: false,
                              keyboardType: TextInputType.number,
                              showlabel: false,
                              textAlign: TextAlign.start,
                            )),
                      ),
                      SizedBox(height: 0.6.h),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          "Current daily limit: \$${userController.user.value!.dailyLimit}",
                          style: const TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Montserrat",
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Center(
                        child: CustomButtonWidget(
                          onTap: () {
                            double? topUpAmountValue =
                                double.tryParse(topUpAmountController.text);

                            if (topUpAmountController.text.isNotEmpty) {
                              transactionController
                                  .addTransaction(TransactionModel(
                                id: "",
                                userId: userController.user.value!.uid,
                                amount: topUpAmountValue!,
                                description: 'Wallet Recharge',
                                date: DateTime.now(),
                                type: 'credit',
                                status: 'completed',
                                recipient: const {'name': 'Self'},
                                fees: 0,
                              ));
                              // AppHelpers.toast(
                              //     "${topUpAmountController.text} added ");
                              print("Top Up Amount: $topUpAmountValue");
                              topUpAmountController.clear();
                              context.pop();
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
                          text: AppString.addMoney,
                          fontSize: 18.sp,
                          isIconAvailable: false,
                          radius: 8,
                        ),
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
