import 'dart:io';

import 'package:fcfs_banking_app/core/theme/colors.dart';
import 'package:fcfs_banking_app/core/theme/radialBg.dart';
import 'package:fcfs_banking_app/services/router/routes_name.dart';
import 'package:fcfs_banking_app/src/controllers/theme_controller.dart';
import 'package:fcfs_banking_app/src/controllers/transaction_controller.dart';
import 'package:fcfs_banking_app/src/controllers/user_controller.dart';
import 'package:fcfs_banking_app/src/views/widget/custom_app_bar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:sizer/sizer.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  TransactionController transactionController =
      Get.find<TransactionController>();

  UserController userController = Get.find<UserController>();
  ThemeController themeController = Get.find<ThemeController>();

  String selectedTimeFilter = 'Today';
  final List<String> timeFilters = [
    'Today',
    'Yesterday',
    'This Week',
    'This Month',
    '6 Month'
  ];
  int selectedMonthIndex = DateTime.now().month - 1;
  RxDouble selectedMonthBalance = 0.0.obs;
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

// function for generating pdf of transactions
  Future<void> exportTransactionsToPdf() async {
    final pdf = pw.Document();
    final DateTime now = DateTime.now();
    final String formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(now);

    // Fetch user info from the transactionController
    final String firstName = userController.user.value?.firstName ?? "N/A";
    final String lastName = userController.user.value?.lastName ?? "N/A";
    final String phoneNumber = userController.user.value?.phoneNumber ?? "N/A";

    // Check transaction data
    if (transactionController.transactions.isEmpty) {
      debugPrint("No transactions available to export.");
      return;
    }

    pdf.addPage(
      pw.Page(
        margin: const pw.EdgeInsets.all(24),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Transaction History',
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 8),
              pw.Text('Date: $formattedDate',
                  style: const pw.TextStyle(fontSize: 12)),
              pw.SizedBox(height: 16),
              pw.Text(
                'User Information:',
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 8),
              pw.Text('Name: $firstName $lastName',
                  style: const pw.TextStyle(fontSize: 14)),
              pw.Text('Phone Number: $phoneNumber',
                  style: const pw.TextStyle(fontSize: 14)),
              pw.SizedBox(height: 20),
              pw.Text(
                'Transactions',
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 10),
              // ignore: deprecated_member_use
              pw.Table.fromTextArray(
                border: pw.TableBorder.all(),
                headers: ['Date', 'Recipient', 'Description', 'Type', 'Amount'],
                data: transactionController.transactions.map((transaction) {
                  return [
                    transaction.date != null
                        ? DateFormat('yyyy-MM-dd').format(transaction.date)
                        : "Unknown Date",
                    transaction.recipient?.entries.isNotEmpty == true
                        ? transaction.recipient!.entries.first.value
                        : "Receiver name not available",
                    transaction.description ?? 'No description',
                    transaction.type == "credit" ? "Credit" : "Debit",
                    '\$${transaction.amount.toStringAsFixed(2)}',
                  ];
                }).toList(),
                headerStyle: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 12,
                ),
                headerDecoration:
                    const pw.BoxDecoration(color: PdfColors.grey300),
                cellAlignment: pw.Alignment.centerLeft,
                cellStyle: const pw.TextStyle(fontSize: 10),
              ),
            ],
          );
        },
      ),
    );

    // Save and Open PDF
    try {
      final output = await getApplicationDocumentsDirectory();
      final file = File(
          '${output.path}/TransactionHistory_${now.toIso8601String()}.pdf');
      await file.writeAsBytes(await pdf.save());
      debugPrint("PDF saved successfully: ${file.path}");
      await OpenFile.open(file.path);
    } catch (e) {
      debugPrint("Error saving PDF: $e");
    }
  }

  void _updateSelectedMonthBalance() {
    int selectedYearMonth =
        DateTime.now().year * 100 + (selectedMonthIndex + 1);
    selectedMonthBalance.value =
        transactionController.monthlyBalances[selectedYearMonth] ?? 0.0;
  }

  @override
  void initState() {
    super.initState();
    _updateSelectedMonthBalance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: AppColors.black,
        appBar: CustomAppBar(
          title: 'Transaction History',
          showMoreVertIcon: false,
          showNotificationIcon: false,
          showProfilePic: false,
          showShareIcon: true,
          onShareTap: () {
            exportTransactionsToPdf();
          },
        ),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 1.h),
                      Text(
                        '${months[selectedMonthIndex]} ${DateFormat('yyyy').format(DateTime.now())}',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      const SizedBox(height: 5),
                      Obx(() => Text(
                            '\$${selectedMonthBalance.value.toStringAsFixed(2)}',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                  color: themeController.themeMode ==
                                          ThemeMode.dark
                                      ? AppColors.white
                                      : AppColors.pinkColor,
                                ),
                          )),
                      SizedBox(height: 0.8.h),
                      Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.width,
                          child: _buildBarChart()),
                      // _buildBarChart(),
                      const SizedBox(height: 20),
                      _buildRecentActivity(),
                    ],
                  ),
                )),
          ],
        ));
  }

  Widget _buildBarChart() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        height: 200,
        width: months.length * 40,
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceEvenly,
            maxY: 10000,
            barTouchData: BarTouchData(
              touchCallback: (FlTouchEvent event, BarTouchResponse? response) {
                if (response != null && response.spot != null) {
                  setState(() {
                    selectedMonthIndex = response.spot!.touchedBarGroupIndex;
                    _updateSelectedMonthBalance();
                  });
                }
              },
            ),
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 40,
                  getTitlesWidget: (value, meta) {
                    int index = value.toInt();
                    return SideTitleWidget(
                      axisSide: meta.axisSide,
                      child: Text(
                        months[index],
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12),
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
              12,
              (i) => _makeGroupData(
                i,
                transactionController
                        .monthlyBalances[DateTime.now().year * 100 + (i + 1)] ??
                    1,
                isTarget: i == selectedMonthIndex,
              ),
            ),
            groupsSpace: 16,
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
          toY: y > 0 ? y : 1,
          color: isTarget
              ? themeController.themeMode == ThemeMode.dark
                  ? AppColors.darkBorderColor
                  : AppColors.red
              : AppColors.white.withOpacity(0.8),
          width: 16,
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
                  fontFamily: "Montserrat",
                  fontSize: 18.sp,
                )),
        const SizedBox(height: 15),
        _buildTimeFilter(),
        const SizedBox(height: 20),
        SizedBox(
          child: Obx(() {
            if (transactionController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            if (transactionController.filteredTransaction.isEmpty) {
              return Center(
                child: Text(
                  "No transactions available",
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        color: themeController.themeMode == ThemeMode.dark
                            ? AppColors.white
                            : AppColors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                      ),
                ),
              );
            }
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: transactionController.filteredTransaction.length,
              itemBuilder: (context, index) {
                final transaction =
                    transactionController.filteredTransaction[index];
              final recipientId = transaction.recipient != null &&
                        transaction.recipient!.entries.isNotEmpty
                    ? transaction.recipient!.entries.first.value
                    : '';

                return FutureBuilder<String>(
                  future: userController.fetchReceiverNameById(recipientId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: SizedBox());
                    } else if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    }

                    final userName = snapshot.data ?? 'Unknown';

                    return _buildActivityItem(
                      userName,
                      transaction.description ?? '',
                      "${transaction.type == "credit" ? "+ " : "- "}\$${transaction.amount.toString()}",
                      transaction.type == "credit"
                          ? Colors.green
                          : themeController.themeMode == ThemeMode.dark
                              ? AppColors.darkBorderColor
                              : AppColors.red,
                      transaction.type == "credit"
                          ? Colors.green
                          : AppColors.white,
                      (transaction.type == "credit"
                          ? Icons.call_received
                          : Icons.call_made),
                      ontap: () {
                        context.pushNamed(
                          RoutesName.transactionDetailsScreen,
                          extra: transaction,
                        );
                      },
                    );
                  },
                );
              },
            );
         
          }),
        ),
      ],
    );
  }

  Widget _buildTimeFilter() {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: timeFilters.map((filter) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: _buildTimeFilterButton(filter,
                  selected: selectedTimeFilter == filter),
            );
          }).toList(),
        ),
      ),
    );
  }

  void _onTimeFilterSelected(String filter) {
    setState(() {
      selectedTimeFilter = filter;

      switch (selectedTimeFilter) {
        case 'Today':
          transactionController.filteredTransaction.value =
              transactionController.getTodayTransactions();
          break;
        case 'Yesterday':
          transactionController.filteredTransaction.value =
              transactionController.getYesterdayTransactions();
          break;
        case 'This Week':
          transactionController.filteredTransaction.value =
              transactionController.getThisWeekTransactions();
          break;
        case 'This Month':
          transactionController.filteredTransaction.value =
              transactionController.getThisMonthTransactions();
          break;
        case '6 Month':
          transactionController.filteredTransaction.value =
              transactionController.getLastSixMonthsTransactions();
          break;
        default:
          transactionController.filteredTransaction.value =
              transactionController.transactions;
      }
    });
  }

  Widget _buildTimeFilterButton(String label, {bool selected = false}) {
    return GestureDetector(
      onTap: () => _onTimeFilterSelected(label),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        decoration: themeController.themeMode == ThemeMode.dark
            ? BoxDecoration(
                color: selected
                    ? AppColors.darkBorderColor
                    : Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(20),
              )
            : BoxDecoration(
                color: selected
                    ? AppColors.pinkColor
                    : Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(20),
              ),
        child: Center(
          child: Text(label,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp)),
        ),
      ),
    );
  }

  Widget _buildActivityItem(String title, String subtitle, String amount,
      Color iconColor, Color amountColor, IconData icon,
      {required VoidCallback ontap}) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        margin: const EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
          color: AppColors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: iconColor,
                  child: Icon(icon, color: Colors.white),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                        style:
                            Theme.of(context).textTheme.displayMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.sp, // Responsive font size
                                ),
                      ),
                      SizedBox(height: 0.5.h),
                      Text(
                        subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                        style:
                            Theme.of(context).textTheme.displayMedium?.copyWith(
                                  color: AppColors.white.withOpacity(0.5),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp, // Responsive font size
                                ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Text(
                  amount,
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        color: amountColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 17.sp,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 5)
          ],
        ),
      ),
    );
  }
}
