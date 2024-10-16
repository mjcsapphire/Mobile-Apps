import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:triple_g/core/helpers/helpers.dart';
import 'package:triple_g/core/routes/routes.dart';
import 'package:triple_g/core/utils/colors.dart';
import 'package:triple_g/src/views/widgets/news_events_card.dart';
import 'package:triple_g/src/views/widgets/search_card.dart';
import 'package:triple_g/src/views/widgets/social_post_card.dart';

import '../widgets/explore_church.dart';
import '../widgets/explore_group.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              NewsEventsCard(onTap: () => context.go(newsAndEvents)),
              SizedBox(height: 2.h),
              const SearchCard(),
              SizedBox(height: 2.h),
              _exploreNewGroup(textTheme),
              SizedBox(height: 2.h),
              const SocialPostCard(
                image: "https://picsum.photos/2000/600",
              ),
              SizedBox(height: 2.h),
              _buildExploreChurch(textTheme),
            ],
          ),
        ),
      ),
    );
  }

  _exploreNewGroup(TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          child: GText(
            "Explore new groups",
            style: textTheme.titleMedium!.copyWith(
              color: AppColors.secondaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 1.h),
        SizedBox(
          height: 24.h,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 5,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return ExploreCard(index: index);
            },
          ),
        ),
      ],
    );
  }

  _buildExploreChurch(TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          child: GText(
            "Explore Churches",
            style: textTheme.titleMedium!.copyWith(
              color: AppColors.secondaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 1.h),
        SizedBox(
          height: 32.h,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 5,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return ExploreChurch(index: index);
            },
          ),
        ),
      ],
    );
  }
}
