import 'package:fcfs_banking_app/core/theme/colors.dart';
import 'package:fcfs_banking_app/core/utils/constant/app_assets_constant.dart';
import 'package:fcfs_banking_app/services/router/routes_name.dart';
import 'package:fcfs_banking_app/src/views/widget/custom_button.dart';
import 'package:fcfs_banking_app/src/views/widget/helper_widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

class RegisterCompleteScreen extends StatefulWidget {
  const RegisterCompleteScreen({super.key});

  @override
  State<RegisterCompleteScreen> createState() => _RegisterCompleteScreenState();
}

class _RegisterCompleteScreenState extends State<RegisterCompleteScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ScaffoldHelperWidget(
      backgroundImage: AppAssetsConstant.onboardingBackground,
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(flex: 2),
            Text(
              'Registration\nComplete',
              textAlign: TextAlign.center,
              style: theme.textTheme.displayMedium!.copyWith(shadows: [
                const Shadow(
                  color: AppColors.white,
                  offset: Offset(1, 1),
                  blurRadius: 6,
                ),
              ], fontSize: 30.sp),
            ),
            const SizedBox(height: 20),
            CustomButtonWidget(
              text: 'Continue',
              width: MediaQuery.of(context).size.width * 0.40,
              isIconAvailable: false,
              onTap: () {
               context.goNamed(RoutesName.loginPage);
              },
            ),
            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Text(
                "You will be able to use some basic features, however until we verify your ID, no money can be deposited. You'll be notified via email and notification when we have verified your ID",
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 15.sp
                ),
              ),
            ),
            const SizedBox(height: 50),
            const Spacer(flex: 3),
          ],
        ),
      ),
    );
  }
}
