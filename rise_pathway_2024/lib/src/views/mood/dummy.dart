// class StrokeCircleWithImages extends StatefulWidget {
//   const StrokeCircleWithImages({super.key});

//   @override
//   _StrokeCircleWithImagesState createState() => _StrokeCircleWithImagesState();
// }

// class _StrokeCircleWithImagesState extends State<StrokeCircleWithImages> {
//   List<ui.Image>? images;
//   double rotationAngle = 0.0;
//   double startDragAngle = 0.0;
//   double rotationDelta = 0.0;
//   double _rotationSpeed = 0.005; // Adjusted speed factor for rotation
//   int currentIndex = 0;

//   @override
//   void initState() {
//     super.initState();
//     _loadImages();
//   }

//   Future<void> _loadImages() async {
//     // Load images asynchronously
//     List<String> imagePaths = [
//       'assets/icons/emotion.png',
//       'assets/icons/happy_mood.png',
//       'assets/icons/sad_mood.png',
//       'assets/icons/emotion.png',
//       'assets/icons/happy_mood.png',
//       'assets/icons/sad_mood.png',
//       'assets/icons/emotion.png',
//       'assets/icons/happy_mood.png',
//       'assets/icons/sad_mood.png',
//       'assets/icons/emotion.png',
//     ];

//     List<Future<ui.Image>> futures = imagePaths.map(_loadImage).toList();
//     List<ui.Image> loadedImages = await Future.wait(futures);

//     setState(() {
//       images = loadedImages; // Once loaded, update the state
//     });
//   }

//   Future<ui.Image> _loadImage(String asset) async {
//     final ByteData data = await rootBundle.load(asset);
//     final Completer<ui.Image> completer = Completer();
//     ui.decodeImageFromList(data.buffer.asUint8List(), (ui.Image img) {
//       completer.complete(img);
//     });
//     return completer.future;
//   }

//   void _rotateCircle(double delta) {
//     setState(() {
//       rotationDelta += delta;
//     });
//   }

//   void _onHorizontalDragStart(DragStartDetails details) {
//     final RenderBox renderBox = context.findRenderObject() as RenderBox;
//     final Offset localOffset = renderBox.globalToLocal(details.globalPosition);
//     startDragAngle = atan2(
//       localOffset.dy - renderBox.size.height / 2,
//       localOffset.dx - renderBox.size.width / 2,
//     );
//   }

//   void _onHorizontalDragUpdate(DragUpdateDetails details) {
//     final RenderBox renderBox = context.findRenderObject() as RenderBox;
//     final Offset localOffset = renderBox.globalToLocal(details.globalPosition);
//     final double currentAngle = atan2(
//       localOffset.dy - renderBox.size.height / 2,
//       localOffset.dx - renderBox.size.width / 2,
//     );
//     final double delta = currentAngle - startDragAngle;
//     _rotateCircle(delta);
//     startDragAngle = currentAngle;
//   }

