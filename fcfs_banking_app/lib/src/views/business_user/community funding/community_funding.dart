import 'package:cached_network_image/cached_network_image.dart';
import 'package:fcfs_banking_app/core/theme/colors.dart';
import 'package:fcfs_banking_app/core/theme/radialBg.dart';
import 'package:fcfs_banking_app/core/utils/app_helpers.dart';
import 'package:fcfs_banking_app/core/utils/constant/app_assets_constant.dart';
import 'package:fcfs_banking_app/services/router/routes_name.dart';
import 'package:fcfs_banking_app/src/controllers/idea_submission_controller.dart';
import 'package:fcfs_banking_app/src/controllers/theme_controller.dart';
import 'package:fcfs_banking_app/src/controllers/user_controller.dart';
import 'package:fcfs_banking_app/src/views/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

class CommunityFundingScreen extends StatefulWidget {
  const CommunityFundingScreen({super.key});

  @override
  State<CommunityFundingScreen> createState() => _CommunityFundingScreenState();
}

class _CommunityFundingScreenState extends State<CommunityFundingScreen> {
  final IdeaSubmissionController _controller =
      Get.put(IdeaSubmissionController());
  final UserController userController = Get.find<UserController>();
  ThemeController themeController = Get.find<ThemeController>();
  bool isOverViewSelected = true;
  final Map<int, bool> toggleStates = {};

