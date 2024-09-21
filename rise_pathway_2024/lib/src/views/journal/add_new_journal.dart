import 'package:flutter/material.dart';
import 'package:rise_pathway/core/constants/package_export.dart';
import 'package:rise_pathway/core/helpers/helpers.dart';
import 'package:rise_pathway/core/utils/colors.dart';
import 'package:rise_pathway/src/views/widget/app_bar.dart';
import 'package:rise_pathway/src/views/widget/text_form_field.dart';

class AddNewJournal extends StatefulWidget {
  final String? title;
  final String? description;
  const AddNewJournal({super.key, this.title, this.description});

  @override
  State<AddNewJournal> createState() => _AddNewJournalState();
}

class _AddNewJournalState extends State<AddNewJournal> {
  final discriptionController = TextEditingController().obs;
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
  void initState() {
    // TODO: implement initState
    super.initState();
    discriptionController.value.text = widget.description ?? '';
  }

  @override
  Widget build(BuildContext context) {
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
        title: '',
        // isAdd: true,
        onTap: () => context.pop(),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 3.h, vertical: 2.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 2),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: AppColors.blue500,
                        width: 1,
                      ),
                    ),
                  ),
                  child: RiseText(
                    widget.title ?? "Add Title",
                    style: theme.bodyMedium!.copyWith(
                      color: AppColors.blue500,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(width: 2.w),
                SvgPicture.asset(
                  'assets/svg/edit.svg',
                  color: AppColors.blue500,
                  width: 6.w,
                  height: 6.w,
                )
              ],
            ),
            SizedBox(height: 2.h),
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
            RiseTextField(
              maxLines: 8,
              keyboardType: TextInputType.multiline,
              controller: discriptionController.value,
              
              hintText:
                  'How is your day going? How has it affected your mood? or anything else...',
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
