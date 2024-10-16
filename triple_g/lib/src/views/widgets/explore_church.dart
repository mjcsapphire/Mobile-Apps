import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/helpers/helpers.dart';
import '../../../core/utils/colors.dart';
import 'tripleg_button.dart';

class ExploreChurch extends StatefulWidget {
  final int index;
  const ExploreChurch({super.key, required this.index});

  @override
  State<ExploreChurch> createState() => _ExploreChurchState();
}

class _ExploreChurchState extends State<ExploreChurch> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      width: 56.w,
      height: 26.h,
      padding: const EdgeInsets.all(10),
      margin: EdgeInsets.only(
          right: 12, left: widget.index == 0 ? 12 : 0, bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 100.w,
            height: 16.h,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                "https://picsum.photos/200",
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(height: 1.h),
          GText(
            "Marriot Church group",
            style: textTheme.bodySmall!.copyWith(
              color: AppColors.black,
              // fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              GText(
                "Members: 324",
                style: textTheme.bodySmall!.copyWith(
                  color: AppColors.secondaryColor,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.circle,
                size: 6,
                color: AppColors.secondaryColor,
              ),
              const SizedBox(width: 4),
              GText(
                "2+ posts daily",
                style: textTheme.labelSmall!.copyWith(
                  color: AppColors.secondaryColor,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          TripleButton(
            title: "Join Church",
            onTap: () {},
            borderRadius: 16,
            height: 5.h,
            color: AppColors.primaryColor,
            textColor: AppColors.secondaryColor,
          ),
        ],
      ),
    );
  }
}
