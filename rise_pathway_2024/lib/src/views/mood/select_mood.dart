// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rise_pathway/config/constants/package_export.dart';
import 'package:rise_pathway/config/helpers/helpers.dart';
import 'package:rise_pathway/config/routes/routes.dart';
import 'package:rise_pathway/config/utils/colors.dart';
import 'package:rise_pathway/src/controllers/home_controller.dart';
import 'package:rise_pathway/src/views/widget/app_bar.dart';

RxInt activatedIndex = 0.obs;

class SelectMood extends StatefulWidget {
  const SelectMood({
    super.key,
  });

  @override
  State<SelectMood> createState() => _SelectMoodState();
}

class _SelectMoodState extends State<SelectMood> {
  final homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: RiseAppBar.riseAppBar(
        theme: theme,
        title: 'Today’s Feeling',
        onTap: () => context.pop(),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 6.h),
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            RiseText(
              'How would you describe your mood?',
              textAlign: TextAlign.center,
              style: theme.titleLarge!.copyWith(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(height: 4.h),
            RiseText(
              'I Feel Neutral.',
              textAlign: TextAlign.center,
              style: theme.titleMedium!.copyWith(
                color: AppColors.blue,
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(height: 3.h),
            Obx(() {
              int emojiIndex = homeController.currentIndex.value;
              int index = 0;
              if (emojiIndex <= 10) {
                index = (10 - emojiIndex);
              } else {
                index = (10 - emojiIndex) + 14;
              }
              List<Color> background =
                  Helpers.emojiBackground.reversed.toList();
              if (emojiIndex == 14) {
                emojiIndex = 0;
                homeController.currentIndex.value = 0;
              }
              return Container(
                height: 14.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: background[index],
                ),
                child: Image.asset(
                  Helpers.imagePaths[index],
                  scale: 2,
                ),
              );
            }),
            SizedBox(height: 3.h),
            SvgPicture.asset(
              'assets/svg/double_down.svg',
            ),
            SizedBox(height: 4.h),
            const StrokeCircleWithImages(),
          ],
        ),
      ),
    );
  }
}

class StrokeCircleWithImages extends StatefulWidget {
  const StrokeCircleWithImages({super.key});

  @override
  _StrokeCircleWithImagesState createState() => _StrokeCircleWithImagesState();
}

class _StrokeCircleWithImagesState extends State<StrokeCircleWithImages> {
  List<ui.Image>? images;
  double rotationAngle = 0.0;
  int currentIndex = 0;
  final homeController = Get.find<HomeController>();

  @override
  void initState() {
    super.initState();
    _loadImages();
  }

  Future<void> _loadImages() async {
    List<Future<ui.Image>> futures =
        Helpers.imagePaths.map(_loadImage).toList();
    List<ui.Image> loadedImages = await Future.wait(futures);

    setState(() {
      images = loadedImages;
    });
  }

  Future<ui.Image> _loadImage(String asset) async {
    final ByteData data = await rootBundle.load(asset);
    final Completer<ui.Image> completer = Completer();
    ui.decodeImageFromList(data.buffer.asUint8List(), (ui.Image img) {
      completer.complete(img);
    });
    return completer.future;
  }

  void _rotateCircle(bool isLeft) {
    setState(() {
      currentIndex = (currentIndex) % images!.length;
      if (isLeft) {
        rotationAngle += 0.05 * (2 * pi / images!.length);
      } else {
        rotationAngle -= 0.05 * (2 * pi / images!.length);
      }
    });
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    setState(() {
      if (details.delta.dx == 0) {
        return;
      }
      if (details.delta.dx > 0) {
        _rotateCircle(true);
      } else {
        _rotateCircle(false);
      }
    });
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    setState(() {
      double anglePerImage = (2 * pi) / images!.length;
      double rotationOffset = rotationAngle % (2 * pi);

      if (rotationOffset < 0) {
        rotationOffset += 2 * pi;
      }

      int closestIndex = (rotationOffset / anglePerImage).round();
      rotationAngle = closestIndex * anglePerImage;
      currentIndex = closestIndex % images!.length;
      homeController.currentIndex.value = closestIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Transform.rotate(
              angle: rotationAngle,
              child: CustomPaint(
                size: const Size(600, 600),
                painter: images == null ? null : StrokeCirclePainter(images!),
              ),
            ),
            GestureDetector(
              onHorizontalDragUpdate: _onHorizontalDragUpdate,
              onHorizontalDragEnd: _onHorizontalDragEnd,
              child: Container(
                width: 100.w,
                height: 100.h,
                color: Colors.transparent,
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 16.h),
          child: SvgPicture.asset(
            'assets/svg/choice_icon.svg',
            height: 60,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 30.h),
          child: GestureDetector(
            onTap: () => context.go(app),
            child: Container(
              width: 40.w,
              height: 16.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: AppColorsGredients.primaryLeftToRight,
                borderRadius: BorderRadius.circular(20),
              ),
              child: RiseText(
                'Next',
                style: theme.titleSmall!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class StrokeCirclePainter extends CustomPainter {
  final List<ui.Image> images;

  StrokeCirclePainter(this.images);

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);

    // Reduce the radius to make the sections narrower horizontally
    final double outerRadius = (size.width * 2.7) / 2.5;
    final double innerRadius = outerRadius;
    final double shadowRadius = outerRadius / 1.165;

    double sweepAngle = (2 * pi / images.length);

    List<Color> background = Helpers.emojiBackground.reversed.toList();

    for (int i = 0; i < images.length; i++) {
      final Paint sectionPaint = Paint()
        ..color = background[i]
        ..strokeWidth = 20.h
        ..style = PaintingStyle.stroke;

      final Paint circlePaint = Paint()
        ..color = AppColors.black.withOpacity(0.02)
        ..strokeWidth = 2.h
        ..style = PaintingStyle.stroke;

      /// [Emoji Circle] Draw the arc with a reduced section width
      canvas.drawArc(
        Rect.fromCircle(
            center: center, radius: (outerRadius + innerRadius) / 1.8),
        (i * sweepAngle),
        sweepAngle,
        false,
        sectionPaint,
      );

      /// [Shadow Circle]
      canvas.drawCircle(center, shadowRadius, circlePaint);

      double angle = (i * sweepAngle) + (sweepAngle / 2);

      final Offset imageOffset = Offset(
        center.dx + (outerRadius) * cos(angle) - 30,
        center.dy + (outerRadius) * sin(angle) - 30,
      );

      canvas.save();

      canvas.translate(
        imageOffset.dx + 30,
        imageOffset.dy + 30,
      );

      canvas.rotate(angle + pi / 2);

      canvas.saveLayer(
        Rect.fromLTWH(
          imageOffset.dx - 30,
          imageOffset.dy - 30,
          60,
          60,
        ),
        Paint(),
      );

      canvas.restore();

      paintImage(
        canvas: canvas,
        image: images[i],
        rect: const Rect.fromLTWH(-30, -60, 60, 60),
        fit: BoxFit.contain,
      );

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
