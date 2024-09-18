import 'package:flutter/material.dart';
import 'package:rise_pathway/config/constants/package_export.dart';
import 'package:rise_pathway/config/helpers/helpers.dart';
import 'package:rise_pathway/config/utils/colors.dart';
import 'package:rise_pathway/src/views/widget/app_bar.dart';

class AddNewJournal extends StatefulWidget {
  const AddNewJournal({super.key});

  @override
  State<AddNewJournal> createState() => _AddNewJournalState();
}

class _AddNewJournalState extends State<AddNewJournal> {
  final selectedIndex = 0.obs;
  final List<String> _emotions = [
    'Work',
    'Exercise',
    'Family',
    'Hobbies',
    'Finances',
    'Sleep',
    'Education',
    'Relationships',
  ];

  @override
  Widget build(BuildContext context) {
    // final double scaleFactor = MediaQuery.of(context).textScaleFactor;

    List<String> images = [
      'Emoji.png',
      'Emoji-1.png',
      'Emoji-2.png',
      'Emoji-3.png',
      'Emoji-4.png',
    ];
    List<String> gif = [
      'face-with-steam-from-nose.gif',
      'disappointed-face.gif',
      'neutral-face.gif',
      'smiling-face.gif',
      'smiling-face-with-hearts.gif',
    ];
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: RiseAppBar.riseAppBar(
        theme: Theme.of(context).textTheme,
        title: 'My First Journal',
        isAdd: true,
        onTap: () => context.pop(),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 3.h, vertical: 2.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: RiseText(
                'How are you feeling?',
                style: theme.titleLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            SizedBox(height: 3.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                5,
                (index) => GestureDetector(
                  onTap: () => selectedIndex.value = index,
                  child: Obx(() => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 0.6.h),
                        child: Image.asset(
                          selectedIndex.value == index
                              ? "assets/gif/${gif[index]}"
                              : "assets/mood_rate/${images[index]}",
                          scale: selectedIndex.value == index ? 5 : 3,
                        ),
                      )),
                ),
              ),
            ),
            SizedBox(height: 3.h),
            RiseText(
              'What’s affecting your mood',
              style: theme.titleSmall!.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor,
              ),
            ),
            SizedBox(height: 1.h),
            Wrap(
              children: List.generate(
                8,
                (index) => Container(
                  margin: const EdgeInsets.all(8),
                  padding: EdgeInsets.symmetric(
                    horizontal: 2.h,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      width: 2,
                      color: AppColors.skyBlue,
                    ),
                  ),
                  child: RiseText(
                    _emotions[index],
                    style: theme.labelSmall!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 2.h),
            RiseText(
              'Let’s write about it',
              style: theme.titleSmall!.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor,
              ),
            ),
            SizedBox(height: 1.5.h),
            TextFormField(
              maxLines: 8,
              decoration: InputDecoration(
                hintText:
                    'How is your day going? How has it affected your mood? or anything else...',
                hintStyle: theme.labelMedium!.copyWith(
                  color: AppColors.journalSubtitle,
                ),
                enabled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              style: theme.labelMedium,
            ),
            SizedBox(height: 2.h),
            Container(
              height: 6.h,
              width: 100.w,
              margin: EdgeInsets.only(bottom: 5.h),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: AppColorsGredients.primaryTopToBottom,
              ),
              child: RiseText(
                'Add',
                textAlign: TextAlign.center,
                style: theme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
