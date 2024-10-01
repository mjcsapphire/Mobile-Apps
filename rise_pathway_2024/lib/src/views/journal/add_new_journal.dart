import 'package:flutter/material.dart';
import 'package:rise_pathway/core/constants/package_export.dart';
import 'package:rise_pathway/core/helpers/helpers.dart';
import 'package:rise_pathway/core/utils/colors.dart';
import 'package:rise_pathway/src/controllers/journal_controller.dart';
import 'package:rise_pathway/src/views/widget/app_bar.dart';
import 'package:rise_pathway/src/views/widget/text_form_field.dart';

class AddNewJournal extends StatefulWidget {
  final String? title;
  final String? description;
  final bool isEdit;
  const AddNewJournal({
    super.key,
    this.title,
    this.description,
    this.isEdit = false,
  });

  @override
  State<AddNewJournal> createState() => _AddNewJournalState();
}

class _AddNewJournalState extends State<AddNewJournal> {
  final discriptionController = TextEditingController().obs;
  final selectedIndex = 0.obs;
  final JournalController journalController = Get.find();
  final formKey = GlobalKey<FormState>();

  final selectedIndexs = <int>[].obs;

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
        onTap: () => context.pop(),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 3.h, vertical: 2.h),
        child: Form(
            key: formKey,
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
                Obx(() => Wrap(
                      children: List.generate(
                        8,
                        (index) => GestureDetector(
                          onTap: () {
                            if (selectedIndexs.contains(index)) {
                              selectedIndexs.remove(index);
                            } else {
                              selectedIndexs.add(index);
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            padding: EdgeInsets.symmetric(
                              horizontal: 2.h,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: selectedIndexs.contains(index)
                                  ? AppColors.blue
                                  : AppColors.white,
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                width: 2,
                                color: selectedIndexs.contains(index)
                                    ? AppColors.blackBlue
                                    : AppColors.skyBlue,
                              ),
                            ),
                            child: RiseText(
                              _emotions[index],
                              style: theme.labelSmall!.copyWith(
                                fontWeight: FontWeight.w500,
                                color: selectedIndexs.contains(index)
                                    ? AppColors.white
                                    : AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )),
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
                  validator: (p0) {
                    if (p0 != null && p0.isEmpty) {
                      return "Description can't be empty";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 2.h),
                GestureDetector(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      if (widget.isEdit) {
                        journalController.updateJournal(
                          email: "aakash@gmail.com",
                          id: "",
                          title: discriptionController.value.text,
                          content: selectedIndex.value.toString(),
                        );
                      } else {
                        journalController.addJournal(
                          email: "aakash@gmail.com",
                          title: discriptionController.value.text,
                          content: selectedIndex.value.toString(),
                        );
                      }
                      context.pop();
                    }
                  },
                  child: Container(
                    height: 6.h,
                    width: 100.w,
                    margin: EdgeInsets.only(bottom: 5.h),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: AppColorsGredients.primaryLeftToRight,
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
                ),
              ],
            )),
      ),
    );
  }
}
