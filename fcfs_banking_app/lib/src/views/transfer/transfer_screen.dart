import 'package:fcfs_banking_app/core/theme/colors.dart';
import 'package:fcfs_banking_app/core/utils/constant/app_assets_constant.dart';
import 'package:fcfs_banking_app/src/views/widget/custom_app_bar.dart';
import 'package:fcfs_banking_app/src/views/widget/custom_button.dart';
import 'package:fcfs_banking_app/src/views/widget/dummy/people.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Transfer",
        showMoreVertIcon: true,
        showNotificationIcon: false,
        showProfilePic: false,
        onMoreVertTap: () {},
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppAssetsConstant.upperBackground),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: AppColors.black,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 5.h),
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: MediaQuery.of(context).size.height * 0.16,
                    decoration: BoxDecoration(
                      color: AppColors.transparent,
                      borderRadius: BorderRadius.circular(10),
                      border:
                          Border.all(color: AppColors.textGreyColor, width: 1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Current Balance",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(color: AppColors.textGreyColor)),
                        const Spacer(),
                        Center(
                            child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                  text: '\$234',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge
                                      ?.copyWith(
                                          color: AppColors.pinkColor,
                                          fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: '.56',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium
                                      ?.copyWith(
                                          color: AppColors.textGreyColor,
                                          fontWeight: FontWeight.bold)),
                            ],
                          ),
                        )),
                        const Spacer(),
                        Text("**** **** **** 9765",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(color: AppColors.textGreyColor))
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomButtonWidget(
                      onTap: () {},
                      width: MediaQuery.of(context).size.width * 0.3,
                      text: "Send",
                      isIconAvailable: false,
                    ),
                    CustomButtonWidget(
                      onTap: () {},
                      width: MediaQuery.of(context).size.width * 0.3,
                      text: "Receive",
                      isIconAvailable: false,
                    )
                  ],
                ),
                SizedBox(height: 2.h),
                Text("Quick Transfer",
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium
                        ?.copyWith(fontFamily: "RobotoMono")),
                SizedBox(height: 1.h),
                Expanded(
                  child: ListView.builder(
                    itemCount: people.length,
                    itemBuilder: (context, index) {
                      final person = people[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: AppColors.textGreyColor, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          tileColor: AppColors.textGreyColor,
                          leading: CircleAvatar(
                            maxRadius: 20,
                            backgroundImage: AssetImage(
                              person['image']!,
                            ),
                          ),
                          title: Text(
                            person['name']!,
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall
                                ?.copyWith(
                                  fontSize: 14.sp,
                                ),
                          ),
                          onTap: () {
                            // Handle person tap
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
