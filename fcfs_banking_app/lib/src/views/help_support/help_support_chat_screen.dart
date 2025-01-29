import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fcfs_banking_app/core/theme/colors.dart';
import 'package:fcfs_banking_app/core/utils/app_helpers.dart';
import 'package:fcfs_banking_app/core/utils/constant/app_assets_constant.dart';
import 'package:fcfs_banking_app/services/router/routes_name.dart';
import 'package:fcfs_banking_app/src/controllers/theme_controller.dart';
import 'package:fcfs_banking_app/src/controllers/user_controller.dart';
import 'package:fcfs_banking_app/src/views/help_support/triangle.dart';
import 'package:fcfs_banking_app/src/views/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class SupportChatScreen extends StatefulWidget {
  const SupportChatScreen({super.key});

  @override
  State<SupportChatScreen> createState() => _SupportChatScreenState();
}

class _SupportChatScreenState extends State<SupportChatScreen> {
  final userController = Get.find<UserController>();
  final themeController = Get.find<ThemeController>();
  bool isAttachmentOpen = false;
  bool isTnCAcepted = false;
  File? selectedFile;
  String? selectedFileType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: themeController.themeMode == ThemeMode.dark
                ? AppColors.darkBgColor1
                : AppColors.whiteChat,
          ),
          Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.14,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(35),
                    bottomRight: Radius.circular(35),
                  ),
                  gradient: themeController.themeMode == ThemeMode.dark
                      ? AppColors.darkStackContainerBackground
                      : AppColors.stackContainerBackground,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Obx(
                    () {
                      final user = userController.user.value;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              height: MediaQuery.of(context).padding.top + 10),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  context.pushNamed(RoutesName.profileScreen);
                                },
                                child: CircleAvatar(
                                  radius: 5.w,
                                  backgroundColor: Colors.white24,
                                  backgroundImage: user?.profileImageUrl != null
                                      ? CachedNetworkImageProvider(
                                          user!.profileImageUrl!)
                                      : const AssetImage(
                                          AppAssetsConstant.profile2),
                                ),
                              ),
                              const Spacer(),
                              Text(
                                "Agent Name",
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              const Spacer(),
                              TextButton(
                                  onPressed: () {
                                    context.pop();
                                  },
                                  child: Text(
                                    "Exit",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium!
                                        .copyWith(
                                            fontWeight: FontWeight.normal),
                                  )),
                              GestureDetector(
                                onTap: () {},
                                child: const Icon(
                                  Icons.more_vert,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        'Today',
                        style: TextStyle(
                          color: themeController.themeMode == ThemeMode.dark
                              ? Colors.white
                              : Colors.black54,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      _buildMessageBubble(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                          isSender: true),
                      _buildMessageBubble(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                          isSender: false),
                      _buildMessageBubble(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                          isSender: true),
                      SizedBox(height: 5.h),
                      isTnCAcepted
                          ? const SizedBox.shrink()
                          : Center(child: _buildSpecialMessage(context)),
                    ],
                  ),
                ),
              ),
              if (selectedFile != null) _buildFilePreview(),
              _buildInputArea(context),
            ],
          ),
          if (selectedFile == null)
            if (isAttachmentOpen)
              Positioned(
                bottom: 10.h,
                right: 0,
                child: _buildFileAttAchment(context),
              ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(String message, {required bool isSender}) {
    return Align(
      alignment: isSender ? Alignment.topRight : Alignment.topLeft,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Message Bubble
          Container(
            width: 55.w,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: isSender
                  ? themeController.themeMode == ThemeMode.dark
                      ? AppColors.darkBorderColor
                      : AppColors.purple
                  : themeController.themeMode == ThemeMode.dark
                      ? AppColors.transparent
                      : Colors.white,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                  color: isSender
                      ? Colors.transparent
                      : themeController.themeMode == ThemeMode.dark
                          ? AppColors.darkBorderColor
                          : Colors.red),
            ),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isSender
                    ? AppColors.white
                    : themeController.themeMode == ThemeMode.dark
                        ? AppColors.white
                        : Colors.black,
                fontSize: 15.sp,
              ),
            ),
          ),
          // App logo for fantasy app support
          if (!isSender)
            Positioned(
              left: 2.w,
              top: -1.h,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.peachOrange,
                    width: 1.5,
                  ),
                ),
                child: Image.asset(
                  AppAssetsConstant.applogo,
                  width: 30,
                  height: 30,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSpecialMessage(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: themeController.themeMode == ThemeMode.dark
                ? AppColors.darkStackContainerBackground
                : AppColors.stackContainerBackground,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              SizedBox(height: 2.h),
              Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButtonWidget(
                    onTap: () {
                      setState(() {
                        isTnCAcepted = true;
                      });
                    },
                    width: MediaQuery.of(context).size.width * 0.3,
                    text: "Accept",
                    isIconAvailable: false,
                    color: themeController.themeMode == ThemeMode.dark
                        ? AppColors.darkBorderColor
                        : AppColors.purple,
                    borderColor: themeController.themeMode == ThemeMode.dark
                        ? AppColors.darkBorderColor
                        : AppColors.purple,
                    radius: 6,
                    fontSize: 17.sp,
                  ),
                  SizedBox(width: 2.w),
                  CustomButtonWidget(
                    onTap: () {
                      setState(() {
                        isTnCAcepted = false;
                      });
                    },
                    width: MediaQuery.of(context).size.width * 0.3,
                    text: "Decline",
                    isIconAvailable: false,
                    color: themeController.themeMode == ThemeMode.dark
                        ? AppColors.darkBorderColor
                        : AppColors.purple,
                    borderColor: themeController.themeMode == ThemeMode.dark
                        ? AppColors.darkBorderColor
                        : AppColors.purple,
                    radius: 6,
                    fontSize: 17.sp,
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: -MediaQuery.of(context).size.height * 0.015,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border(
                  top: BorderSide(
                    color: AppColors.peachOrange,
                    width: 2,
                  ),
                  left: BorderSide(
                    color: AppColors.peachOrange,
                    width: 2,
                  ),
                  right: BorderSide(
                    color: AppColors.peachOrange,
                    width: 2,
                  ),
                ),
              ),
              child: Image.asset(
                AppAssetsConstant.applogo,
                height: 30,
                width: 30,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInputArea(BuildContext context) {
    return Container(
      height: 10.h,
      padding: const EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        gradient: themeController.themeMode == ThemeMode.dark
            ? AppColors.darkStackContainerBackground
            : AppColors.stackContainerBackground,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Text input field
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Type message...',
                hintStyle: Theme.of(context).textTheme.displayMedium,
                border: InputBorder.none,
              ),
              cursorColor: AppColors.white,
              style: Theme.of(context)
                  .textTheme
                  .displayMedium
                  ?.copyWith(color: Colors.white),
              keyboardType: TextInputType.multiline,
              maxLines: null,
            ),
          ),
          // Send button
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: themeController.themeMode == ThemeMode.dark
                    ? AppColors.darkBorderColor
                    : AppColors.white,
              ),
              child: Icon(
                Icons.send,
                color: themeController.themeMode == ThemeMode.dark
                    ? AppColors.white
                    : Colors.red,
                size: 20.sp,
              ),
            ),
          ),
          Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: DiagonalTriangle(
                  color: themeController.themeMode == ThemeMode.dark
                      ? AppColors.darkBgColor1
                      : AppColors.red,
                  width: MediaQuery.of(context).size.width * 0.22,
                  height: 10.h,
                ),
              ),
              Positioned(
                top: 8,
                right: 0,
                child: Transform.rotate(
                  angle: 3.7,
                  child: IconButton(
                    icon: isAttachmentOpen
                        ? Transform.rotate(
                            angle: -3.7,
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 30,
                            ),
                          )
                        : const Icon(
                            Icons.attach_file,
                            color: Colors.white,
                            size: 30,
                          ),
                    onPressed: () {
                      // Attach file functionality
                      setState(() {
                        isAttachmentOpen = !isAttachmentOpen;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFileAttAchment(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height * 0.21,
      width: MediaQuery.of(context).size.width * 0.3,
      decoration: BoxDecoration(
        color: themeController.themeMode == ThemeMode.dark
            ? AppColors.darkBorderColor
            : AppColors.red,
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(8)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () async {
              final file = await AppHelpers.pickImage(ImageSource.camera);
              if (file != null) {
                setState(() {
                  selectedFile = file;
                  selectedFileType = 'image';
                });
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "camera",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const Spacer(),
                const Icon(
                  Icons.camera_alt,
                  size: 28,
                  color: AppColors.white,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () async {
              final file = await AppHelpers.pickImage(ImageSource.gallery);
              setState(() {
                selectedFile = file;
                selectedFileType = 'image';
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Gallery",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const Spacer(),
                const Icon(
                  Icons.browse_gallery_rounded,
                  size: 28,
                  color: AppColors.white,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () async {
              final file = await AppHelpers.pickFile();
              if (file != null) {
                setState(() {
                  selectedFile = file;
                  selectedFileType = 'file';
                });
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "File",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const Spacer(),
                const Icon(
                  Icons.file_present,
                  size: 28,
                  color: AppColors.white,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildFilePreview() {
    if (selectedFile == null) return const SizedBox.shrink();

    switch (selectedFileType) {
      case 'image':
        return Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                    color: themeController.themeMode == ThemeMode.dark
                        ? AppColors.darkBorderColor
                        : AppColors.purple,
                    width: 2),
              ),
              child: Image.file(
                selectedFile!,
                height: 200,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              right: 10,
              top: 10,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: themeController.themeMode == ThemeMode.dark
                      ? AppColors.darkBorderColor
                      : AppColors.purple,
                ),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedFile = null;
                      selectedFileType = null;
                    });
                  },
                  child: const Icon(
                    Icons.close,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ],
        );
      case 'file':
        return Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(
                color: themeController.themeMode == ThemeMode.dark
                    ? AppColors.darkBorderColor
                    : AppColors.purple,
                width: 2),
          ),
          child: Row(
            children: [
              const Icon(Icons.insert_drive_file, size: 30),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  selectedFile!.path.split('/').last,
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        color: themeController.themeMode == ThemeMode.dark
                            ? AppColors.white
                            : AppColors.purple,
                      ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    selectedFile = null;
                    selectedFileType = null;
                  });
                },
              ),
            ],
          ),
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
