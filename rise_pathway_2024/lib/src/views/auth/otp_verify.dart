import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:rise_pathway/config/constants/package_export.dart';
import 'package:rise_pathway/config/helpers/helpers.dart';
import 'package:rise_pathway/config/routes/routes.dart';
import 'package:rise_pathway/config/utils/colors.dart';
import 'package:rise_pathway/src/views/widget/rise_button.dart';

class OtpVerify extends StatefulWidget {
  const OtpVerify({super.key});

  @override
  State<OtpVerify> createState() => _OtpVerifyState();
}

class _OtpVerifyState extends State<OtpVerify> {
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: SizedBox(
            height: 90.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/svg/forget_password.svg',
                ),
                SizedBox(height: 2.h),
                RiseText('Verify Email', style: theme.headlineMedium),
                SizedBox(height: 2.h),
                RiseText(
                  'Please Enter The 4 Digit Code Sent to',
                  width: 70.w,
                  textAlign: TextAlign.center,
                  style: theme.labelSmall!.copyWith(
                    color: const Color(0xFF696969),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RiseText(
                      'abcd122@gmail.com',
                      textAlign: TextAlign.center,
                      style: theme.labelSmall!.copyWith(
                        color: AppColors.blue500,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 10),
                    // const Icon(
                    //   Icons.arrow_forward_ios_rounded,
                    //   color: AppColors.blue500,
                    // )
                  ],
                ),
                SizedBox(height: 2.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Pinput(
                      defaultPinTheme: PinTheme(
                        width: 16.w,
                        height: 16.w,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: AppColors.lightGrey,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      focusedPinTheme: PinTheme(
                        width: 16.w,
                        height: 16.w,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: AppColors.primaryColor,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: (s) {
                        return s == '2222' ? null : 'Pin is incorrect';
                      },
                      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                      showCursor: true,
                      // onCompleted: (pin) => print(pin),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                GestureDetector(
                  child: Container(
                    height: 6.h,
                    width: 30.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: AppColors.primaryColor,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (bounds) => AppColorsGredients
                          .primaryTopToBottom
                          .createShader(bounds),
                      child: const Text('Resend OTP'),
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
                const Spacer(),
                RiseButton(
                  title: 'Send',
                  onTap: () => context.go(createNewPassword),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
