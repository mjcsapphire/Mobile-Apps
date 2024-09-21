import 'package:flutter/material.dart';
import 'package:rise_pathway/core/constants/package_export.dart';
import 'package:rise_pathway/core/helpers/helpers.dart';
import 'package:rise_pathway/core/utils/colors.dart';

class RisePathwayCard extends StatelessWidget {
  const RisePathwayCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final list = [
      {
        'imagePath': 'assets/container_assets/frame_1.png',
        'title': 'Communication',
        'subtitle': 'How you express and share',
        'gradient': const LinearGradient(
          end: Alignment.bottomLeft,
          begin: Alignment.topRight,
          colors: [
            Color(0xFF08477D),
            Color(0xFF0F81E3),
          ],
        )
      },
      {
        'imagePath': 'assets/container_assets/frame_2.png',
        'title': 'Adaptation',
        'subtitle': 'How you adjust and change',
        'gradient': const LinearGradient(
          end: Alignment.bottomLeft,
          begin: Alignment.topRight,
          colors: [
            Color(0xFFDA22FF),
            Color(0xFF9733EE),
          ],
        )
      },
      {
        'imagePath': 'assets/container_assets/frame_3.png',
        'title': 'Relationships',
        'subtitle': 'How you build and connect',
        'gradient': const LinearGradient(
          end: Alignment.bottomLeft,
          begin: Alignment.topRight,
          colors: [
            Color(0xFFE06C00),
            Color(0xFFFFC225),
          ],
        )
      },
      {
        'imagePath': 'assets/container_assets/frame_4.png',
        'title': 'Leadership',
        'subtitle': 'How you guide and influence',
        'gradient': const LinearGradient(
          end: Alignment.bottomLeft,
          begin: Alignment.topRight,
          colors: [
            Color(0xFF56AB2F),
            Color(0xFFA8E063),
          ],
        )
      },
      {
        'imagePath': 'assets/container_assets/frame_5.png',
        'title': 'Collaboration',
        'subtitle': 'How you work with others',
        'gradient': const LinearGradient(
          end: Alignment.bottomLeft,
          begin: Alignment.topRight,
          colors: [
            Color(0xFFE00087),
            Color(0xFF8652F5),
          ],
        )
      },
      {
        'imagePath': 'assets/container_assets/frame_6.png',
        'title': 'Creativity',
        'subtitle': 'How you innovate and create',
        'gradient': const LinearGradient(
          end: Alignment.bottomLeft,
          begin: Alignment.topRight,
          colors: [
            Color(0xFFFF0000),
            Color(0xffff7a00),
          ],
        ),
      },
    ];

    return GridView.builder(
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: 6,
      itemBuilder: (context, index) => Container(
        width: 100.w,
        height: 100.h,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26),
          gradient: list[index]['gradient'] as Gradient,
          image: DecorationImage(
            image: AssetImage(
              list[index]['imagePath'].toString(),
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RiseText(
              list[index]['title'].toString(),
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
              list[index]['subtitle'].toString(),
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
  }
}
