import 'package:fcfs_banking_app/core/theme/colors.dart';
import 'package:fcfs_banking_app/core/theme/radialBg.dart';
import 'package:fcfs_banking_app/core/utils/app_helpers.dart';
import 'package:fcfs_banking_app/src/controllers/theme_controller.dart';
import 'package:fcfs_banking_app/src/controllers/user_controller.dart';
import 'package:fcfs_banking_app/src/views/qr_code/generate_qr.dart';
import 'package:fcfs_banking_app/src/views/widget/custom_app_bar.dart';
import 'package:fcfs_banking_app/src/views/widget/slider_button.dart';
import 'package:fcfs_banking_app/src/views/widget/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  UserController userController = Get.find<UserController>();
  final themeController = Get.find<ThemeController>();
  final productNameController = TextEditingController();
  final productPriceController = TextEditingController();
  final newProductCategoryController = TextEditingController();

  List<String> categories = ['Beverages', 'Snacks', 'Veggies'];
  String selectedCategory = 'Category';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: "Add new Product",
        showMoreVertIcon: false,
        showNotificationIcon: false,
        showProfilePic: false,
        onMoreVertTap: () {},
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
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: TextfieldWidget(
                  label: 'Product Name',
                  controller: productNameController,
                  textAlign: TextAlign.start,
                  keyboardType: TextInputType.name,
                  obscureText: false,
                  floatingLabelAlignment: FloatingLabelAlignment.start,
                ),
              ),
              SizedBox(height: 2.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: TextfieldWidget(
                  label: 'Price',
                  controller: productPriceController,
                  textAlign: TextAlign.start,
                  keyboardType: TextInputType.number,
                  obscureText: false,
                  floatingLabelAlignment: FloatingLabelAlignment.start,
                ),
              ),
              SizedBox(height: 2.h),
              GestureDetector(
                onTap: () async {
                  final result = await _categoryPicker(context);
                  if (result != null) {
                    setState(() {
                      selectedCategory = result;
                    });
                  }
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: TextfieldWidget(
                    label: selectedCategory,
                    controller: productPriceController,
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: false,
                    enabled: false,
                    floatingLabelAlignment: FloatingLabelAlignment.start,
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              GestureDetector(
                onTap: () => AppHelpers.pickImage(ImageSource.gallery),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: TextfieldWidget(
                    label: 'Upload image',
                    controller: productPriceController,
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    enabled: false,
                    floatingLabelAlignment: FloatingLabelAlignment.start,
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              SlideButton(onPanEnd: (position) {
                print("Slide button tapped");
              }),
            ],
          )
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
                      amount: 0,
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
                      "Total: \$${0.toStringAsFixed(2)}",
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

  Future<String?> _categoryPicker(BuildContext context) async {
    return await showModalBottomSheet<String>(
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
            ),
          ),
          child: DraggableScrollableSheet(
            expand: false,
            maxChildSize: 0.5,
            minChildSize: 0.5,
            initialChildSize: 0.5,
            builder: (context, scrollController) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Drag Indicator
                    Center(
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
                    const SizedBox(height: 16),

                    // Title
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Select Category",
                        style:
                            Theme.of(context).textTheme.displayMedium?.copyWith(
                                  fontSize: 16.sp,
                                  fontFamily: "Montserrat",
                                ),
                      ),
                    ),
                    SizedBox(height: 1.h),

                    // Category List
                    Expanded(
                      child: categories.isNotEmpty
                          ? ListView.builder(
                              controller: scrollController,
                              itemCount: categories.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Center(
                                    // Centering the text
                                    child: Text(
                                      categories[index],
                                      style: TextStyle(fontSize: 16.sp),
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.pop(context, categories[index]);
                                  },
                                );
                              },
                            )
                          : Center(
                              child: Text(
                                "No categories available",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: AppColors.textGreyColor),
                              ),
                            ),
                    ),

                    const Divider(
                        color: AppColors.grey,
                        thickness: 0.5,
                        indent: 16,
                        endIndent: 16),

                    // Create New Category Button
                    Align(
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _addCategorySheet(context);
                        },
                        child: Text("Create New Category",
                            style: Theme.of(context).textTheme.displayMedium),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _addCategorySheet(BuildContext context) {
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
              maxChildSize: 0.8,
              minChildSize: 0.5,
              initialChildSize: 0.5,
              builder: (context, scrollController) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
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
                        Text(
                          "Add New Category",
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium
                              ?.copyWith(
                                fontSize: 18.sp,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        SizedBox(height: 3.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: TextfieldWidget(
                            label: 'Enter new category',
                            controller: newProductCategoryController,
                            textAlign: TextAlign.start,
                            keyboardType: TextInputType.text,
                            obscureText: false,
                            enabled: true,
                            floatingLabelAlignment:
                                FloatingLabelAlignment.start,
                          ),
                        ),
                        SizedBox(height: 10.h),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Cancel",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium)),
                            TextButton(
                                onPressed: () {
                                  String newCategory =
                                      newProductCategoryController.text.trim();
                                  if (newCategory.isNotEmpty &&
                                      !categories.contains(newCategory)) {
                                    setState(() {
                                      categories.add(newCategory);
                                    });
                                    Navigator.pop(context);
                                    _categoryPicker(context);
                                    newProductCategoryController.clear();
                                  }
                                },
                                child: Text("Create",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium)),
                          ],
                        ),
                        // CustomButtonWidget(
                        //   onTap: () {
                        //     String newCategory =
                        //         newProductCategoryController.text.trim();
                        //     if (newCategory.isNotEmpty &&
                        //         !categories.contains(newCategory)) {
                        //       setState(() {
                        //         categories.add(newCategory);
                        //       });
                        //       Navigator.pop(context);
                        //       _categoryPicker(context);
                        //       newProductCategoryController.clear();
                        //     }
                        //   },
                        //   width: 82.w,
                        //   text: 'Add Category',
                        //   fontSize: 17.sp,
                        //   isIconAvailable: false,
                        //   radius: 10,
                        //   color: themeController.themeMode == ThemeMode.dark
                        //       ? AppColors.darkBorderColor
                        //       : AppColors.red,
                        //   borderColor:
                        //       themeController.themeMode == ThemeMode.dark
                        //           ? AppColors.darkBorderColor
                        //           : AppColors.red,
                        // ),

                        SizedBox(height: 3.h),
                      ],
                    ),
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
