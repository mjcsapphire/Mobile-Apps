import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:triple_g/core/helpers/helpers.dart';
import 'package:triple_g/src/views/widgets/white_box.dart';

import '../../../core/utils/colors.dart';

class SermonsDetailScreen extends StatefulWidget {
  const SermonsDetailScreen({super.key, required this.isLive});
  final bool isLive;

  @override
  State<SermonsDetailScreen> createState() => _SermonsDetailScreenState();
}

class _SermonsDetailScreenState extends State<SermonsDetailScreen> {
  final scrollController = ScrollController();

  final isScroll = true.obs;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.isLive) {
        return;
      }
      scrollController.addListener(() {
        if (scrollController.position.userScrollDirection ==
            ScrollDirection.reverse) {
          isScroll.value = false;
        } else if (scrollController.position.userScrollDirection ==
            ScrollDirection.forward) {
          isScroll.value = true;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Obx(() => Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(isScroll.value ? 32.h : 24.h),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                boxShadow: [
                  if (!isScroll.value)
                    const BoxShadow(
                      color: Colors.white,
                      spreadRadius: 20,
                      blurRadius: 50,
                      offset: Offset(0, 3),
                    ),
                ],
              ),
              child: Stack(
                children: [
                  if (isScroll.value)
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
                        color: Colors.black.withOpacity(0.5),
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
                          if (widget.isLive)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GText(
                                  "・Live",
                                  style: textTheme.titleSmall!.copyWith(
                                    color: AppColors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    GText(
                                      "Started: 03:13",
                                      style: textTheme.labelMedium!.copyWith(
                                        color: AppColors.white,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.alarm,
                                          color: AppColors.primaryColor,
                                          size: 12.sp,
                                        ),
                                        SizedBox(width: 1.w),
                                        GText(
                                          "15:22",
                                          style: textTheme.labelLarge!.copyWith(
                                            color: AppColors.primaryColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          Text(
                            "Felt need: messages on life change, behaviors or habits",
                            textAlign: isScroll.value ? null : TextAlign.center,
                            style: textTheme.titleLarge!.copyWith(
                                color: widget.isLive
                                    ? AppColors.white
                                    : isScroll.value
                                        ? AppColors.white
                                        : AppColors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: isScroll.value ? null : 14.sp),
                          ),
                          SizedBox(height: 2.h),
                          if (!isScroll.value && !widget.isLive)
                            WhiteBox(
                              radius: 10,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(
                                        Icons.pause,
                                        color: AppColors.primaryColor,
                                        size: 16.sp,
                                      ),
                                      SizedBox(
                                        width: 55.w,
                                        child: LinearProgressIndicator(
                                          value: .25,
                                          minHeight: 1.h,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          valueColor:
                                              const AlwaysStoppedAnimation<
                                                  Color>(
                                            AppColors.black,
                                          ),
                                          backgroundColor:
                                              AppColors.grey.withOpacity(0.5),
                                        ),
                                      ),
                                      GText(
                                        "0:23 / 3:45",
                                        style: textTheme.labelLarge!.copyWith(
                                          color: AppColors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          body: SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                Container(
                  height: 6.h,
                  width: 100.w,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: AppColors.primaryColor,
                      ),
                      GText(
                        widget.isLive ? "Live Notes" : "Transcript",
                        style: textTheme.bodySmall!.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: AppColors.primaryColor,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 2.h),
                if (isScroll.value && !widget.isLive)
                  WhiteBox(
                    radius: 10,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.pause,
                              color: AppColors.primaryColor,
                              size: 16.sp,
                            ),
                            SizedBox(
                              width: 55.w,
                              child: LinearProgressIndicator(
                                value: .25,
                                minHeight: 1.h,
                                borderRadius: BorderRadius.circular(20),
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                  AppColors.black,
                                ),
                                backgroundColor:
                                    AppColors.grey.withOpacity(0.5),
                              ),
                            ),
                            GText(
                              "0:23 / 3:45",
                              style: textTheme.labelLarge!.copyWith(
                                color: AppColors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                SizedBox(height: 2.h),
                if (widget.isLive)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 2.w,
                            height: 30.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 2.w),
                      Flexible(
                        child: SizedBox(
                          height: 30.h,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GText(
                                "Live Sermon notes",
                                style: textTheme.titleSmall!.copyWith(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              GText(
                                "God is Amazing",
                                style: textTheme.titleSmall!.copyWith(
                                  color: AppColors.black,
                                ),
                              ),
                              GText(
                                "Yes, God is Amazing",
                                style: textTheme.titleSmall!.copyWith(
                                  color: AppColors.black,
                                ),
                              ),
                              GText(
                                "Woah",
                                style: textTheme.titleSmall!.copyWith(
                                  color: AppColors.black,
                                ),
                              ),
                              GText(
                                "1. god is all powerful",
                                style: textTheme.titleSmall!.copyWith(
                                  color: AppColors.black,
                                ),
                              ),
                              GText(
                                "2. this is the second bullet point that extends a little further",
                                style: textTheme.titleSmall!.copyWith(
                                  color: AppColors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ListView.builder(
                  itemCount: 3,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.only(bottom: 4.h),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    width: 2.w,
                                    height: 38.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 2.w),
                              Flexible(
                                child: SizedBox(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GText(
                                        "Title of the text",
                                        style: textTheme.titleSmall!.copyWith(
                                          color: AppColors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      GText(
                                        "The phrase \"literally anything\" is often used to express the idea that any possibility is on the table. It signifies a wide range of options or choices without any limitations. When someone says they are open to \"literally anything\" they are indicating their willingness to consider all possibilities. This phrase can be used in various contexts such as when making plans discussing preferences or brainstorming ideas. Overall \"literally anything\" emphasizes the idea of being.",
                                        style: textTheme.bodyMedium!.copyWith(
                                          color: AppColors.black,
                                          fontSize: 13.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
