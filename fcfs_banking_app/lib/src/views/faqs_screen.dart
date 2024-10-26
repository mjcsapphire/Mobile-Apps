import 'package:fcfs_banking_app/core/theme/colors.dart';
import 'package:fcfs_banking_app/core/utils/constant/app_assets_constant.dart';
import 'package:fcfs_banking_app/src/models/faq_model.dart';
import 'package:fcfs_banking_app/src/views/widget/custom_app_bar.dart';
import 'package:fcfs_banking_app/src/views/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  int? _expandedIndex;

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
        body: Stack(children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppAssetsConstant.upperBackground),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            // padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: AppColors.black,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 2.h),
                  Container(
                    decoration: BoxDecoration(
                      // border: Border.all(color: Colors.white, width: 1.0),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Text(
                      'We\'re here to help you with anything you need. Check out our FAQs below or contact us for more information.',
                      textAlign: TextAlign.justify,
                      softWrap: true,
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium
                          ?.copyWith(
                              fontWeight: FontWeight.w400, fontSize: 17.sp),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Expanded(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                        itemCount: faqs.length,
                        itemBuilder: (context, index) {
                          return _buildFAQItem(context, faqs[index], index);
                        },
                      ),
                    ),
                  ),
                  // const Spacer(),
                  Text(
                    "Still confused? Leave us a message and we'll get back to you.",
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.w400, fontSize: 14.sp),
                  ),
                  SizedBox(height: 1.h),
                  CustomButtonWidget(
                      onTap: () {},
                      width: MediaQuery.of(context).size.width * 0.9,
                      text: "Send a message",
                      fontSize: 17.sp,
                      textColor: AppColors.pinkColor,
                      isIconAvailable: false)
                ],
              ),
            ),
          )
        ]));
  }

  Widget _buildFAQItem(BuildContext context, FAQ faq, int index) {
    final isOpen = _expandedIndex == index;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      color: AppColors.pinkColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: GestureDetector(
        onTap: () {
          setState(() {
            // Update the expanded index
            _expandedIndex = isOpen ? null : index;
          });
        },
        child: Container(
          height: isOpen ? 150 : 60.0,
          decoration: BoxDecoration(
            color: AppColors.pinkColor,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              dividerColor: Colors.transparent,
            ),
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    faq.question,
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.w400, fontSize: 16.sp),
                  ),
                  trailing: Icon(
                    isOpen ? Icons.expand_less : Icons.expand_more,
                    color: Colors.white,
                  ),
                ),
                if (isOpen)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 10.0),
                    child: Text(faq.answer,
                        style: Theme.of(context).textTheme.displaySmall),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
