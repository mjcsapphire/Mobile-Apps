import 'package:fcfs_banking_app/core/theme/colors.dart';
import 'package:fcfs_banking_app/src/views/home/home_screen.dart';
import 'package:fcfs_banking_app/src/views/more/more_screen.dart';
import 'package:fcfs_banking_app/src/views/transaction/transaction_screen.dart';
import 'package:fcfs_banking_app/src/views/transfer/transfer_screen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MainPage extends StatefulWidget {
  final int initialIndex;
  const MainPage({super.key, required this.initialIndex});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late int currentIndex;
  List<Widget> pages = [
    const HomeScreen(),
    const TransactionScreen(),
    const HomeScreen(),
    const TransferScreen(),
    const MoreScreen(),
  ];

  @override
  void initState() {
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
      backgroundColor: AppColors.black,
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
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
              height: 6,
              child: Row(
                children: List.generate(pages.length, (index) {
                  Color color = currentIndex == index
                      ? AppColors.pinkColor
                      : AppColors.white;
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
            backgroundColor: Colors.black,
            onTap: onTap,
            currentIndex: currentIndex,
            selectedItemColor: AppColors.pinkColor,
            unselectedItemColor: AppColors.white,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedLabelStyle: const TextStyle(
                color: AppColors.pinkColor, fontFamily: 'Roboto'),
            unselectedLabelStyle:
                const TextStyle(color: AppColors.white, fontFamily: 'Roboto'),
            elevation: 0,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.receipt), label: "Transactions"),
              BottomNavigationBarItem(icon: SizedBox.shrink(), label: ''),
              BottomNavigationBarItem(
                  icon: Icon(Icons.compare_arrows_sharp), label: "Transfer"),
              BottomNavigationBarItem(icon: Icon(Icons.menu), label: "More"),
            ],
          ),
        ],
      ),
      floatingActionButton: SizedBox(
        height: 9.h,
        width: 19.w,
        child: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
            side: const BorderSide(color: AppColors.white, width: 6),
          ),
          onPressed: () {},
          backgroundColor: AppColors.black,
          child: const Icon(
            Icons.qr_code,
            color: AppColors.white,
            size: 40,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
