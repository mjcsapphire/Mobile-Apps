import 'package:flutter/material.dart';
import 'package:rise_pathway/core/constants/package_export.dart';
import 'package:rise_pathway/core/helpers/helpers.dart';
import 'package:rise_pathway/core/routes/routes.dart';
import 'package:rise_pathway/core/utils/colors.dart';
import 'package:rise_pathway/src/controllers/rise_pathway_controller.dart';

class RisePathwayCard extends StatelessWidget {
  const RisePathwayCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final pathwayController = Get.find<RisePathwayController>();

    // Background assets to repeat
    final backgroundAssets = [
      'assets/container_assets/frame_1.png',
      'assets/container_assets/frame_2.png',
      'assets/container_assets/frame_3.png',
      'assets/container_assets/frame_4.png',
      'assets/container_assets/frame_5.png',
      'assets/container_assets/frame_6.png',
    ];

    return Obx(() {
      final pathways = pathwayController.pathways;

      if (pathways.isEmpty) {
        // Show a loader while pathways data is being fetched
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: pathways.length,
        itemBuilder: (context, index) {
          final pathway = pathways[index];
          final gradientColors = _getGradientFromHexColor(pathway.colour);

          // Calculate the background asset index (repeat every 6 cards)
          final backgroundIndex = index % backgroundAssets.length;
          final desc = Helpers.removeHtmlTags(pathway.description);

          return GestureDetector(
            onTap: () {
              context.go(riseQuizPage, extra: {
                'title': pathway.title,
                'description': pathway.description,
                'id': pathway.id,
              });
            },
            child: Container(
              width: 100.w,
              height: 100.h,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(26),
                gradient: LinearGradient(
                  end: Alignment.bottomLeft,
                  begin: Alignment.topRight,
                  colors: gradientColors,
                ),
                image: DecorationImage(
                  image: AssetImage(backgroundAssets[backgroundIndex]),
                  fit: BoxFit.cover,
                  opacity: 0.8,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RiseText(
                    pathway.title,
                    textAlign: TextAlign.center,
                    style: theme.bodyMedium!.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          offset: const Offset(0, 4),
                          blurRadius: 20,
                          color: AppColors.black.withOpacity(0.3),
                        ),
                      ],
                    ),
                  ),
                  RiseText(
                    pathway.description.isNotEmpty
                        ? desc
                        : 'No description available',
                    textAlign: TextAlign.center,
                    style: theme.labelSmall!.copyWith(
                      color: AppColors.white,
                      shadows: [
                        Shadow(
                          offset: const Offset(0, 4),
                          blurRadius: 20,
                          color: AppColors.black.withOpacity(0.3),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }

  List<Color> _getGradientFromHexColor(String hexColor) {
    final color = Color(int.parse(hexColor.replaceAll("0x", "0xFF")));
    return [color.withOpacity(0.8), color];
  }
}
