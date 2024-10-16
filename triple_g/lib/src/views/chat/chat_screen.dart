import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:triple_g/core/utils/colors.dart';

import '../../../core/routes/routes.dart';
import '../widgets/you_may_know.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Friends",
                style: textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.secondaryColor,
                ),
              ),
              SizedBox(height: 1.h),
              SizedBox(
                height: 60.h,
                child: ListView.builder(
                  cacheExtent: 1,
                  itemCount: 6,
                  itemBuilder: (context, index) =>
                      _buildChatCard(textTheme, index),
                ),
              ),
              SizedBox(height: 2.h),
              const YouMayKnow(),
            ],
          ),
        ),
      ),
    );
  }

  _buildChatCard(TextTheme textTheme, int index) {
    return GestureDetector(
      onTap: () => context.go(chatScreen),
      child: Card(
        elevation: 0,
        color: AppColors.white,
        margin: const EdgeInsets.symmetric(vertical: 4),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: ListTile(
          minTileHeight: 8.h,
          minVerticalPadding: 0,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          leading: Badge(
            isLabelVisible: true,
            label: const Text(""),
            offset: const Offset(-5, 36),
            largeSize: 10,
            backgroundColor:
                index == Random().nextInt(6) ? AppColors.green : AppColors.red,
            child: CircleAvatar(
              radius: 24,
              backgroundImage: NetworkImage("https://picsum.photos/${index}00"),
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Cathrine",
                    style: textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "15:32",
                    style: textTheme.bodySmall!.copyWith(
                      color: AppColors.labelColor,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  "Hey how is rehearsal going?",
                  style: textTheme.bodySmall,
                ),
              ),
              if (index % 2 == 0) ...{
                SizedBox(height: 1.h),
                Align(
                  alignment: Alignment.centerRight,
                  child: Badge(
                    smallSize: 10,
                    backgroundColor: index == Random().nextInt(6)
                        ? AppColors.green.withOpacity(0.5)
                        : AppColors.red.withOpacity(0.5),
                  ),
                )
              }
            ],
          ),
        ),
      ),
    );
  }
}
