import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/helpers/helpers.dart';
import '../../../core/utils/colors.dart';
import 'tripleg_button.dart';

class ExploreCard extends StatefulWidget {
  final int index;
  const ExploreCard({super.key, required this.index});

  @override
  State<ExploreCard> createState() => _ExploreCardState();
}

class _ExploreCardState extends State<ExploreCard> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      width: 40.h,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      margin:  EdgeInsets.only(right: 8, left:widget. index ==0 ? 12 : 0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 32,
                backgroundImage: NetworkImage("https://picsum.photos/200"),
                backgroundColor: AppColors.primaryColor,
              ),
              SizedBox(width: 1.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 50.w,
                    child: GText(
                      "Funny Jesus memes and God memes",
                      maxLines: 2,
                      style: textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 1.h),
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
                        "2+ posts a week",
                        style: textTheme.labelSmall!.copyWith(
                          color: AppColors.secondaryColor,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
          SizedBox(
            // width: 70.w,
            child: GText(
              "We love Jesus and god, we meet weekly and have awesome chats about god.",
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 11.sp,
                  ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TripleButton(
                title: "Join",
                onTap: () {},
                height: 4.h,
                width: 50.w,
                borderRadius: 12,
                fontSize: 12.sp,
                color: AppColors.primaryColor,
                textColor: AppColors.black,
              ),
              TripleButton(
                title: "Remove",
                onTap: () {},
                height: 4.h,
                width: 26.w,
                borderRadius: 20,
                fontWeight: FontWeight.w300,
                fontSize: 10.sp,
                color: AppColors.grey,
                textColor: AppColors.black,
              ),
            ],
          )
        ],
      ),
    );
  }
}
