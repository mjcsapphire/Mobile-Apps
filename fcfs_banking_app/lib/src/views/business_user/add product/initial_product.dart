import 'package:carousel_slider/carousel_slider.dart';
import 'package:fcfs_banking_app/core/theme/colors.dart';
import 'package:fcfs_banking_app/core/theme/radialBg.dart';
import 'package:fcfs_banking_app/services/router/routes_name.dart';
import 'package:fcfs_banking_app/src/controllers/product_controller.dart';
import 'package:fcfs_banking_app/src/controllers/theme_controller.dart';
import 'package:fcfs_banking_app/src/views/business_user/add%20product/dummy_products.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  RxDouble totalAmount = 0.0.obs;
  final productController = Get.find<ProductController>();
  final themeController = Get.find<ThemeController>();

  void _updateTotalAmount() {
    totalAmount.value = categories.fold(0.0, (categorySum, category) {
      return categorySum +
          category['items'].fold(0.0, (itemSum, item) {
            return itemSum + (item['price'] * item['quantity']);
          });
    });
  }

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
            // padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 40),
            padding:
                const EdgeInsets.only(left: 8, right: 8, top: 50, bottom: 20),
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white60),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 45,
                          child: const Icon(Icons.arrow_back,
                              color: Colors.white)),
                      onPressed: () {
                        context.pop();
                      },
                    ),
                    Expanded(
                      child: TextField(
                        style: theme.textTheme.displayMedium,
                        decoration: InputDecoration(
                          hintText: 'Search item',
                          hintStyle: theme.textTheme.displayMedium,
                          filled: true,
                          fillColor: Colors.white30,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white60),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 45,
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        context.pushNamed(RoutesName.addProduct);
                      },
                    ),
                  ],
                ),
                SizedBox(height: 3.h),
                Expanded(
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height: MediaQuery.of(context).size.height * 0.7,
                      enableInfiniteScroll: true,
                      viewportFraction: 0.85,
                      enlargeCenterPage: true,
                      enlargeStrategy: CenterPageEnlargeStrategy.scale,
                      initialPage: 1,
                    ),
                    items: categories.map((category) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Column(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [Colors.purple, Colors.pinkAccent],
                                  ),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10)),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                alignment: Alignment.center,
                                child: Text(
                                  category['name'],
                                  style: theme.textTheme.displayMedium,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: themeController.themeMode ==
                                            ThemeMode.dark
                                        ? AppColors.darkTransferBgColor1
                                        : AppColors.pinkColor,
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                  ),
                                  child: ListView.builder(
                                    itemCount: category['items'].length,
                                    itemBuilder: (context, index) {
                                      final item = category['items'][index];
                                      return Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 5),
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.white60),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        width: double.infinity,
                                        child: Card(
                                          color: themeController.themeMode ==
                                                  ThemeMode.dark
                                              ? Colors.transparent
                                              : AppColors.pinkColor,
                                          child: ListTile(
                                            leading: Image.asset(item['image'],
                                                width: 50),
                                            title: Text(
                                              item['name'],
                                              style: theme
                                                  .textTheme.displayMedium
                                                  ?.copyWith(fontSize: 17.sp),
                                            ),
                                            subtitle: Text(
                                                '\$${item['price'].toStringAsFixed(2)}',
                                                style: theme
                                                    .textTheme.displayMedium),
                                            trailing: item['quantity'] > 0
                                                ? Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      IconButton(
                                                        onPressed: () {
                                                          if (category['items']
                                                                      [index]
                                                                  ['quantity'] >
                                                              0) {
                                                            setState(() {
                                                              category['items']
                                                                      [index][
                                                                  'quantity']--;
                                                            });
                                                            _updateTotalAmount();

                                                            productController
                                                                .removeProduct(
                                                                    category[
                                                                            'items']
                                                                        [
                                                                        index]);
                                                          }
                                                        },
                                                        icon: Icon(
                                                          Icons.remove,
                                                          color: themeController
                                                                      .themeMode ==
                                                                  ThemeMode.dark
                                                              ? AppColors
                                                                  .darkBorderColor
                                                              : AppColors.red,
                                                        ),
                                                      ),
                                                      Text(
                                                        "${category['items'][index]['quantity']}",
                                                        style: theme.textTheme
                                                            .displaySmall
                                                            ?.copyWith(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18.sp,
                                                        ),
                                                      ),
                                                      IconButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            category['items']
                                                                    [index]
                                                                ['quantity']++;
                                                          });
                                                          _updateTotalAmount();
                                                        },
                                                        icon: Icon(
                                                          Icons.add,
                                                          color: themeController
                                                                      .themeMode ==
                                                                  ThemeMode.dark
                                                              ? AppColors
                                                                  .darkBorderColor
                                                              : AppColors.red,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                : IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        category['items'][index]
                                                            ['quantity']++;
                                                      });
                                                      _updateTotalAmount();
                                                      productController
                                                          .addProduct(
                                                              category['items']
                                                                  [index]);
                                                    },
                                                    icon: const Icon(Icons.add,
                                                        color: Colors.white),
                                                  ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: theme.textTheme.displayMedium,
                      ),
                      Text(
                        '\$${totalAmount.toStringAsFixed(2)}',
                        style: theme.textTheme.displayMedium,
                      ),
                      TextButton(
                        onPressed: () {
                          if (totalAmount.value > 0) {
                            context.pushNamed(RoutesName.productBilling);
                          }
                        },
                        child: Text(
                          'Next',
                          style: theme.textTheme.displayMedium,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
