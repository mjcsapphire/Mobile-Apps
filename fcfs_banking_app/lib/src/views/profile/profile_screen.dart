import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fcfs_banking_app/core/theme/colors.dart';
import 'package:fcfs_banking_app/core/theme/radialBg.dart';
import 'package:fcfs_banking_app/core/utils/app_helpers.dart';
import 'package:fcfs_banking_app/services/firebase/auth_services.dart';
import 'package:fcfs_banking_app/src/controllers/theme_controller.dart';
import 'package:fcfs_banking_app/src/controllers/user_controller.dart';
import 'package:fcfs_banking_app/src/views/widget/custom_button.dart';
import 'package:fcfs_banking_app/src/views/widget/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  File? _selectedImage;
  UserController userController = Get.find<UserController>();
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController zipcodeController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final AuthService _authService = AuthService();
  final themeController = Get.find<ThemeController>();

  // dummy data
  final List<Map<String, String>> companies = [
    {'name': 'Account 1', 'action': 'View account'},
    {'name': 'Account 2', 'action': 'View account'},
    {'name': 'Account 3', 'action': 'View account'},
  ];

  final List<Map<String, String>> funds = [
    {'name': 'Fund 1', 'action': 'View'},
    {'name': 'Fund 2', 'action': 'View'},
    {'name': 'Fund 3', 'action': 'View'},
  ];

  @override
  void initState() {
    super.initState();

    // Listen to changes in user data and update controllers accordingly
    userController.user.listen((user) {
      if (user != null) {
        firstNameController.text = user.firstName;
        lastNameController.text = user.lastName;
        emailController.text = user.email;
        countryController.text = user.country;
        zipcodeController.text = user.zipCode;
        phoneController.text = user.phoneNumber;
      }
    });

    // Ensure the user data is fetched when the screen loads
    userController.fetchCurrentUserData();
  }

  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    final user = userController.user.value;
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
        SingleChildScrollView(
          child: Column(
            children: [
              // Top Container (Gradient Background)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 56.h,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  gradient: themeController.themeMode == ThemeMode.dark
                      ? AppColors.darkStackContainerBackground
                      : AppColors.stackContainerBackground,
                ),
                child: Column(
                  children: [
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: AppColors.white,
                            size: 6.w,
                          ),
                        ),
                        Text(
                          "Profile",
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                color: AppColors.white,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              isEditing = false;
                            });
                          },
                          icon: Icon(
                            isEditing ? Icons.close : null,
                            color: AppColors.white,
                            size: 6.w,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 2.h),
                            Center(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 10),
                                width: MediaQuery.of(context).size.width * 0.91,
                                decoration: BoxDecoration(
                                  color: AppColors.transparent,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: AppColors.transparent, width: 1),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Stack(
                                      children: [
                                        CircleAvatar(
                                          radius: 80,
                                          backgroundImage: _selectedImage ==
                                                  null
                                              ? CachedNetworkImageProvider(user
                                                      ?.profileImageUrl ??
                                                  "https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png")
                                              : FileImage(_selectedImage!),
                                          backgroundColor: Colors.transparent,
                                        ),
                                        isEditing
                                            ? Positioned(
                                                right: 0,
                                                bottom: 10,
                                                child: IconButton(
                                                  onPressed: () async {
                                                    File? image =
                                                        await AppHelpers
                                                            .pickImage(
                                                                ImageSource
                                                                    .gallery);
                                                    if (image != null) {
                                                      setState(() {
                                                        _selectedImage = image;
                                                      });
                                                    }
                                                  },
                                                  icon: const Icon(
                                                    Icons.camera_alt_outlined,
                                                    color: AppColors.white,
                                                    size: 32,
                                                  ),
                                                ),
                                              )
                                            : const SizedBox.shrink(),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      "${user?.firstName} ${user?.lastName}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium!
                                          .copyWith(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 17.sp,
                                          ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      user?.email ?? '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium!
                                          .copyWith(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 19.sp,
                                            color: AppColors.white,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.h),

              _buildPersonalDetails(Theme.of(context)),

              SizedBox(height: 1.h),
              SectionCard(
                title: 'Accounts',
                items: companies,
                gradient: themeController.themeMode == ThemeMode.dark
                    ? AppColors.dakStackContainerBackground2
                    : AppColors.stackContainerBackground2,
              ),
              SizedBox(height: 1.h),
              SectionCard(
                title: 'My investments',
                items: funds,
                gradient: themeController.themeMode == ThemeMode.dark
                    ? AppColors.darkStackContainerBackground
                    : AppColors.stackContainerBackground,
              ),
              Obx(
                () => userController.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.white,
                        ),
                      )
                    : isEditing
                        ? CustomButtonWidget(
                            onTap: () async {
                              if (_formKey.currentState?.validate() ?? false) {
                                final updatedData = {
                                  "firstName": firstNameController.text,
                                  "lastName": lastNameController.text,
                                  "email": emailController.text,
                                  "country": countryController.text,
                                  "zipcode": zipcodeController.text,
                                  "phoneNumber": phoneController.text,
                                  "profileImageUrl": _selectedImage != null
                                      ? await _authService.storeFileToFirebase(
                                          "profileImageUrl/${user?.uid}",
                                          _selectedImage!,
                                        )
                                      : userController
                                          .user.value?.profileImageUrl,
                                };

                                await userController
                                    .updateUserData(updatedData);

                                setState(() {
                                  isEditing = false;
                                });
                              }
                            },
                            width: MediaQuery.of(context).size.width * 0.95,
                            text: "Save",
                            isIconAvailable: false,
                            color: themeController.themeMode == ThemeMode.dark
                                ? AppColors.darkBorderColor
                                : AppColors.red,
                            fontSize: 17.sp,
                            borderColor:
                                themeController.themeMode == ThemeMode.dark
                                    ? AppColors.darkBorderColor
                                    : AppColors.red,
                            radius: 8,
                          )
                        : CustomButtonWidget(
                            onTap: () async {
                              setState(() {
                                isEditing = true;
                              });
                            },
                            width: MediaQuery.of(context).size.width * 0.95,
                            text: "Edit Profile",
                            isIconAvailable: false,
                            color: themeController.themeMode == ThemeMode.dark
                                ? AppColors.darkBorderColor
                                : AppColors.red,
                            fontSize: 17.sp,
                            borderColor:
                                themeController.themeMode == ThemeMode.dark
                                    ? AppColors.darkBorderColor
                                    : AppColors.red,
                            radius: 8,
                          ),
              ),
              SizedBox(height: 2.h),
            ],
          ),
        ),
      ],
    ));
  }

  Widget _buildPersonalDetails(ThemeData theme) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextfieldWidget(
                label: "First Name",
                controller: firstNameController,
                obscureText: false,
                enabled: isEditing,
                keyboardType: TextInputType.text,
                textAlign: TextAlign.start,
                floatingLabelAlignment: FloatingLabelAlignment.start,
              ),
              SizedBox(height: 2.h),
              TextfieldWidget(
                label: "Last Name",
                controller: lastNameController,
                obscureText: false,
                enabled: isEditing,
                keyboardType: TextInputType.text,
                textAlign: TextAlign.start,
                floatingLabelAlignment: FloatingLabelAlignment.start,
              ),
              SizedBox(height: 2.h),
              TextfieldWidget(
                label: "Country",
                controller: countryController,
                obscureText: false,
                enabled: isEditing,
                keyboardType: TextInputType.text,
                textAlign: TextAlign.start,
                floatingLabelAlignment: FloatingLabelAlignment.start,
              ),
              SizedBox(height: 2.h),
              TextfieldWidget(
                label: "Zip Code",
                controller: zipcodeController,
                obscureText: false,
                enabled: isEditing,
                keyboardType: TextInputType.text,
                textAlign: TextAlign.start,
                floatingLabelAlignment: FloatingLabelAlignment.start,
              ),
              SizedBox(height: 2.h),
              TextfieldWidget(
                label: "Phone Number",
                controller: phoneController,
                obscureText: false,
                enabled: isEditing,
                keyboardType: TextInputType.text,
                textAlign: TextAlign.start,
                floatingLabelAlignment: FloatingLabelAlignment.start,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SectionCard extends StatelessWidget {
  final String title;
  final List<Map<String, String>> items;
  final LinearGradient gradient;

  const SectionCard({
    super.key,
    required this.title,
    required this.items,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ...items.map(
              (item) => SectionItem(
                title: item['name']!,
                action: item['action']!,
              ),
            ),
            SizedBox(height: 2.5.h),
          ],
        ),
      ),
    );
  }
}

class SectionItem extends StatelessWidget {
  final String title;
  final String action;

  const SectionItem({super.key, required this.title, required this.action});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(
          top: BorderSide(color: AppColors.transparent, width: 1),
        ),
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
                color: AppColors.purple,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              action,
              style: const TextStyle(
                  color: AppColors.purple,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
