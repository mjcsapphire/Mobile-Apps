import 'dart:io';

import 'package:fcfs_banking_app/core/theme/colors.dart';
import 'package:fcfs_banking_app/core/utils/app_helpers.dart';
import 'package:fcfs_banking_app/core/utils/constant/app_assets_constant.dart';
import 'package:fcfs_banking_app/src/views/widget/custom_app_bar.dart';
import 'package:fcfs_banking_app/src/views/widget/custom_button.dart';
import 'package:fcfs_banking_app/src/views/widget/custom_textfield.dart';
import 'package:flutter/material.dart';
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

  TextEditingController emailController =
      TextEditingController(text: "test@gmail.com");
  TextEditingController firstNameController =
      TextEditingController(text: "Percy");
  TextEditingController lastNameController =
      TextEditingController(text: "Jackson");
  TextEditingController countryController =
      TextEditingController(text: "India");
  TextEditingController zipcodeController =
      TextEditingController(text: "123456");
  TextEditingController phoneController =
      TextEditingController(text: "+91 567 095 2354");

  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Profile",
        showMoreVertIcon: true,
        showNotificationIcon: false,
        showProfilePic: false,
        onMoreVertTap: () {},
        showEditIcon: true,
        onEditIconTap: () {
          setState(() {
            isEditing = !isEditing;
          });
        },
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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              color: AppColors.black,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: Column(
              children: [
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
                                  color: AppColors.textGreyColor, width: 1),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Stack(children: [
                                  CircleAvatar(
                                    radius: 70,
                                    backgroundImage: _selectedImage == null
                                        ? const AssetImage(
                                            AppAssetsConstant.profile)
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
                                                    await AppHelpers.pickImage(
                                                        ImageSource.gallery);
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
                                              )))
                                      : const SizedBox.shrink(),
                                ]),
                                const SizedBox(height: 10),
                                Text(
                                  "${firstNameController.text} ${lastNameController.text}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium!
                                      .copyWith(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 17.sp),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "test@gmail.com",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium!
                                      .copyWith(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 19.sp,
                                          color: AppColors.textGreyColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 3.5.h),
                        _buildPersonalDetails(Theme.of(context)),
                      ],
                    ),
                  ),
                ),
                isEditing
                    ? CustomButtonWidget(
                        onTap: () {},
                        width: MediaQuery.of(context).size.width * 0.9,
                        text: "Update Profile",
                        isIconAvailable: false,
                        color: AppColors.pinkColor,
                        fontSize: 17.sp,
                        borderColor: AppColors.primaryColor,
                      )
                    : const SizedBox.shrink(),
                SizedBox(height: 2.h),
              ],
            ),
          ),
        ],
      ),
    );
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
                              fontSize: 15.sp,
                            ),
                          ),
                        ),
                        SizedBox(height: 0.6.h),
                        CustomTextField(
                          controller: firstNameController,
                          hintText: "Jacob",
                          obscureText: false,
                          editable: isEditing,
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
                                fontWeight: FontWeight.w300, fontSize: 15.sp),
                          ),
                        ),
                        SizedBox(height: 0.6.h),
                        CustomTextField(
                          controller: lastNameController,
                          hintText: "Wasowski",
                          obscureText: false,
                          editable: isEditing,
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
                            "Country",
                            style: theme.textTheme.displayMedium!.copyWith(
                                fontWeight: FontWeight.w300, fontSize: 15.sp),
                          ),
                        ),
                        SizedBox(height: 0.6.h),
                        CustomTextField(
                          controller: countryController,
                          hintText: "India",
                          obscureText: false,
                          editable: false,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter country';
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
                            "Zip Code",
                            style: theme.textTheme.displayMedium!.copyWith(
                                fontWeight: FontWeight.w300, fontSize: 15.sp),
                          ),
                        ),
                        SizedBox(height: 0.6.h),
                        CustomTextField(
                          controller: zipcodeController,
                          hintText: "000000",
                          obscureText: false,
                          editable: false,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your area zip code';
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
                  style: theme.textTheme.displayMedium!
                      .copyWith(fontWeight: FontWeight.w300, fontSize: 15.sp),
                ),
              ),
              SizedBox(height: 0.6.h),
              CustomTextField(
                controller: phoneController,
                hintText: "+91 000 000 0000",
                obscureText: false,
                editable: false,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
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
}
