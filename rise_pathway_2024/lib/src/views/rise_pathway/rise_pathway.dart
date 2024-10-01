import 'package:flutter/material.dart';
import 'package:rise_pathway/core/constants/package_export.dart';
import 'package:rise_pathway/src/controllers/home_controller.dart';
import 'package:rise_pathway/src/views/widget/app_bar.dart';
import 'package:rise_pathway/src/views/widget/rise_pathway_card.dart';

class RisePathWay extends StatefulWidget {
  const RisePathWay({super.key});

  @override
  State<RisePathWay> createState() => _RisePathWayState();
}

class _RisePathWayState extends State<RisePathWay> {
  final homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: RiseAppBar.riseAppBar(
        theme: theme,
        title: 'Rise Pathway',
        onTap: () => context.pop(),
      ),
      body: const SafeArea(
        child: RisePathwayCard(),
      ),
    );
  }
}
