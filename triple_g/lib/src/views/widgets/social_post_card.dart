import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/helpers/helpers.dart';
import '../../../core/utils/colors.dart';

class SocialPostCard extends StatefulWidget {
  final Color? gradientColor;
  final Alignment? gradientAlignmentBegin;
  final Alignment? gradientAlignmentEnd;
  final String? title;
  final String? description;
  final String? image;
  const SocialPostCard({
    super.key,
    this.gradientColor,
    this.gradientAlignmentBegin,
    this.gradientAlignmentEnd,
    this.title,
    this.description,
    this.image,
  });

  @override
  State<SocialPostCard> createState() => _SocialPostCardState();
}

class _SocialPostCardState extends State<SocialPostCard> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      width: 100.w,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        // color: AppColors.white,
        gradient: GGredients.socialPostCardGradient(
          widget.gradientColor ?? AppColors.lightBlueteal,
          widget.gradientAlignmentBegin ?? Alignment.topLeft,
          widget.gradientAlignmentEnd ?? Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 6.h,
                width: 6.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.red,
                    width: 1,
                  ),
                ),
                child: CircleAvatar(
                  radius: 6.w,
                  backgroundImage:
                      const NetworkImage("https://picsum.photos/200"),
                ),
              ),
              SizedBox(width: 3.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: "John Doe - ",
                      style: textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.black,
                      ),
                      children: [
                        TextSpan(
                          text: "Live",
                          style: textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.red,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 0.5.h),
                  Row(
                    children: [
                      GText(
                        "Now",
                        style: textTheme.labelMedium!.copyWith(
                          color: AppColors.labelColor,
                        ),
                      ),
                      GText(
                        " • 343 Views • ",
                        style: textTheme.labelMedium!.copyWith(
                          color: AppColors.labelColor,
                        ),
                      ),
                      Icon(
                        Icons.public_outlined,
                        color: AppColors.labelColor,
                        size: 12.sp,
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              const Icon(
                Icons.more_horiz,
                color: AppColors.labelColor,
              ),
            ],
          ),
          SizedBox(height: 1.h),
          GText(
            """
What’s with all these new people joining the app? Is there a new update or something? Either way WELCOME EVERYONE!

Also im going to be going live soon!!! Join up everyone!!!!! Click on my profile! I’ll see ya’ll there! 🙏 🙏🙏🙏🙏""",
            style: textTheme.labelLarge!.copyWith(fontSize: 11.sp),
          ),
          if (widget.image != null)
            Container(
              height: 20.h,
              margin: EdgeInsets.only(top: 1.h),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  widget.image ?? "https://picsum.photos/200",
                  // height: 20.h,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          // SizedBox(height: 1.h),
          Divider(
            color: AppColors.labelColor.withOpacity(0.2),
            thickness: 0.5,
          ),
          Row(
            children: [
              _buildSocialButton(
                textTheme,
                FluentIcons.heart_48_regular,
                "2.3K",
                "Likes",
              ),
              SizedBox(width: 3.w),
              _buildSocialButton(
                textTheme,
                FluentIcons.comment_48_regular,
                "2.3K",
                "Comments",
              ),
              const Spacer(),
              _buildSocialButton(
                textTheme,
                FluentIcons.share_48_regular,
                "2.3K",
                "Shares",
              ),
            ],
          ),
        ],
      ),
    );
  }

  _buildSocialButton(
      TextTheme textTheme, IconData icon, String text, String subText) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.primaryColor,
          size: 20,
        ),
        SizedBox(width: 1.w),
        GText(
          text,
          style: textTheme.labelMedium!.copyWith(
            color: AppColors.black,
          ),
        ),
        GText(
          " $subText",
          style: textTheme.labelMedium!.copyWith(
            color: AppColors.labelColor,
          ),
        ),
      ],
    );
  }
}
