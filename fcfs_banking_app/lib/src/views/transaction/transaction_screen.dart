import 'package:fcfs_banking_app/core/theme/colors.dart';
import 'package:fcfs_banking_app/core/utils/constant/app_assets_constant.dart';
import 'package:fcfs_banking_app/src/views/widget/custom_app_bar.dart';
import 'package:fcfs_banking_app/src/views/widget/dummy/transactions.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  int selectedMonthIndex = 2;
  double selectedMonthBalance = 8295;

  final List<double> balances = [
    6000,
    7000,
    8295,
    6000,
    6000,
    5000,
    7200,
    6400,
    8100,
    5300,
    9200,
    8700
  ];
  String selectedTimeFilter = 'Today';
  final List<String> timeFilters = [
    'Today',
    'This Week',
    'This Month',
    '6 Month'
  ];

  final List<String> months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: CustomAppBar(
        title: 'Transaction History',
        showMoreVertIcon: true,
        showNotificationIcon: false,
        showProfilePic: false,
        onMoreVertTap: () {},
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppAssetsConstant.upperBackground),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: const BoxDecoration(
              color: AppColors.black,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Text('${months[selectedMonthIndex]} 2024',
                      style: Theme.of(context).textTheme.displaySmall),
                  const SizedBox(height: 5),
                  Text('\$${selectedMonthBalance.toStringAsFixed(2)}',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(color: AppColors.pinkColor)),
                  SizedBox(height: 0.8.h),
                  Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width,
                      child: _buildBarChart()),
                  const SizedBox(height: 20),
                  _buildRecentActivity(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBarChart() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.20,
        width: months.length * 50.0,
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            maxY: 10,
            barTouchData: BarTouchData(
              touchCallback:
                  (FlTouchEvent event, BarTouchResponse? barResponse) {
                if (barResponse != null && barResponse.spot != null) {
                  setState(() {
                    selectedMonthIndex = barResponse.spot!.touchedBarGroupIndex;
                    selectedMonthBalance = balances[selectedMonthIndex];
                  });
                }
              },
            ),
            titlesData: FlTitlesData(
              show: true,
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 40,
                  getTitlesWidget: (double value, TitleMeta meta) {
                    int index = value.toInt();
                    if (index < 0 || index >= months.length) {
                      return const SizedBox();
                    }
                    return SideTitleWidget(
                      axisSide: meta.axisSide,
                      space: 8,
                      child: Text(
                        months[index],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    );
                  },
                ),
              ),
              leftTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),
            gridData: const FlGridData(show: false),
            borderData: FlBorderData(show: false),
            barGroups: List.generate(
              balances.length,
              (i) => _makeGroupData(i, balances[i] / 1000,
                  isTarget: i == selectedMonthIndex),
            ),
          ),
        ),
      ),
    );
  }

  BarChartGroupData _makeGroupData(int x, double y, {bool isTarget = false}) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y.isFinite ? y : 0,
          color: isTarget ? AppColors.pinkColor : Colors.grey,
          width: 22,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }

  Widget _buildRecentActivity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('All Transactions',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontFamily: "RobotoMono",
                  fontSize: 18.sp,
                )),
        const SizedBox(height: 15),
        _buildTimeFilter(),
        const SizedBox(height: 20),
        SizedBox(
          child: ListView.builder(
            itemCount: transactions.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final transaction = transactions[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: _buildActivityItem(
                  transaction['title'],
                  transaction['subtitle'],
                  transaction['amount'],
                  transaction['color'],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTimeFilter() {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: timeFilters.map((filter) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: _buildTimeFilterButton(filter,
                  selected: selectedTimeFilter == filter),
            ),
          );
        }).toList(),
      ),
    );
  }

  void _onTimeFilterSelected(String filter) {
    setState(() {
      selectedTimeFilter = filter;
      // Add logic to update displayed data based on selected time filter
    });
  }

  Widget _buildTimeFilterButton(String label, {bool selected = false}) {
    return GestureDetector(
      onTap: () => _onTimeFilterSelected(label),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        decoration: BoxDecoration(
          color: selected ? AppColors.pinkColor : Colors.grey[800],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(label,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp)),
        ),
      ),
    );
  }

  Widget _buildActivityItem(
      String title, String subtitle, String amount, Color iconColor) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: iconColor,
          child: const Icon(Icons.arrow_upward, color: Colors.white),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .displayMedium
                  ?.copyWith(fontWeight: FontWeight.w300, fontSize: 16.sp),
            ),
            const SizedBox(height: 5),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: AppColors.textGreyColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 16.sp),
            ),
          ],
        ),
        const Spacer(),
        Text(
          amount,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
              color: amount.startsWith('+') ? Colors.green : Colors.red,
              fontWeight: FontWeight.w300,
              fontSize: 16.sp),
        ),
      ],
    );
  }
}
