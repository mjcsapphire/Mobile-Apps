import 'package:fcfs_banking_app/core/theme/colors.dart';
import 'package:fcfs_banking_app/core/theme/radialBg.dart';
import 'package:fcfs_banking_app/services/router/routes_name.dart';
import 'package:fcfs_banking_app/src/controllers/product_controller.dart';
import 'package:fcfs_banking_app/src/controllers/theme_controller.dart';
import 'package:fcfs_banking_app/src/views/widget/slider_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

class ProductBilling extends StatefulWidget {
  const ProductBilling({super.key});

  @override
  State<ProductBilling> createState() => _ProductBillingState();
}

class _ProductBillingState extends State<ProductBilling> {
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
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 70.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                    gradient: themeController.themeMode == ThemeMode.dark
                        ? AppColors.darkStackContainerBackground
                        : AppColors.stackContainerBackground2,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text('Product Billing',
                            style: theme.textTheme.displayMedium),
                      ),
                      const Divider(color: Colors.white),
                      Expanded(
                        child: Obx(() => ListView.builder(
                              itemCount:
                                  productController.selectedProducts.length,
                              itemBuilder: (context, index) {
                                var item =
                                    productController.selectedProducts[index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 16),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          '${item['name']} x ${item['quantity']}',
                                          style: theme.textTheme.displayMedium),
                                      Text(
                                          '\$${(item['price'] * item['quantity']).toStringAsFixed(2)}',
                                          style: theme.textTheme.displayMedium),
                                    ],
                                  ),
                                );
                              },
                            )),
                      ),
                      const Divider(color: Colors.white),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Obx(() => Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Total',
                                        style: theme.textTheme.displayMedium),
                                    Text(
                                      '\$${productController.totalAmount.toStringAsFixed(2)}',
                                      style: theme.textTheme.displayMedium,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 2.h),
                                TextButton(
                                  onPressed: () {
                                    context.pop();
                                  },
                                  child: Text('Amend',
                                      style: theme.textTheme.displayMedium),
                                ),
                                //  SizedBox(height: 1.h),
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 6.h),
                SlideButton(onPanEnd: (position) {
                  context.pushNamed(RoutesName.choosePayment);
                })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
