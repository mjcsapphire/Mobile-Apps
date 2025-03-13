import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fcfs_banking_app/core/theme/colors.dart';
import 'package:fcfs_banking_app/core/utils/constant/app_assets_constant.dart';
import 'package:fcfs_banking_app/services/router/routes_name.dart';
import 'package:fcfs_banking_app/src/controllers/theme_controller.dart';
import 'package:fcfs_banking_app/src/controllers/user_controller.dart';
import 'package:fcfs_banking_app/src/views/widget/cards/amex_card_widget.dart';
import 'package:fcfs_banking_app/src/views/widget/cards/flips.dart';
import 'package:fcfs_banking_app/src/views/widget/cards/master_card_widget.dart';
import 'package:fcfs_banking_app/src/views/widget/cards/visa_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

class CreditCardScreen extends StatefulWidget {
  const CreditCardScreen({super.key});

  @override
  State<CreditCardScreen> createState() => _CreditCardScreenState();
}

class _CreditCardScreenState extends State<CreditCardScreen> {
  final userController = Get.find<UserController>();
  ThemeController themeController = Get.find<ThemeController>();
  int _currentIndex = 0;

  @override
  void initState() {
    _currentIndex = 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final user = userController.user.value;
    String? profilePicUrl = user!.profileImageUrl;

    // Data for cards
    final cards = [
      {
        'front': VisaCardWidget(
          cardHolderName: "${user.firstName} ${user.lastName}",
          cardNumber: "**** **** **** 1234",
          expiryDate: "12/25",
          bankName: "Visa Bank",
        ),
        'back': const VisaCardBackWidget(
          cvv: "1234",
          terms:
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
          condition: "Terms & conditions applied. | FANTASY BANK",
        ),
      },
      {
        'front': MasterCardWidget(
          cardHolderName: "${user.firstName} ${user.lastName}",
          cardNumber: "**** **** **** 42367",
          expiryDate: "06/24",
          bankName: "Master Bank",
        ),
        'back': const MasterCardBackWidget(
          cvv: "4567",
          terms:
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
          condition: "Terms & conditions applied. | FANTASY BANK",
        ),
      },
      {
        'front': AmexCardWidget(
          cardHolderName: "${user.firstName} ${user.lastName}",
          cardNumber: "**** **** **** 7890",
          expiryDate: "09/27",
          bankName: "Amex Bank",
        ),
        'back': const AmexCardBackWidget(
          cvv: "7890",
          terms:
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
          condition: "Terms & conditions applied. | FANTASY BANK",
        ),
      },
    ];

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 7.5.h,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: themeController.themeMode == ThemeMode.dark
                ? const LinearGradient(
                    colors: [
                      AppColors.darkBgColor1,
                      AppColors.darkBgColor2,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : LinearGradient(
                    colors: [
                      AppColors.bgColor1.withOpacity(0.92),
                      AppColors.bgColor1,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
          ),
        ),
        leadingWidth: 24.w,
        leading: IconButton(
          icon: CircleAvatar(
            backgroundColor: AppColors.white,
            backgroundImage: profilePicUrl != null
                ? CachedNetworkImageProvider(profilePicUrl)
                : const AssetImage(AppAssetsConstant.profile2) as ImageProvider,
            child: profilePicUrl == null
                ? Image.asset(
                    AppAssetsConstant.profile2,
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          onPressed: () {
            context.pushNamed(RoutesName.profileScreen);
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.pushNamed(RoutesName.notificationScreen);
            },
            icon: const Image(
              image: AssetImage(AppAssetsConstant.notification),
              height: 30,
              width: 30,
              color: AppColors.white,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
          SizedBox(width: 5.w)
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: themeController.themeMode == ThemeMode.dark
              ? AppColors.darkBackground
              : AppColors.background,
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.68,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                gradient: themeController.themeMode == ThemeMode.dark
                    ? AppColors.darkStackContainerBackground
                    : LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.bgColor1,
                          const Color(0xFFD94A52),
                          const Color(0xFFFBB871),
                        ],
                        stops: const [0.0, 0.5, 1.0],
                      ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 6.h),
                  Text(
                    user.role == "Business"
                        ? user.businessName
                        : "${user.firstName} ${user.lastName}",
                    style: theme.textTheme.displayMedium?.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    user.phoneNumber,
                    style: theme.textTheme.displayMedium?.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.25,
                    child: CarouselSlider.builder(
                      itemCount: cards.length,
                      options: CarouselOptions(
                        height: MediaQuery.of(context).size.height * 0.3,
                        viewportFraction: 0.8,
                        enlargeCenterPage: true,
                        enlargeStrategy: CenterPageEnlargeStrategy.scale,
                        enableInfiniteScroll: false,
                        initialPage: 1,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                      ),
                      itemBuilder: (context, index, realIndex) {
                        final bool isCurrent = _currentIndex == index;
                        final card = cards[index];
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          height: isCurrent
                              ? MediaQuery.of(context).size.height * 0.25
                              : MediaQuery.of(context).size.height * 0.3,
                          width: isCurrent
                              ? MediaQuery.of(context).size.height * 0.8
                              : MediaQuery.of(context).size.height * 0.6,
                          child: FlippableCardWidget(
                            front: card['front'] as Widget,
                            back: card['back'] as Widget,
                          ),
                        );
                      },
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            context.pop();
                          },
                          child: Text(
                            "Close",
                            style: theme.textTheme.displayMedium,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            context.pushNamed(RoutesName.scanScreen);
                          },
                          child: Image(
                            image: const AssetImage(AppAssetsConstant.qr),
                            height: 10.h,
                            width: 8.w,
                            color: themeController.themeMode == ThemeMode.dark
                                ? AppColors.white
                                : AppColors.burgundy,
                          ),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.15)
                      ],
                    ),
                  )
                ],
              ),
            ),
            const Spacer(),
            Text("Can't see the card details?",
                style: theme.textTheme.displaySmall?.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                )),
            TextButton(
              onPressed: () {
                context.pushNamed(RoutesName.helpSupportScreen);
              },
              child: Text("Click for help",
                  style: theme.textTheme.displaySmall
                      ?.copyWith(color: AppColors.red, fontSize: 16.sp)),
            ),
            SizedBox(height: 6.h)
          ],
        ),
      ),
    );
  }
}
