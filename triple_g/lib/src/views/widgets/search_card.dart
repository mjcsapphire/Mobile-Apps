import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/utils/colors.dart';

class SearchCard extends StatelessWidget {
  const SearchCard({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          CircleAvatar(
            radius: 2.5.h,
            backgroundImage: const NetworkImage("https://picsum.photos/200"),
            backgroundColor: AppColors.primaryColor,
          ),
          Expanded(
            child: Container(
              height: 5.h,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                border: Border.all(width: 1, color: AppColors.secondaryColor),
                borderRadius: BorderRadius.circular(16),
              ),
              child: SearchBar(
                elevation: const WidgetStatePropertyAll(0),
                hintText: "What's on your mind?",
                hintStyle: WidgetStatePropertyAll(textTheme.bodySmall!.copyWith(
                  color: AppColors.grey,
                )),
                shape: const WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                ),
                backgroundColor: const WidgetStatePropertyAll(AppColors.white),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: const Icon(
              Icons.image_outlined,
              size: 32,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}