import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:rise_pathway/config/constants/package_export.dart';
import 'package:rise_pathway/config/helpers/helpers.dart';
import 'package:rise_pathway/config/routes/routes.dart';
import 'package:rise_pathway/config/utils/colors.dart';
import 'package:rise_pathway/src/views/widget/app_bar.dart';
import 'package:rise_pathway/src/views/widget/rise_button.dart';
import 'package:rise_pathway/src/views/widget/text_form_field.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final nameController = TextEditingController(text: "Rishabh").obs;
  final emailController = TextEditingController(text: "aL6z2@example.com").obs;
  @override
  void initState() {
    nameController.value.text = "Rishabh";
    emailController.value.text = "aL6z2@example.com";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: RiseAppBar.riseAppBar(
        theme: theme,
        title: 'Profile',
        onTap: () => context.pop(),
      ),
      body: Obx(() {
        return Container(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      height: 16.h,
                      width: 16.h,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1.5.h,
                          color: AppColors.blue.withOpacity(0.2),
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network('https://i.pravatar.cc/300'),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => showModalBottomSheet<void>(
                        context: context,
                        elevation: 0,
                        builder: (context) => Container(
                          height: 26.h,
                          width: 100.w,
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  height: 4,
                                  width: 10.w,
                                  decoration: const BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                              RiseText(
                                'Choose File',
                                style: theme.bodyMedium!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(2.h),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: AppColors.primaryColor,
                                          ),
                                        ),
                                        child: ShaderMask(
                                          shaderCallback: (Rect rect) {
                                            return AppColorsGredients
                                                .primaryTopToBottom
                                                .createShader(rect);
                                          },
                                          blendMode: BlendMode.srcIn,
                                          child: const Icon(
                                            FluentIcons.camera_28_filled,
                                            color: AppColors.primaryColor,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 1.h),
                                      RiseText(
                                        'Camera',
                                        style: theme.bodyMedium!.copyWith(
                                          color: AppColors.primaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(2.h),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: AppColors.primaryColor,
                                          ),
                                        ),
                                        child: ShaderMask(
                                          shaderCallback: (Rect rect) {
                                            return AppColorsGredients
                                                .primaryTopToBottom
                                                .createShader(rect);
                                          },
                                          blendMode: BlendMode.srcIn,
                                          child: const Icon(
                                            FluentIcons.image_48_filled,
                                            color: AppColors.primaryColor,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 1.h),
                                      RiseText(
                                        'Gallery',
                                        style: theme.bodyMedium!.copyWith(
                                          color: AppColors.primaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 48)
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 4, right: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                        child: SvgPicture.asset(
                          'assets/svg/edit.svg',
                          height: 4.h,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 2.h),
                RiseTextField(
                  title: 'Name',
                  hintText: 'Melissa Peters',
                  readOnly: true,
                  keyboardType: TextInputType.visiblePassword,
                  controller: nameController.value,
                ),
                SizedBox(height: 2.h),
                RiseTextField(
                  title: 'Email',
                  hintText: 'melissapeters44@gmail.com',
                  suffixIcon: FluentIcons.mail_48_regular,
                  readOnly: true,
                  keyboardType: TextInputType.visiblePassword,
                  controller: emailController.value,
                ),
                SizedBox(height: 1.h),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => context.go(changePassword),
                    child: RiseText(
                      "Change Password",
                      style: theme.bodySmall!.copyWith(color: AppColors.error),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: RiseButton(
        width: 90.w,
        title: 'Save',
        onTap: () {},
      ),
    );
  }
}
