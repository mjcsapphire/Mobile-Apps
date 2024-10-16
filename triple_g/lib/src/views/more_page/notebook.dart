import 'dart:math';

import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:triple_g/src/views/widgets/white_box.dart';

import '../../../core/helpers/helpers.dart';
import '../../../core/utils/colors.dart';
import '../../controllers/home_controller.dart';

class NoteBook extends StatefulWidget {
  const NoteBook({super.key});

  @override
  State<NoteBook> createState() => _NoteBookState();
}

class _NoteBookState extends State<NoteBook> {
  HomeController homeController = Get.find();
  @override
  void initState() {
    super.initState();
  }

  final selectedIndex = 0.obs;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(10.h),
        child: Container(
          height: 20.h,
          margin: EdgeInsets.only(top: 5.h, left: 8.w, right: 8.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.primaryColor,
                ),
              ),
              GText(
                'Notebook',
                style: textTheme.titleLarge!.copyWith(
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 5.h)
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GText(
              "Sermon session",
              margin: 24,
              style: textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 1.h),
            SizedBox(
              height: 16.h,
              child: ListView.builder(
                itemCount: 10,
                padding: const EdgeInsets.only(left: 24),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        right: 16,
                        top: 2,
                        bottom: 12,
                      ),
                      child: Image.asset(
                        'assets/png/notebook_folder.png',
                        color: Color.fromRGBO(
                          Random().nextInt(256) + 200,
                          Random().nextInt(256) + 200,
                          Random().nextInt(256) + 200,
                          0.5,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              radius: 26,
                              backgroundImage: NetworkImage(
                                  "https://picsum.photos/2${index}00/1000"),
                            ),
                            SizedBox(width: 5.w),
                            Padding(
                              padding: EdgeInsets.only(top: 3.h),
                              child: GText(
                                "11 new",
                                style: textTheme.labelLarge!.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ),
                            SizedBox(width: 6.w),
                          ],
                        ),
                        SizedBox(height: 0.5.h),
                        SizedBox(
                          width: 16.h,
                          child: GText(
                            "Some other church group... ",
                            style: textTheme.labelLarge!.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 13.sp,
                            ),
                          ),
                        ),
                        SizedBox(height: 1.h),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 1.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: StaggeredGrid.count(
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                crossAxisCount: 2,
                children: [
                  ...List.generate(
                    contentDescriptions.length,
                    (index) {
                      final bgColor = Color.fromRGBO(
                        Random().nextInt(256) + 200,
                        Random().nextInt(256) + 200,
                        Random().nextInt(256) + 200,
                        0.05,
                      );
                      return Obx(() => GestureDetector(
                            onTap: () {
                              selectedIndex.value = index;
                            },
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                Blur(
                                  blur: selectedIndex.value != index ? -1 : 2,
                                  colorOpacity: 0,
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                      minHeight: 15.h,
                                    ),
                                    child: WhiteBox(
                                      bgColor: bgColor,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          GText(
                                            "Donations",
                                            style:
                                                textTheme.bodySmall!.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          GText(
                                            contentDescriptions[index],
                                            style:
                                                textTheme.labelLarge!.copyWith(
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                if (index == selectedIndex.value)
                                  WhiteBox(
                                    width: 100.w,
                                    margin: const EdgeInsets.all(8),
                                    child: Column(
                                      children: [
                                        _buildIconRow(
                                          textTheme,
                                          "Change Color",
                                          "paint",
                                        ),
                                        SizedBox(height: 2.w),
                                        _buildIconRow(
                                          textTheme,
                                          "Pin",
                                          "location",
                                        ),
                                        SizedBox(height: 2.w),
                                        _buildIconRow(
                                          textTheme,
                                          "Remove",
                                          "bin",
                                        ),
                                      ],
                                    ),
                                  )
                              ],
                            ),
                          ));
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 2.h),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.black,
        onPressed: () {},
        child: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.add,
            color: AppColors.primaryColor,
          ),
        ),
      ),
    );
  }

  _buildIconRow(TextTheme textTheme, String title, String icon) {
    return Row(
      children: [
        Image.asset(
          'assets/png/$icon.png',
          scale: 6,
        ),
        SizedBox(width: 2.w),
        GText(
          title,
          style: textTheme.labelLarge,
        ),
      ],
    );
  }
}
