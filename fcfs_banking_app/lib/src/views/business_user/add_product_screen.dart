import 'package:fcfs_banking_app/core/theme/colors.dart';
import 'package:fcfs_banking_app/core/theme/radialBg.dart';
import 'package:fcfs_banking_app/core/utils/app_helpers.dart';
import 'package:fcfs_banking_app/services/router/routes_name.dart';
import 'package:fcfs_banking_app/src/controllers/theme_controller.dart';
import 'package:fcfs_banking_app/src/controllers/user_controller.dart';
import 'package:fcfs_banking_app/src/views/qr_code/generate_qr.dart';
import 'package:fcfs_banking_app/src/views/widget/custom_app_bar.dart';
import 'package:fcfs_banking_app/src/views/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  UserController userController = Get.find<UserController>();
  final themeController = Get.find<ThemeController>();
  // Sample data
  final List<String> categories = [
    "Groceries",
    "Electronics",
    "Clothing",
    "Others"
  ];
  final Map<String, List<Map<String, dynamic>>> products = {
    "Groceries": [
      {"name": "Sugar", "price": 0.0, "quantity": 0},
      {"name": "Eggs", "priced": 0.0, "quantity": 0},
      {"name": "Milk", "price": 0.0, "quantity": 0},
    ],
    "Electronics": [
      {"name": "Mobile", "price": 0.0, "quantity": 0},
      {"name": "Laptop", "price": 0.0, "quantity": 0},
    ],
    "Clothing": [
      {"name": "T-Shirt", "price": 0.0, "quantity": 0},
      {"name": "Jeans", "price": 0.0, "quantity": 0},
    ],
    "Others": [
      {"name": "Others", "price": 0.0, "quantity": 0},
    ],
  };

  String selectedCategory = "Groceries";
  double totalAmount = 0.0;

  void _updateTotalAmount() {
    totalAmount = products.entries
        .map((entry) => entry.value
            .fold(0.0, (sum, item) => sum + (item['price'] * item['quantity'])))
        .reduce((a, b) => a + b);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: "Add Product",
        showMoreVertIcon: true,
        showNotificationIcon: false,
        showProfilePic: false,
        onMoreVertTap: () {
          context.pushNamed(RoutesName.productScreen);
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
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: [
                // Left side: Category List
                Container(
                  color: AppColors.transparent,
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 0.9.h),
                      Text(
                        "Categories",
                        style: theme.textTheme.displayMedium?.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Montserrat",
                        ),
                      ),
                      SizedBox(height: 0.9.h),
                      Expanded(
                        child: ListView.builder(
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedCategory = categories[index];
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: selectedCategory == categories[index]
                                      ? themeController.themeMode ==
                                              ThemeMode.dark
                                          ? AppColors.darkBorderColor
                                          : AppColors.pinkColor
                                      : Colors.white.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.all(16),
                                child: Center(
                                  child: Text(
                                    categories[index],
                                    style: theme.textTheme.displaySmall
                                        ?.copyWith(fontSize: 16.sp),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                // Right side: Product List
                Expanded(
                  child: Container(
                    color: AppColors.transparent,
                    padding: const EdgeInsets.all(10),
                    child: ListView.builder(
                      itemCount: products[selectedCategory]!.length,
                      itemBuilder: (context, index) {
                        final product = products[selectedCategory]![index];
                        return Card(
                          color: Colors.white.withOpacity(0.4),
                          elevation: 2,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Product Name
                                Text(
                                  product['name'],
                                  style: theme.textTheme.displaySmall
                                      ?.copyWith(fontSize: 16.sp),
                                ),
                                Row(
                                  children: [
                                    // Quantity Controls
                                    if (product['quantity'] > 0)
                                      Row(
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              if (product['quantity'] > 0) {
                                                setState(() {
                                                  product['quantity']--;
                                                });
                                                _updateTotalAmount();
                                              }
                                            },
                                            icon: Icon(
                                              Icons.remove,
                                              color: themeController
                                                          .themeMode ==
                                                      ThemeMode.dark
                                                  ? AppColors.darkBorderColor
                                                  : AppColors.pinkColor,
                                            ),
                                          ),
                                          Text(
                                            "${product['quantity']}",
                                            style: theme.textTheme.displaySmall
                                                ?.copyWith(fontSize: 18.sp),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              setState(() {
                                                product['quantity']++;
                                              });
                                              _updateTotalAmount();
                                            },
                                            icon: Icon(
                                              Icons.add,
                                              color: themeController
                                                          .themeMode ==
                                                      ThemeMode.dark
                                                  ? AppColors.darkBorderColor
                                                  : AppColors.pinkColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    // Price Input or Add Button
                                    if (product['quantity'] == 0)
                                      SizedBox(
                                        width: 80,
                                        child: TextField(
                                          cursorColor: AppColors.pinkColor,
                                          style: theme.textTheme.displaySmall
                                              ?.copyWith(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.bold),
                                          showCursor: false,
                                          decoration: InputDecoration(
                                            hintText: "Price",
                                            hintStyle: theme
                                                .textTheme.displaySmall
                                                ?.copyWith(
                                              fontSize: 16.sp,
                                              color: AppColors.white
                                                  .withOpacity(0.6),
                                            ),
                                            border: const OutlineInputBorder(),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: AppColors.white
                                                      .withOpacity(0.6)),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: themeController
                                                              .themeMode ==
                                                          ThemeMode.dark
                                                      ? AppColors
                                                          .darkBorderColor
                                                      : AppColors.red),
                                            ),
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 20),
                                          ),
                                          keyboardType: TextInputType.number,
                                          onSubmitted: (value) {
                                            final price =
                                                double.tryParse(value) ?? 0.0;
                                            if (price > 0) {
                                              setState(() {
                                                product['price'] = price;
                                                product['quantity'] = 1;
                                              });
                                              _updateTotalAmount();
                                            }
                                          },
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Bottom Total and Generate QR Button
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: AppColors.transparent,
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Total: \$${totalAmount.toStringAsFixed(2)}",
                      style: theme.textTheme.displayMedium?.copyWith(
                        fontFamily: "Montserrat",
                      )),
                  SizedBox(height: 2.h),
                  CustomButtonWidget(
                    onTap: () {
                      if (totalAmount > 0) {
                        _receivePayment(context);
                      } else {
                        AppHelpers.toast(
                            "Please add some products to generate QR code");
                      }
                    },
                    width: MediaQuery.of(context).size.width * 0.8,
                    text: "Receive via QR Code",
                    isIconAvailable: false,
                    color: themeController.themeMode == ThemeMode.dark
                        ? AppColors.darkBorderColor
                        : AppColors.red,
                    borderColor: themeController.themeMode == ThemeMode.dark
                        ? AppColors.darkBorderColor
                        : AppColors.red,
                    fontSize: 18.sp,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _receivePayment(BuildContext context) {
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
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              )),
          child: DraggableScrollableSheet(
            expand: false,
            maxChildSize: 0.8,
            minChildSize: 0.5,
            initialChildSize: 0.5,
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
                        color: themeController.themeMode == ThemeMode.dark
                            ? AppColors.white
                            : AppColors.textGreyColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Business Name: ${user!.businessName}",
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium
                              ?.copyWith(
                                fontSize: 16.sp,
                                fontFamily: "Montserrat",
                              ),
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          "Phone Number: ${user.phoneNumber}",
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium
                              ?.copyWith(
                                fontSize: 16.sp,
                                fontFamily: "Montserrat",
                              ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Align(
                    alignment: Alignment.center,
                    child: QRGeneratorWidget(
                      amount: totalAmount,
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
                    child: Text(
                      "Total: \$${totalAmount.toStringAsFixed(2)}",
                      style:
                          Theme.of(context).textTheme.displayMedium?.copyWith(
                                color: AppColors.white,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Montserrat",
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
}
