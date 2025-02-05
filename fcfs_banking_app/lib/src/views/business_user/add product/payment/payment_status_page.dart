import 'package:fcfs_banking_app/core/theme/colors.dart';
import 'package:fcfs_banking_app/core/theme/radialBg.dart';
import 'package:fcfs_banking_app/core/utils/app_helpers.dart';
import 'package:fcfs_banking_app/core/utils/constant/app_assets_constant.dart';
import 'package:fcfs_banking_app/services/router/routes_name.dart';
import 'package:fcfs_banking_app/src/controllers/product_controller.dart';
import 'package:fcfs_banking_app/src/controllers/theme_controller.dart';
import 'package:fcfs_banking_app/src/views/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:sizer/sizer.dart';

class PaymentReceiptStatus extends StatelessWidget {
  PaymentReceiptStatus({super.key});
  final productController = Get.find<ProductController>();
  final themeController = Get.find<ThemeController>();

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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: themeController.themeMode == ThemeMode.dark
                        ? const GradientBoxBorder(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.darkBgColor2,
                                AppColors.purple
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            width: 2,
                          )
                        : const GradientBoxBorder(
                            gradient: LinearGradient(
                              colors: [AppColors.white, AppColors.red],
                              end: Alignment.topLeft,
                              begin: Alignment.bottomRight,
                            ),
                            width: 2,
                          ),
                  ),
                  child: Column(
                    children: [
                      _paymentSuccessCard(theme),
                      SizedBox(height: 2.h),
                      _summaryCard(theme),
                    ],
                  ),
                ),
                SizedBox(height: 2.h),
                CustomButtonWidget(
                  onTap: () {},
                  width: double.infinity,
                  text: "Email receipt",
                  isIconAvailable: false,
                  color: themeController.themeMode == ThemeMode.dark
                      ? AppColors.darkBorderColor
                      : AppColors.red,
                  borderColor: themeController.themeMode == ThemeMode.dark
                      ? AppColors.darkBorderColor
                      : AppColors.red,
                  fontSize: 17.sp,
                ),
                SizedBox(height: 1.h),
                CustomButtonWidget(
                  onTap: () {
                    AppHelpers.toast("Receipt sent successfully");
                    context.goNamed(RoutesName.mainPage, pathParameters: {
                      'initialIndex': '0',
                    });
                  },
                  width: double.infinity,
                  text: "Send",
                  isIconAvailable: false,
                  color: themeController.themeMode == ThemeMode.dark
                      ? AppColors.darkBorderColor
                      : AppColors.red,
                  borderColor: themeController.themeMode == ThemeMode.dark
                      ? AppColors.darkBorderColor
                      : AppColors.red,
                  fontSize: 17.sp,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _paymentSuccessCard(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border(
          bottom: BorderSide(
              color: themeController.themeMode == ThemeMode.light
                  ? AppColors.grey
                  : Colors.purpleAccent,
              width: 2),
          left: BorderSide(
              color: themeController.themeMode == ThemeMode.light
                  ? AppColors.grey
                  : Colors.purpleAccent,
              width: 0.5),
          right: BorderSide(
              color: themeController.themeMode == ThemeMode.light
                  ? AppColors.grey
                  : Colors.purpleAccent,
              width: 0.5),
        ),
      ),
      child: Column(
        children: [
          SizedBox(
              height: 15.h,
              width: 100.w,
              child: Image(
                image: const AssetImage(AppAssetsConstant.applogo),
                color: themeController.themeMode == ThemeMode.dark
                    ? AppColors.white
                    : AppColors.red,
              )),
          const SizedBox(height: 10),
          Text(
            "Payment successful",
            style: theme.textTheme.displayMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _summaryCard(ThemeData theme) {
    return Container(
      height: 40.h,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: const Border(
          bottom: BorderSide(color: Colors.purpleAccent, width: 0.5),
        ),
      ),
      child: Column(
        children: [
          Text(
            "Summary",
            style: theme.textTheme.displayMedium,
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 24.h,
            child: Scrollbar(
              child: Obx(
                () => ListView.builder(
                  itemCount: productController.selectedProducts.length,
                  itemBuilder: (context, index) {
                    var item = productController.selectedProducts[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${item['name']} x ${item['quantity']}',
                              style: theme.textTheme.displayMedium),
                          Text(
                              '\$${(item['price'] * item['quantity']).toStringAsFixed(2)}',
                              style: theme.textTheme.displayMedium),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          const Divider(
            color: Colors.white,
          ),
          Obx(() {
            return _summaryItem("Total",
                "\$ ${productController.totalAmount.value.toStringAsFixed(2)}",
                isBold: true, theme: theme);
          }),
        ],
      ),
    );
  }

  Widget _summaryItem(String title, String price,
      {bool isBold = false, required ThemeData theme}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            title,
            style: theme.textTheme.displayMedium?.copyWith(
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
          ),
          Text(
            price,
            style: theme.textTheme.displayMedium?.copyWith(
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
          ),
        ],
      ),
    );
  }

  Widget _emailReceiptButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[800],
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        onPressed: () {},
        child:
            const Text("Email receipt", style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _sendButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.purple,
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        onPressed: () {},
        child: const Text("SEND", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