//   void _onHorizontalDragEnd(DragEndDetails details) {
//     // Snap to the nearest section on drag end
//     double sectionAngle = 2 * pi / images!.length;
//     double adjustedRotation = rotationDelta % (2 * pi);
//     int newIndex = ((adjustedRotation / sectionAngle).round()) % images!.length;
//     double snapAngle = newIndex * sectionAngle;
//     setState(() {
//       rotationAngle += (snapAngle - adjustedRotation);
//       rotationDelta = rotationAngle %
//           (2 * pi); // Update rotationDelta for consistent swiping
//       currentIndex = newIndex;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context).textTheme;
//     return Stack(
//       alignment: Alignment.topCenter,
//       children: [
//         GestureDetector(
//           onHorizontalDragStart:
//               _onHorizontalDragStart, // Capture start of drag
//           onHorizontalDragUpdate:
//               _onHorizontalDragUpdate, // Update rotation based on drag
//           onHorizontalDragEnd: _onHorizontalDragEnd, // Snap to nearest section
//           child: Transform.rotate(
//             angle: rotationAngle + rotationDelta,
//             child: CustomPaint(
//               size: const Size(600, 600), // Set the size of the circle
//               painter: images == null
//                   ? null // Only paint when images are loaded
//                   : StrokeCirclePainter(images!),
//             ),
//           ),
//         ),
//         Padding(
//           padding: EdgeInsets.only(top: 3.h),
//           child: Image.asset(
//             'assets/icons/choice_icon.png',
//             scale: 4,
//           ),
//         ),
//         Padding(
//           padding: EdgeInsets.only(top: 16.h),
//           child: GestureDetector(
//             onTap: () {
//               final double sectionAngle = 2 * pi / images!.length;
//               setState(() {
//                 rotationAngle += sectionAngle; // Rotate by one section on tap
//                 rotationDelta = rotationAngle % (2 * pi);
//                 currentIndex = (currentIndex + 1) % images!.length;
//               });
//             },
//             child: Container(
//               width: 40.w,
//               height: 16.w,
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                   gradient: AppColorsGredients.gradient3,
//                   borderRadius: BorderRadius.circular(20)),
//               child: RiseText(
//                 'Next',
//                 style: theme.titleLarge!.copyWith(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class StrokeCirclePainter extends CustomPainter {
//   final List<ui.Image> images;

//   StrokeCirclePainter(this.images);

//   @override
//   void paint(Canvas canvas, Size size) {
//     final Offset center = Offset(size.width / 2, size.height / 2);
//     final double radius = (size.width * 2.3) / 2; // Circle radius

//     // List of colors for each section
//     List<Color> colors = [
//       Colors.blue,
//       Colors.green,
//       Colors.red,
//       Colors.orange,
//       Colors.purple,
//       Colors.yellow,
//       Colors.orange,
//       Colors.teal,
//       Colors.indigo,
//       Colors.purple,
//     ];

//     // Calculate the sweep angle (how much of the circle each section covers)
//     double sweepAngle = 2 * pi / images.length;

//     // Draw each section with a different color and align images in the center of each arc
//     for (int i = 0; i < images.length; i++) {
//       final Paint sectionPaint = Paint()
//         ..color = colors[i]
//         ..strokeWidth = 180 // Stroke width of sections
//         ..style = PaintingStyle.stroke;

//       final Paint circlePaint = Paint()
//         ..color = Colors.black.withOpacity(0.01)
//         ..strokeWidth = 20 // Stroke width of sections
//         ..style = PaintingStyle.stroke;

//       // Draw the colored section (arc)
//       canvas.drawArc(
//         Rect.fromCircle(center: center, radius: radius),
//         i * sweepAngle,
//         sweepAngle,
//         false,
//         sectionPaint,
//       );

//       canvas.drawCircle(center, 255, circlePaint);

//       // Calculate the position for the image at the center of each section
//       double angle = (i * sweepAngle) + (sweepAngle / 2);

//       // Calculate image position and rotation matrix for upright orientation
//       final Offset imageOffset = Offset(
//         center.dx + (radius) * cos(angle) - 30, // Adjust for X-axis
//         center.dy + (radius) * sin(angle) - 30, // Adjust for Y-axis
//       );

//       // Save the canvas state before applying rotation
//       canvas.save();

//       // Move canvas to the image's center point
//       canvas.translate(
//         imageOffset.dx + 30,
//         imageOffset.dy + 30,
//       );

//       // Rotate canvas by the negative of the angle to keep image upright
//       canvas.rotate(-angle - pi / 2);

//       // Draw the image at the calculated position
//       paintImage(
//         canvas: canvas,
//         image: images[i],
//         rect: const Rect.fromLTWH(
//           -30,
//           -30,
//           60,
//           60,
//         ),
//         fit: BoxFit.contain,
//       );

//       // Restore the canvas to its previous state after drawing the image
//       canvas.restore();
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true; // Repaint when state changes
//   }
// }
