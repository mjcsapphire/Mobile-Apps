import 'package:fcfs_banking_app/core/theme/colors.dart';
import 'package:fcfs_banking_app/core/utils/constant/app_assets_constant.dart';
import 'package:fcfs_banking_app/services/router/routes_name.dart';
import 'package:fcfs_banking_app/src/views/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../widget/helper_widgets.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldHelperWidget(
      backgroundImage: AppAssetsConstant.splashBackground,
      child: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: const Alignment(-1.0, 1.1),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  height: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(
                                fontFamily: "AnonymousPro",
                              ),
                          children: const [
                            TextSpan(text: "Banking Simpler,\nFaster, "),
                            TextSpan(
                              text: "Better",
                              style: TextStyle(
                                shadows: [
                                  Shadow(
                                    color: AppColors.primaryColor,
                                    offset: Offset(1, 1),
                                    blurRadius: 30,
                                  ),
                                ],
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.70,
                        child: Text(
                          "We care, that’s why we built a fast and simple banking experience. Send money, Save money, anything money.",
                          textAlign: TextAlign.left,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                  color: AppColors.textGreyColor,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w300),
                        ),
                      ),
                      const SizedBox(height: 10),
                      CustomButtonWidget(
                        onTap: () {
                          context.pushNamed(RoutesName.onboarding);
                        },
                        width: MediaQuery.of(context).size.width * 0.85,
                        text: "Find Out Why",
                        isIconAvailable: true,
                        icon: Icon(
                          Icons.arrow_forward_rounded,
                          color: AppColors.white.withOpacity(0.6),
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
