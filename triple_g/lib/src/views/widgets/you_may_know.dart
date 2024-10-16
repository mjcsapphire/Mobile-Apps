import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/utils/colors.dart';

class YouMayKnow extends StatelessWidget {
  const YouMayKnow({super.key, this.isAdd});
  final bool? isAdd;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "You May Know",
          style: textTheme.titleMedium!.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.secondaryColor,
          ),
        ),
        SizedBox(height: 1.h),
        SizedBox(
          height: isAdd ?? true ? 16.h : 14.h,
          width: 100.w,
          child: ListView.builder(
            itemCount: 6,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) => _buildYouMayKnow(textTheme, index),
          ),
        ),
      ],
    );
  }

  _buildYouMayKnow(TextTheme textTheme, int index) {
    return GestureDetector(
      // onTap: () => context.go("/$c"),
      child: Card(
        elevation: 0,
        color: AppColors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Badge(
                isLabelVisible: true,
                label: const Text(""),
                offset: const Offset(-5, 36),
                largeSize: 10,
                backgroundColor: index == Random().nextInt(6)
                    ? AppColors.green
                    : AppColors.red,
                child: CircleAvatar(
                  radius: 24,
                  backgroundImage:
                      NetworkImage("https://picsum.photos/20$index"),
                ),
              ),
              Text(
                "Catherine",
                style: textTheme.bodySmall!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (isAdd ?? true)
                Text(
                  "Add",
                  style: textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryColor,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
