import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:triple_g/core/helpers/helpers.dart';

import '../../../core/utils/colors.dart';
import '../widgets/white_box.dart';

class DonationPage extends StatefulWidget {
  const DonationPage({super.key});

  @override
  State<DonationPage> createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(42.h),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: SafeArea(
                child: Image.asset(
                  "assets/png/donation_page_header.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              right: 3.h,
              top: 10.5.h,
              child: Text("322",
                  style: textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GText(
                    "GBP",
                    style: textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.labelColor,
                    ),
                  ),
                  GText(
                    "5.00",
                    style: textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ...List.generate(
                      3,
                      (index) => Container(
                        height: 4.h,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: GText(
                          "\$${(index + 1) * 5}.00",
                          style: textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.h),
              SizedBox(
                // width: 85.w,
                child: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    ...List.generate(
                      12,
                      (index) => index == 9
                          ? SizedBox(width: 24.w)
                          : Container(
                              width: 22.w,
                              height: 6.h,
                              alignment: Alignment.center,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                color: index == 11 ? null : AppColors.lightGrey,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: GText(
                                index == 11
                                    ? "DEL"
                                    : index == 10
                                        ? "."
                                        : (index + 1).toString(),
                                style: textTheme.titleMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: index == 11
                                        ? AppColors.grey
                                        : AppColors.black,
                                    fontSize: index == 11 ? 12.sp : 14.sp),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.h),
              WhiteBox(
                isBorder: false,
                margin: const EdgeInsets.all(12.0),
                bgColor: AppColors.primaryColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            "assets/png/donate.png",
                            scale: 3.5,
                            color: AppColors.white,
                          ),
                          const Text(
                            'Donate',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.rotationY(3.14),
                            child: Image.asset(
                              "assets/png/donate.png",
                              color: AppColors.white,
                              scale: 3.5,
                            ),
                          ),
                        ]),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
