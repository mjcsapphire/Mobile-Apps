import 'dart:io';

import 'package:fcfs_banking_app/core/theme/colors.dart';
import 'package:fcfs_banking_app/core/theme/radialBg.dart';
import 'package:fcfs_banking_app/core/utils/app_helpers.dart';
import 'package:fcfs_banking_app/core/utils/constant/app_assets_constant.dart';
import 'package:fcfs_banking_app/services/router/routes_name.dart';
import 'package:fcfs_banking_app/src/controllers/auth_controller.dart';
import 'package:fcfs_banking_app/src/controllers/theme_controller.dart';
import 'package:fcfs_banking_app/src/views/widget/custom_button.dart';
import 'package:fcfs_banking_app/src/views/widget/textfield_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  File? _selectedImage;
  final _formKey = GlobalKey<FormState>();
  // final _formKey = GlobalKey<FormState>();
  String? selectedRole;

  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController zipcodeController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController businessNameController = TextEditingController();
  TextEditingController govtIdNumberController = TextEditingController();

  final AuthController authController = Get.find<AuthController>();
  final themeController = Get.find<ThemeController>();
  bool isChecked = false;

  @override
  void dispose() {
    emailController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    countryController.dispose();
    zipcodeController.dispose();
    phoneController.dispose();
    businessNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final pages = [
      _buildPersonalDetails(theme),
      _buildAddressAndOther(theme),
    ];
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // BankingBackButton(
              //   onTap: () => context.pop(),
              // ),
              SizedBox(
                height: _currentPage == 0 ? 6.h : 10.h,
              ),
              Text(
                "Register on FANTASY",
                style: theme.textTheme.headlineMedium!.copyWith(shadows: [
                  Shadow(
                    color: theme.colorScheme.shadow,
                    blurRadius: 20,
                  ),
                ], fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 3.h),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => pages[index],
                  itemCount: pages.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                ),
              ),
              SizedBox(height: 1.h),
              Obx(() => authController.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.white,
                      ),
                    )
                  : _currentPage < pages.length - 1
                      ? Column(
                          children: [
                            CustomButtonWidget(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  _pageController.nextPage(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.bounceIn);
                                }
                              },
                              width: MediaQuery.of(context).size.width * 0.7,
                              text: "NEXT",
                              isIconAvailable: false,
                              fontSize: 20.sp,
                              color: themeController.themeMode == ThemeMode.dark
                                  ? AppColors.darkBorderColor
                                  : AppColors.red,
                              borderColor:
                                  themeController.themeMode == ThemeMode.dark
                                      ? AppColors.darkBorderColor
                                      : AppColors.red,
                              radius: 20,
                            ),
                            Center(
                              child: TextButton(
                                onPressed: () {
                                  context.pushNamed(RoutesName.loginPage);
                                },
                                child: Text.rich(
                                  TextSpan(
                                    text: "Already have a Fantasy account? ",
                                    style:
                                        theme.textTheme.displayMedium!.copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17.sp,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "Login",
                                        style: theme.textTheme.displayMedium!
                                            .copyWith(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 17.sp,
                                          color: themeController.themeMode ==
                                                  ThemeMode.dark
                                              ? AppColors.darkTileColor
                                              : AppColors.lightRed,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CustomButtonWidget(
                                  onTap: () {
                                    if (_formKey.currentState!.validate()) {
                                      AppHelpers.saveUser(
                                          key: "isRegistered", value: true);
                                      authController.signUpUser(
                                        firstName: firstNameController.text,
                                        lastName: lastNameController.text,
                                        email: emailController.text,
                                        password: passwordController.text,
                                        country: countryController.text,
                                        zipCode: zipcodeController.text,
                                        phoneNumber: phoneController.text,
                                        role: selectedRole!,
                                        idImage: _selectedImage!,
                                        businessName:
                                            businessNameController.text,
                                      );
                                    }
                                  },
                                  width:
                                      MediaQuery.of(context).size.width * 0.40,
                                  text: "Sign Up",
                                  isIconAvailable: false,
                                  fontSize: 18.sp,
                                  color: themeController.themeMode ==
                                          ThemeMode.dark
                                      ? AppColors.darkBorderColor
                                      : AppColors.red,
                                  radius: 20,
                                  borderColor: themeController.themeMode ==
                                          ThemeMode.dark
                                      ? AppColors.darkBorderColor
                                      : AppColors.red,
                                ),
                                CustomButtonWidget(
                                  onTap: () {
                                    context.pop();
                                  },
                                  width:
                                      MediaQuery.of(context).size.width * 0.40,
                                  text: "Cancel",
                                  isIconAvailable: false,
                                  fontSize: 18.sp,
                                  color: themeController.themeMode ==
                                          ThemeMode.dark
                                      ? AppColors.darkBorderColor
                                      : AppColors.red,
                                  borderColor: themeController.themeMode ==
                                          ThemeMode.dark
                                      ? AppColors.darkBorderColor
                                      : AppColors.red,
                                  radius: 20,
                                ),
                              ],
                            ),

                            // SizedBox(height: 1.h),
                            Center(
                              child: TextButton(
                                onPressed: () {
                                  context.pushNamed(RoutesName.loginPage);
                                },
                                child: Text.rich(
                                  TextSpan(
                                    text: "Already have a Fantasy account? ",
                                    style:
                                        theme.textTheme.displayMedium!.copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17.sp,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "Login",
                                        style: theme.textTheme.displayMedium!
                                            .copyWith(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 17.sp,
                                          color: themeController.themeMode ==
                                                  ThemeMode.dark
                                              ? AppColors.darkTileColor
                                              : AppColors.lightRed,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
              SizedBox(height: 2.h)
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAddressAndOther(ThemeData theme) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.13),
              TextfieldWidget(
                label: 'Government ID Number',
                controller: govtIdNumberController,
                textAlign: TextAlign.left,
                keyboardType: TextInputType.text,
                floatingLabelAlignment: FloatingLabelAlignment.start,
              ),
              SizedBox(height: 2.5.h),
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Text(
                  "Submit ID",
                  style: theme.textTheme.displayMedium!.copyWith(
                    fontWeight: FontWeight.w300,
                    fontSize: 17.sp,
                  ),
                ),
              ),
              SizedBox(height: 0.6.h),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "A valid form of ID includes passport, driving licence, national identity card, and other government IDs",
                  style: theme.textTheme.displayMedium!.copyWith(
                    fontWeight: FontWeight.w300,
                    fontSize: 14.sp,
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      AppAssetsConstant.imgaePickerBorder,
                      color: theme.colorScheme.tertiaryFixed,
                      height: 23.h,
                    ),
                    _selectedImage == null
                        ? Container(
                            width: 68.w,
                            height: 21.h,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              _selectedImage!,
                              width: 68.w,
                              height: 21.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                    if (_selectedImage != null)
                      Positioned(
                        top: 8,
                        right: 8,
                        child: IconButton(
                          icon: const Icon(Icons.cancel, color: Colors.white),
                          onPressed: () {
                            setState(() {
                              _selectedImage = null;
                            });
                          },
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(height: 2.h),
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    _showImagePickerOptions();
                  },
                  child: Text(
                    "Take Picture",
                    style: theme.textTheme.displayMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      shadows: [
                        const Shadow(
                          color: AppColors.white,
                          offset: Offset(1, 1),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPersonalDetails(ThemeData theme) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 1.h),
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Text(
                "Please select your Role",
                style: theme.textTheme.displayMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 17.sp,
                ),
              ),
            ),
            SizedBox(height: 0.6.h),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<String>(
                    tileColor: selectedRole == "Personal"
                        ? AppColors.pinkColor
                        : AppColors.white, // Background color for unselected
                    activeColor: AppColors.pinkColor,
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    title: Text(
                      "Personal",
                      style: theme.textTheme.displayMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 17.sp,
                      ),
                    ),
                    value: "Personal",
                    groupValue: selectedRole,
                    onChanged: (value) {
                      setState(() {
                        selectedRole = value;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    tileColor: selectedRole == "Business"
                        ? AppColors.pinkColor
                        : AppColors.white, // Background color for unselected
                    activeColor: AppColors.pinkColor,
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    title: Text(
                      "Business",
                      style: theme.textTheme.displayMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 17.sp,
                      ),
                    ),
                    value: "Business",
                    groupValue: selectedRole,
                    onChanged: (value) {
                      setState(() {
                        selectedRole = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            if (selectedRole == null)
              Padding(
                padding: const EdgeInsets.only(left: 4, top: 4),
                child: Text(
                  'Please select a role',
                  style: theme.textTheme.displayMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.lightRed,
                    fontSize: 15.sp,
                  ),
                ),
              ),
            SizedBox(height: 2.h),
            TextfieldWidget(
              label: 'First Name',
              controller: firstNameController,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 2.h),
            TextfieldWidget(
              label: 'Last Name',
              controller: lastNameController,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 2.h),
            if (selectedRole == "Business")
              TextfieldWidget(
                label: 'Business Name',
                controller: businessNameController,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.text,
              ),
            SizedBox(height: 1.h),
            TextfieldWidget(
              label: 'Email Address',
              controller: emailController,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 2.h),
            TextfieldWidget(
              label: 'Password',
              controller: passwordController,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
            ),
            // SizedBox(height: 0.6.h),
            // Text(
            //   "Password must be at least 8 characters long",
            //   style: theme.textTheme.displayMedium!
            //       .copyWith(color: AppColors.lightRed, fontSize: 14.sp),
            // ),
            SizedBox(height: 2.h),
            TextfieldWidget(
              label: 'Confirm Password',
              controller: confirmPasswordController,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
            ),
            SizedBox(height: 2.h),
            TextfieldWidget(
              label: 'Telephone Number',
              controller: phoneController,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 2.h),
            TextfieldWidget(
              label: 'ZipCode ',
              controller: zipcodeController,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 2.h),
            TextfieldWidget(
              label: 'Country ',
              controller: countryController,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.text,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Checkbox
                Checkbox(
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value ?? false;
                    });
                  },
                  activeColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),

                // Terms Text
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: theme.textTheme.displaySmall
                          ?.copyWith(fontSize: 15.sp),
                      children: [
                        const TextSpan(text: 'By signing up, I agree to the '),
                        TextSpan(
                          text: 'Terms and Conditions',
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Navigate to Terms and Conditions page
                              print('Navigate to Terms and Conditions');
                            },
                        ),
                        const TextSpan(text: ' and '),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Navigate to Privacy Policy page
                              print('Navigate to Privacy Policy');
                            },
                        ),
                        const TextSpan(text: '.'),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        )),
      ),
    );
  }

  void _showImagePickerOptions() {
    showModalBottomSheet(
      backgroundColor: AppColors.textGreyColor,
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(
              Icons.camera_alt_rounded,
              size: 35,
              color: AppColors.white,
            ),
            title:
                Text("Camera", style: Theme.of(context).textTheme.titleLarge),
            onTap: () async {
              Navigator.of(context).pop();
              File? image = await AppHelpers.pickImage(ImageSource.camera);
              if (image != null) {
                setState(() {
                  _selectedImage = image;
                });
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo, size: 35, color: AppColors.white),
            title:
                Text("Gallery", style: Theme.of(context).textTheme.titleLarge),
            onTap: () async {
              Navigator.of(context).pop();
              File? image = await AppHelpers.pickImage(ImageSource.gallery);
              if (image != null) {
                setState(() {
                  _selectedImage = image;
                });
              }
            },
          ),
        ],
      ),
    );
  }
}
