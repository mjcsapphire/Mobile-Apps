import 'package:fcfs_banking_app/core/theme/colors.dart';
import 'package:fcfs_banking_app/src/controllers/referral_controller.dart';
import 'package:fcfs_banking_app/src/controllers/theme_controller.dart';
import 'package:fcfs_banking_app/src/controllers/user_controller.dart';
import 'package:fcfs_banking_app/src/views/home/home_screen.dart';
import 'package:fcfs_banking_app/src/views/more/more_screen.dart';
import 'package:fcfs_banking_app/src/views/transaction/transaction_screen.dart';
import 'package:fcfs_banking_app/src/views/transfer/transfer_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainPage extends StatefulWidget {
  final int initialIndex;
  const MainPage({super.key, required this.initialIndex});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  UserController userController = Get.find<UserController>();
  ReferralController referralController = Get.find<ReferralController>();
  ThemeController themeController = Get.find<ThemeController>();

  late int currentIndex;
  List<Widget> pages = [
    const HomeScreen(),
    const TransactionScreen(),
    // const HomeScreen(),
    const TransferScreen(),
    const MoreScreen(),
  ];

  @override
  void initState() {
    FirebaseMessaging.instance.getToken().then((token) {
      print("fcmToken from mainpage: $token");
      userController.updateFcmToken(token!);
    });
    currentIndex = widget.initialIndex;
    super.initState();
  }

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkMauve,
      body: pages[currentIndex],
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(50.0),
              topRight: Radius.circular(50.0),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: themeController.themeMode == ThemeMode.dark
                    ? AppColors.darkStackContainerColor1
                    : AppColors.darkMauve,
              ),
              height: 6,
              child: Row(
                children: List.generate(pages.length, (index) {
                  Color color = currentIndex == index
                      ? AppColors.white
                      : AppColors.darkTransferBgColor2;
                  return Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.rectangle,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          )),
                      height: 6,
                    ),
                  );
                }),
              ),
            ),
          ),
          BottomNavigationBar(
            iconSize: 32,
            selectedFontSize: 14,
            unselectedFontSize: 14,
            type: BottomNavigationBarType.fixed,
            backgroundColor: themeController.themeMode == ThemeMode.dark
                ? AppColors.darkStackContainerColor1
                : AppColors.bgColor4,
            onTap: onTap,
            currentIndex: currentIndex,
            selectedItemColor: themeController.themeMode == ThemeMode.dark
                ? AppColors.white
                : AppColors.peachOrange,
            unselectedItemColor: themeController.themeMode == ThemeMode.dark
                ? AppColors.darkTransferBgColor2
                : AppColors.white,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedLabelStyle: TextStyle(
              color: AppColors.peachOrange,
              fontFamily: 'Montserrat',
            ),
            unselectedLabelStyle: const TextStyle(
                color: AppColors.white, fontFamily: 'Montserrat'),
            elevation: 0,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.receipt), label: "Transactions"),
              // BottomNavigationBarItem(icon: SizedBox.shrink(), label: ''),
              BottomNavigationBarItem(
                  icon: Icon(Icons.compare_arrows_sharp), label: "Transfer"),
              BottomNavigationBarItem(icon: Icon(Icons.menu), label: "More"),
            ],
          ),
        ],
      ),
    );
  }
}
