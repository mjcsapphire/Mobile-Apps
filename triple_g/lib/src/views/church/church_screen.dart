import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:triple_g/src/views/widgets/news_events_card.dart';
import 'package:triple_g/src/views/widgets/search_card.dart';
import 'package:triple_g/src/views/widgets/social_post_card.dart';

import '../../../core/utils/colors.dart';
import '../widgets/live_stream_card.dart';

class ChurchScreen extends StatefulWidget {
  const ChurchScreen({super.key});

  @override
  State<ChurchScreen> createState() => _ChurchScreenState();
}

class _ChurchScreenState extends State<ChurchScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 5.h),
              const NewsEventsCard(),
              SizedBox(height: 2.h),
              _buildChurchSelection(textTheme),
              SizedBox(height: 2.h),
              const SearchCard(),
              SizedBox(height: 2.h),
              _buildLiveStreams(textTheme),
            ],
          ),
        ),
      ),
    );
  }

  _buildChurchSelection(TextTheme textTheme) {
    return Container(
      width: 100.w,
      height: 5.h,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.primaryColor,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'st chruches chruch',
                  style: textTheme.bodySmall?.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '2/10',
                  style: textTheme.labelMedium?.copyWith(
                    color: AppColors.white.withOpacity(0.5),
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  _buildLiveStreams(TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 100.w,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'Explore new live steams',
            style: textTheme.titleMedium?.copyWith(
              color: AppColors.secondaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 1.h),
        SizedBox(
          height: 46.h,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 10,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return LiveStreamCard(index: index);
            },
          ),
        ),
        SizedBox(height: 2.h),
        const SocialPostCard(
          gradientAlignmentBegin: Alignment.centerRight,
          gradientAlignmentEnd: Alignment.centerLeft,
        ),
        SizedBox(height: 2.h),
      ],
    );
  }
}
