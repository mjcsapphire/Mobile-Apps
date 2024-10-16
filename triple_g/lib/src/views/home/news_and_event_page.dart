import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../../core/helpers/helpers.dart';
import '../../../core/utils/colors.dart';

class NewsAndEventScreen extends StatefulWidget {
  const NewsAndEventScreen({super.key});

  @override
  State<NewsAndEventScreen> createState() => _NewsAndEventScreenState();
}

class _NewsAndEventScreenState extends State<NewsAndEventScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(32.h),
        child: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: const Offset(0, 0),
              blurRadius: 20,
            ),
          ]),
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
                      GText(
                        "Charity event fo Nicolas Primary School",
                        style: textTheme.titleLarge!.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // SizedBox(height: 2.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          GText("1/5",
                              style: textTheme.bodyLarge!.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              )),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
            SizedBox(height: 2.h),
            GText(
              "The phrase \"literally anything\" is often used to express the idea that any possibility is on the table. It signifies a wide range of options or choices without any limitations. When someone says they are open to \"literally anything\" they are indicating their willingness to consider all possibilities. This phrase can be used in various contexts such as when making plans discussing preferences or brainstorming ideas. Overall \"literally anything\".",
              textDecoration: TextDecoration.lineThrough,
              maxLines: 10,
              overflow: TextOverflow.ellipsis,
              style: textTheme.bodyMedium!.copyWith(),
            ),
            SizedBox(height: 2.h),
            Container(
              height: 20.h,
              width: 100.w,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: AppColors.grey),
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  "https://i.sstatic.net/HILmr.png",
                  fit: BoxFit.cover,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
