import 'dart:io';

import 'package:fcfs_banking_app/core/theme/colors.dart';
import 'package:fcfs_banking_app/core/utils/app_helpers.dart';
import 'package:fcfs_banking_app/core/utils/constant/app_assets_constant.dart';
import 'package:fcfs_banking_app/services/router/routes_name.dart';
import 'package:fcfs_banking_app/src/controllers/auth_controller.dart';
import 'package:fcfs_banking_app/src/views/widget/custom_button.dart';
import 'package:fcfs_banking_app/src/views/widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import '../widget/helper_widgets.dart';

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

  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController zipcodeController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  final AuthController authController = Get.find<AuthController>();

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final pages = [
      _buildPersonalDetails(theme),
      _buildAddressAndOther(theme),
    ];
    return ScaffoldHelperWidget(
      backgroundImage: AppAssetsConstant.onboardingBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // BankingBackButton(
          //   onTap: () => context.pop(),
          // ),
          SizedBox(
            height: _currentPage == 0 ? 20.h : 8.h,
          ),
          Text(
            "Account\nCreation",
            style: theme.textTheme.headlineLarge!.copyWith(shadows: [
              Shadow(
                color: theme.colorScheme.shadow,
                blurRadius: 20,
              ),
            ]),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
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
              : CustomButtonWidget(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      if (_currentPage < pages.length - 1) {
                        _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.bounceIn);
                      } else {
                        AppHelpers.saveUser(key: "isRegistered", value: true);
                        authController.signUpUser(
                          firstName: firstNameController.text,
                          lastName: lastNameController.text,
                          email: emailController.text,
                          password: passwordController.text,
                          country: countryController.text,
                          zipCode: zipcodeController.text,
                          phoneNumber: phoneController.text,
                          idImage: _selectedImage!,
                        );
                        Future.delayed(
                          const Duration(seconds: 2),
                          () {
                            context.goNamed(RoutesName.mainPage,
                                pathParameters: {'initialIndex': '0'});
                          },
                        );
                      }
                    }
                  },
                  width: MediaQuery.of(context).size.width * 0.90,
                  text:
                      _currentPage < pages.length - 1 ? "Continue" : "Continue",
                  isIconAvailable: false,
                  fontSize: 17.sp,
                )),
          SizedBox(height: 2.h)
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
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 48.w,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Text(
                            "Country",
                            style: theme.textTheme.displayMedium!.copyWith(
                              fontWeight: FontWeight.w300,
                              fontSize: 17.sp,
                            ),
                          ),
                        ),
                        SizedBox(height: 0.6.h),
                        CustomTextField(
                          controller: countryController,
                          hintText: "Country",
                          obscureText: false,
                          
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter country name';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 36.w,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Text(
                            "ZipCode",
                            style: theme.textTheme.displayMedium!.copyWith(
                              fontWeight: FontWeight.w300,
                              fontSize: 17.sp,
                            ),
                          ),
                        ),
                        SizedBox(height: 0.6.h),
                        CustomTextField(
                          controller: zipcodeController,
                          hintText: "000000",
                          obscureText: false,
                         
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your zipcode name';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Text(
                  "Phone Number",
                  style: theme.textTheme.displayMedium!.copyWith(
                    fontWeight: FontWeight.w300,
                    fontSize: 17.sp,
                  ),
                ),
              ),
              SizedBox(height: 0.6.h),
              CustomTextField(
                controller: phoneController,
                hintText: "+234 000 000 0000",
                obscureText: false,
             
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 2.h),
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
                      color: theme.colorScheme.onPrimary,
                      shadows: [
                        const Shadow(
                          color: AppColors.white,
                          offset: Offset(1, 1),
                          blurRadius: 10,
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
              SizedBox(height: 3.h),
              const Divider(
                color: AppColors.textGreyColor,
                thickness: 1,
              ),
              SizedBox(height: 3.h),
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Text(
                  "Email",
                  style: theme.textTheme.displayMedium!.copyWith(
                    fontWeight: FontWeight.w300,
                    fontSize: 17.sp,
                  ),
                ),
              ),
              SizedBox(height: 0.6.h),
              CustomTextField(
                controller: emailController,
                hintText: "someone@gmail.com",
                obscureText: false,
              
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 2.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 42.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Text(
                            "First Name",
                            style: theme.textTheme.displayMedium!.copyWith(
                              fontWeight: FontWeight.w300,
                              fontSize: 17.sp,
                            ),
                          ),
                        ),
                        SizedBox(height: 0.6.h),
                        CustomTextField(
                          controller: firstNameController,
                          hintText: "Jacob",
                          obscureText: false,
                        
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your first name';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 42.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Text(
                            "Last Name",
                            style: theme.textTheme.displayMedium!.copyWith(
                                fontWeight: FontWeight.w300, fontSize: 17.sp),
                          ),
                        ),
                        SizedBox(height: 0.6.h),
                        CustomTextField(
                          controller: lastNameController,
                          hintText: "Wasowski",
                          obscureText: false,
                       
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your last name';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Text(
                  "Password",
                  style: theme.textTheme.displayMedium!
                      .copyWith(fontWeight: FontWeight.w300, fontSize: 17.sp),
                ),
              ),
              SizedBox(height: 0.6.h),
              CustomTextField(
                controller: passwordController,
                hintText: "password",
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                validator: (value) {
                  AppHelpers.validatePassword(value);
                  return null;
                },
              ),
              SizedBox(height: 2.h),
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Text(
                  "Confirm Password",
                  style: theme.textTheme.displayMedium!
                      .copyWith(fontWeight: FontWeight.w300, fontSize: 17.sp),
                ),
              ),
              SizedBox(height: 0.6.h),
              CustomTextField(
                controller: confirmPasswordController,
                hintText: "confirm password",
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                validator: (value) {
                  if (value != passwordController.text) {
                    return 'Password does not match';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
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
