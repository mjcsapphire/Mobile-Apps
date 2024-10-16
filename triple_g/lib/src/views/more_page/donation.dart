import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:triple_g/core/helpers/helpers.dart';
import 'package:triple_g/core/routes/routes.dart';
import 'package:triple_g/core/utils/colors.dart';
import 'package:triple_g/src/views/widgets/white_box.dart';

class Donation extends StatefulWidget {
  const Donation({super.key});

  @override
  State<Donation> createState() => _DonationState();
}

class _DonationState extends State<Donation> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(32.h),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(3.h),
                bottomRight: Radius.circular(3.h),
              ),
              child: Image.network(
                "https://upload.wikimedia.org/wikipedia/commons/0/01/Newberry_County%2C_South_Carolina._View_of_%28African-American%29_church_in_thinly_populated_areas_of_New_._._._-_NARA_-_522785.jpg",
                fit: BoxFit.cover,
                filterQuality: FilterQuality.low,
                colorBlendMode: BlendMode.darken,
                color: Colors.black.withOpacity(0.3),
              ),
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
                    const Spacer(),
                    Text(
                      "Charity event fo Nicolas Primary School",
                      style: textTheme.titleLarge!.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 2.h)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GText(
                  "About the Event",
                  style: textTheme.titleMedium!.copyWith(
                    color: AppColors.secondaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GText(
                  "5th January",
                  style: textTheme.bodySmall!.copyWith(
                    color: AppColors.labelColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(2),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                color: AppColors.primaryColor,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.white,
                    AppColors.primaryColor,
                    AppColors.primaryColor,
                  ],
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                    ),
                    child: Column(
                      children: [
                        GText(
                          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. ",
                          style: textTheme.titleSmall!.copyWith(
                            color: AppColors.black,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        GText(
                          "\$5,000",
                          style: textTheme.titleSmall!.copyWith(
                            color: AppColors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                  GText(
                    "\$1,932",
                    style: textTheme.headlineSmall!.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  WhiteBox(
                    isBorder: false,
                    margin: const EdgeInsets.all(12.0),
                    onTap: () => context.go(donationPage),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                "assets/png/donate.png",
                                scale: 3.5,
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
                                  scale: 3.5,
                                ),
                              ),
                            ]),
                      ],
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            GText(
                              "Total Donations",
                              style: textTheme.bodySmall!.copyWith(
                                color: AppColors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            GText("253",
                                style: textTheme.bodySmall!.copyWith(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold,
                                ))
                          ],
                        ),
                        Column(
                          children: [
                            GText(
                              "Highest Donation",
                              style: textTheme.bodySmall!.copyWith(
                                color: AppColors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            GText("\$5,00",
                                style: textTheme.bodySmall!.copyWith(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold,
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 2.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