  @override
  void initState() {
    super.initState();
    _controller.fetchIdeas();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final user = userController.user.value;
    return Scaffold(
      body: Stack(
        children: [
          CustomPaint(
            size: Size(
              MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height,
            ),
            painter: themeController.themeMode == ThemeMode.dark
                ? DarkGradientBackgroundPainter()
                : GradientBackgroundPainter(),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 4.w),
              child: Obx(() {
                final ideas = _controller.ideas;
                if (ideas.isEmpty) {
                  return Center(
                    child: Text(
                      'No community funds available yet.',
                      style: theme.textTheme.displayMedium,
                    ),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: ListView.builder(
                    itemCount: ideas.length,
                    itemBuilder: (context, index) {
                      final idea = ideas[index];
                      toggleStates.putIfAbsent(index, () => true);
                      return Padding(
                        padding: EdgeInsets.only(bottom: 0.2.h),
                        child: buildFundCard(
                          index: index,
                          fundName: idea.headline,
                          amountSaved: idea.targetAmount,
                          goalAmount: idea.targetAmount,
                          progressPercentage:
                              (idea.raisedAmount / idea.targetAmount) * 100,
                          goalDate: AppHelpers.formatDate(idea.targetdDate),
                          withdrawOnTap: () {
                            AppHelpers.toast("Upcoming feature");
                          },
                          setNewRuleOnTap: () {
                            context.pushNamed(RoutesName.ideaSubmission,
                                extra: idea);
                          },
                          editRuleOnTap: () {
                            context.pushNamed(RoutesName.ideaSubmission,
                                extra: idea);
                          },
                          thumbnailUrl: idea.thumbnailUrl,
                          raisedMoney: idea.raisedAmount.toString(),
                          postedOn: AppHelpers.formatDate(idea.createdAt),
                          businessOwner: idea.businessOwner,
                          maxInvestmentAmount: idea.maximumInvestment,
                          minInvestmentAmount: idea.minimumInvestment,
                          numberOfCurrentInvestors: idea.totalInvestors,
                          investNowTap: () {
                            context.pushNamed(RoutesName.pitchDetails,
                                extra: idea);
                          },
                        ),
                      );
                    },
                  ),
                );
              }),
            ),
          ),
          userController.user.value!.role == "Business"
              ? Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 2.h),
                    child: CustomButtonWidget(
                      onTap: () {
                        context.pushNamed(RoutesName.ideaSubmission);
                      },
                      width: 90.w,
                      text: "Start new community fund",
                      color: themeController.themeMode == ThemeMode.dark
                          ? AppColors.darkBorderColor
                          : AppColors.red,
                      borderColor: themeController.themeMode == ThemeMode.dark
                          ? AppColors.darkBorderColor
                          : AppColors.red,
                      fontSize: 5.w,
                      isIconAvailable: false,
                    ),
                  ),
                )
              : const SizedBox.shrink(),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height * 0.12,
              ),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                gradient: themeController.themeMode == ThemeMode.dark
                    ? AppColors.darkStackContainerBackground
                    : AppColors.stackContainerBackground,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Obx(
                  () {
                    final user = userController.user.value;
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              height: MediaQuery.of(context).padding.top + 10),
                          // Header Icons
                          Row(
                            children: [
                              // Left section with user profile image
                              GestureDetector(
                                onTap: () {
                                  context.pushNamed(RoutesName.profileScreen);
                                },
                                child: CircleAvatar(
                                  radius: 5.w,
                                  backgroundColor: Colors.white24,
                                  backgroundImage: user?.profileImageUrl != null
                                      ? CachedNetworkImageProvider(
                                          user!.profileImageUrl!)
                                      : const AssetImage(
                                          AppAssetsConstant.profile2),
                                ),
                              ),
                              const Spacer(),
SizedBox(width: 17.w),
                              GestureDetector(
                                onTap: () {
                                  context.pushNamed(RoutesName.scanScreen);
                                },
                                child: Icon(Icons.qr_code,
                                    color: Colors.white, size: 8.w),
                              ),
                              const Spacer(),

                              Container(
                                width: 30.w,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        context.pop();
                                      },
                                      child: Text(
                                        "Exit",
                                        style: theme.textTheme.displayMedium,
                                      ),
                                    ),
                                    IconButton(
                                      icon: Image.asset(
                                        AppAssetsConstant.notification,
                                        width: 6.w,
                                      ),
                                      onPressed: () {
                                        context.pushNamed(
                                            RoutesName.notificationScreen);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFundCard(
      {required String fundName,
      required double amountSaved,
      required double goalAmount,
      required double progressPercentage,
      required String goalDate,
      required VoidCallback withdrawOnTap,
      required VoidCallback setNewRuleOnTap,
      required VoidCallback editRuleOnTap,
      required String thumbnailUrl,
      required String raisedMoney,
      required String postedOn,
      required String businessOwner,
      required double maxInvestmentAmount,
      required double minInvestmentAmount,
      required int numberOfCurrentInvestors,
      required VoidCallback investNowTap,
      required int index}) {
    final theme = Theme.of(context);
    return Container(
      width: MediaQuery.of(context).size.width - 20,
      margin: const EdgeInsets.only(bottom: 2),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Toggle container
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: themeController.themeMode == ThemeMode.dark
                  ? AppColors.darkAppBarGradient
                  : AppColors.stackContainerBackground,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Column(
              children: [
                Text(fundName, style: theme.textTheme.displayMedium),
                const SizedBox(height: 8),
                Text("\$${amountSaved.toStringAsFixed(0)}",
                    style: theme.textTheme.displayMedium),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width - 20,
            padding:
                const EdgeInsets.only(top: 30, bottom: 16, left: 8, right: 8),
            decoration: BoxDecoration(
              color: themeController.themeMode == ThemeMode.dark
                  ? AppColors.darkBorderColor
                  : AppColors.red,
              border: const Border(
                left: BorderSide(color: Colors.white, width: 0.3),
                right: BorderSide(color: Colors.white, width: 0.3),
              ),
            ),
            child: _buildToggleButtons(
              index,
              toggleStates[index] ?? true,
            ),
          ),
          // Fund name container

          toggleStates[index] ?? true
              ? buildOverview(
                  thumbnailUrl: thumbnailUrl,
                  raisedMoney: raisedMoney,
                  postedOn: postedOn,
                )
              : buildDetails(
                  progressPercentage: progressPercentage,
                  goalDate: goalDate,
                  goalAmount2: goalAmount,
                  withdrawTap: withdrawOnTap,
                  setNewRuleTap: setNewRuleOnTap,
                  editRuleTap: editRuleOnTap,
                  businessOwner: businessOwner,
                  maxInvestmentAmount: maxInvestmentAmount,
                  minInvestmentAmount: minInvestmentAmount,
                  numberOfCurrentInvestors: numberOfCurrentInvestors,
                  investNowTap: investNowTap,
                ),
        ],
      ),
    );
  }

  Widget buildOverview(
      {required String thumbnailUrl,
      required String raisedMoney,
      required String postedOn}) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          border: Border(
        bottom: BorderSide(color: Colors.white, width: 0.5),
        left: BorderSide(color: Colors.white, width: 0.5),
        right: BorderSide(color: Colors.white, width: 0.5),
      )),
      height: MediaQuery.of(context).size.height * 0.32,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image(
            image: CachedNetworkImageProvider(thumbnailUrl),
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height - 80.h,
            width: MediaQuery.of(context).size.width,
          ),
          SizedBox(height: 1.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Earned ",
                      style: Theme.of(context).textTheme.displaySmall),
                  Text("\$$raisedMoney ",
                      style: Theme.of(context).textTheme.displayMedium),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("posted on",
                      style: Theme.of(context).textTheme.displaySmall),
                  Text(postedOn,
                      style: Theme.of(context).textTheme.displayMedium),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildDetails({
    required double progressPercentage,
    required String goalDate,
    required double goalAmount2,
    required VoidCallback withdrawTap,
    required VoidCallback setNewRuleTap,
    required VoidCallback editRuleTap,
    required String businessOwner,
    required double maxInvestmentAmount,
    required double minInvestmentAmount,
    required int numberOfCurrentInvestors,
    required VoidCallback investNowTap,
  }) {
    return userController.user.value!.role == "Business"
        ? Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.white, width: 0.5),
                left: BorderSide(color: Colors.white, width: 0.5),
                right: BorderSide(color: Colors.white, width: 0.5),
              ),
            ),
            height: MediaQuery.of(context).size.height * 0.32,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${progressPercentage.toStringAsFixed(0)}% saved",
                        style: Theme.of(context).textTheme.displaySmall),
                    Text("of ${goalAmount2.toStringAsFixed(2)}",
                        style: Theme.of(context).textTheme.displaySmall),
                  ],
                ),
                const SizedBox(height: 6),
                LinearProgressIndicator(
                  value: progressPercentage / 100,
                  backgroundColor: Colors.white30,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                  minHeight: 5,
                ),
                SizedBox(height: 1.h),
                Text("On track to reach goal of $goalDate",
                    style: Theme.of(context).textTheme.displaySmall),
                SizedBox(height: 2.h),
                Center(
                  child: Column(
                    children: [
                      TextButton(
                          onPressed: withdrawTap,
                          child: Text("Withdraw",
                              style: Theme.of(context).textTheme.displayLarge)),
                      TextButton(
                          onPressed: setNewRuleTap,
                          child: Text("Set new saving rule",
                              style: Theme.of(context).textTheme.displayLarge)),
                      TextButton(
                          onPressed: editRuleTap,
                          child: Text("Edit saving rule",
                              style: Theme.of(context).textTheme.displayLarge)),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ))
        : Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.white, width: 0.5),
                left: BorderSide(color: Colors.white, width: 0.5),
                right: BorderSide(color: Colors.white, width: 0.5),
              ),
            ),
            height: MediaQuery.of(context).size.height * 0.3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Business owner : $businessOwner",
                    style: Theme.of(context).textTheme.displayMedium),
                Text("Max investment amount : \$$maxInvestmentAmount",
                    style: Theme.of(context).textTheme.displayMedium),
                Text("Min investment amount : \$$minInvestmentAmount",
                    style: Theme.of(context).textTheme.displayMedium),
                Text("Number of current investors: $numberOfCurrentInvestors",
                    style: Theme.of(context).textTheme.displayMedium),
                const SizedBox(height: 16),
                Center(
                  child: CustomButtonWidget(
                    onTap: investNowTap,
                    width: 80.w,
                    text: "Learn More",
                    color: themeController.themeMode == ThemeMode.dark
                        ? AppColors.darkBorderColor
                        : AppColors.red,
                    borderColor: themeController.themeMode == ThemeMode.dark
                        ? AppColors.darkBorderColor
                        : AppColors.red,
                    fontSize: 5.w,
                    isIconAvailable: false,
                  ),
                )
              ],
            ),
          );
  }

  Widget _buildToggleButtons(int index, bool isOverViewSelected) {
    return Container(
      height: 40,
      width: MediaQuery.of(context).size.width * 0.4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white.withOpacity(0.2),
      ),
      child: Row(
        children: [
          _toggleButton('Overview', isOverViewSelected, () {
            setState(() {
              toggleStates[index] = true;
            });
          }),
          _toggleButton('Details', !isOverViewSelected, () {
            setState(() {
              toggleStates[index] = false;
            });
          }),
        ],
      ),
    );
  }

  Widget _toggleButton(String text, bool isSelected, VoidCallback onPressed) {
    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          width: 30.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            text,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: isSelected ? Colors.black : Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
    );
  }
}
