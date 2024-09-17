import 'package:flutter/material.dart';
import 'package:rise_pathway/config/constants/package_export.dart';
import 'package:rise_pathway/config/helpers/helpers.dart';
import 'package:rise_pathway/config/utils/colors.dart';

class JournalCard extends StatelessWidget {
  final String title;
  final String subtitle;
  const JournalCard({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Container(
      // width: 40.w,
      margin: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Helpers.getColorFromName(title),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            textScaler: TextScaler.noScaling,
            style: theme.bodySmall!.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.journalTitle,
            ),
          ),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            textScaler: TextScaler.noScaling,
            style: theme.labelSmall!.copyWith(
              color: AppColors.journalSubtitle,
              fontWeight: FontWeight.w500,
              fontSize: 10.sp,
            ),
          ),
        ],
      ),
    );
  }
}
