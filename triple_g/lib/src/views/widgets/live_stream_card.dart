import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:triple_g/src/views/widgets/tripleg_button.dart';

import '../../../core/helpers/helpers.dart';
import '../../../core/utils/colors.dart';

class LiveStreamCard extends StatefulWidget {
  final int index;
  const LiveStreamCard({super.key, required this.index});

  @override
  State<LiveStreamCard> createState() => _LiveStreamCardState();
}

class _LiveStreamCardState extends State<LiveStreamCard> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      width: 56.w,
      margin: EdgeInsets.only(
        left: 2.w,
        right: widget.index == 0 ? 0 : 2.h,
      ),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                width: 50.w,
                height: 26.h,
                margin: const EdgeInsets.all(4),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    "https://picsum.photos/2000/1000",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Blur(
                blur: 2,
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  height: 8.h,
                  width: 52.w,
                ),
              ),
              Container(
                height: 8.h,
                width: 52.w,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        radius: 24,
                        backgroundImage:
                            NetworkImage("https://picsum.photos/200"),
                        backgroundColor: AppColors.primaryColor,
                      ),
                      SizedBox(width: 1.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GText(
                            "Carry",
                            style: textTheme.titleSmall!.copyWith(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              GText("122",
                                  style: textTheme.bodySmall!.copyWith(
                                    color: AppColors.white,
                                  )),
                              SizedBox(width: 2.w),
                              const Icon(
                                Icons.remove_red_eye_outlined,
                                color: AppColors.white,
                                size: 16,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                      GText(
                        "Live",
                        style: textTheme.titleSmall!.copyWith(
                          color: AppColors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]),
              )
            ],
          ),
          GText(
            "Online pray session, come join!",
            style: textTheme.titleSmall!.copyWith(
              color: AppColors.secondaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          GText(
            "322 Likes",
            style: textTheme.bodySmall!.copyWith(
              color: AppColors.labelColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 2.w),
          TripleButton(
            title: "Join In",
            onTap: () {},
            height: 5.h,
            width: 50.w,
            borderRadius: 16,
            color: AppColors.primaryColor,
            textColor: AppColors.secondaryColor,
          ),
        ],
      ),
    );
  }
}
