import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triple_g/src/controllers/home_controller.dart';
import 'package:triple_g/src/views/home/home_screen.dart';

import 'views/chat/chat_screen.dart';
import 'views/church/church_screen.dart';
import 'views/more_page/more_page.dart';
import 'views/sermons/semrons.dart';
import 'views/widgets/bottom_nav_bar.dart';

class TripleG extends StatefulWidget {
  const TripleG({super.key});

  @override
  State<TripleG> createState() => _TripleGState();
}

class _TripleGState extends State<TripleG> {
  final HomeController homeController = Get.find();
  final pages = [
    const HomeScreen(),
    const ChurchScreen(),
    const ChatScreen(),
    const Sermons(),
    const MorePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: pages[homeController.selectedIndex.value],
          bottomNavigationBar: TripleGNavBar.tripleGNavBar(homeController),
        ));
  }
}
