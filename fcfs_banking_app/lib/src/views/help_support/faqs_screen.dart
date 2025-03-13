import 'package:fcfs_banking_app/core/theme/colors.dart';
import 'package:fcfs_banking_app/core/theme/radialBg.dart';
import 'package:fcfs_banking_app/src/controllers/theme_controller.dart';
import 'package:fcfs_banking_app/src/models/faq_model.dart';
import 'package:fcfs_banking_app/src/views/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  int? _expandedIndex;
  final PageController _pageController = PageController();
  final int _pageCount = 5;
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "FAQs",
        showMoreVertIcon: false,
        showNotificationIcon: false,
        showProfilePic: false,
        onMoreVertTap: () {},
      ),
      body: Stack(
        children: [
          // Background Gradient
          CustomPaint(
            size: Size(
              MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height,
            ),
            painter: themeController.themeMode == ThemeMode.dark
                ? DarkGradientBackgroundPainter()
                : GradientBackgroundPainter(),
          ),

          // Content
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 3.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Frequently Asked Questions',
                  textAlign: TextAlign.justify,
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium
                      ?.copyWith(fontWeight: FontWeight.w400, fontSize: 17.sp),
                ),
              ),
              SizedBox(height: 3.h),
              // PageView with FAQ items
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: (faqs.length / _pageCount).ceil(),
                  itemBuilder: (context, pageIndex) {
                    int start = pageIndex * _pageCount;
                    int end = (pageIndex + 1) * _pageCount;
                    if (end > faqs.length) {
                      end = faqs.length;
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: end - start,
                      itemBuilder: (context, faqIndex) {
                        return _buildFAQItem(
                          context,
                          faqs[start + faqIndex],
                          start + faqIndex,
                        );
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 2.h),

              SmoothPageIndicator(
                controller: _pageController,
                count: (faqs.length / 5).ceil(),
                effect: WormEffect(
                  activeDotColor: themeController.themeMode == ThemeMode.dark
                      ? AppColors.darkBorderColor
                      : AppColors.red,
                  dotColor: themeController.themeMode == ThemeMode.dark
                      ? AppColors.darkTileColor
                      : AppColors.burgundy,
                  dotHeight: 8,
                  dotWidth: 8,
                  spacing: 8,
                ),
              ),
              SizedBox(height: 2.h),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFAQItem(BuildContext context, FAQ faq, int index) {
    final isOpen = _expandedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _expandedIndex = isOpen ? null : index;
        });
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.w),
        ),
        color: isOpen ? AppColors.white : AppColors.white.withOpacity(0.9),
        elevation: isOpen ? 6 : 2,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.w),
            border: isOpen
                ? Border.all(
                    color: themeController.themeMode == ThemeMode.dark
                        ? AppColors.darkBorderColor
                        : AppColors.red,
                    width: 3.0)
                : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                title: Text(
                  faq.question,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                        color: AppColors.burgundy,
                      ),
                ),
              ),
              if (isOpen)
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 4.0),
                  child: Text(
                    faq.answer,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          fontSize: 16.sp,
                          color: AppColors.burgundy,
                        ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
