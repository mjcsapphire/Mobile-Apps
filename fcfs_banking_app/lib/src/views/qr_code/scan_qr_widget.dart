import 'package:fcfs_banking_app/core/utils/app_helpers.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRCodeScannerWidget extends StatefulWidget {
  final Function(String) onScanCompleted;
  final double borderSize;
  final Color borderColor;
  final double borderCornerRadius;

  const QRCodeScannerWidget({
    required this.onScanCompleted,
    this.borderSize = 300.0,
    this.borderColor = Colors.blue,
    this.borderCornerRadius = 12.0,
    super.key,
  });

  @override
  QRCodeScannerWidgetState createState() => QRCodeScannerWidgetState();
}

class QRCodeScannerWidgetState extends State<QRCodeScannerWidget> {
  final MobileScannerController _controller = MobileScannerController();
  bool _isScanned = false;

  void resetScanner() {
    setState(() => _isScanned = false);
    _controller.start();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MobileScanner(
          controller: _controller,
          onDetect: (barcode) {
            if (!_isScanned && barcode.barcodes.isNotEmpty) {
              setState(() => _isScanned = true);
              _controller.stop(); // Pause after detecting
              final displayValue = barcode
                  .barcodes.first.displayValue; // Access displayValue here

              if (displayValue != null) {
                widget.onScanCompleted(displayValue);
              } else {
                AppHelpers.toast('Invalid QR code format.');
              }
            }
          },
        ),

        // Overlay for Border Styling
        Center(
          child: Container(
            width: widget.borderSize,
            height: widget.borderSize,
            decoration: BoxDecoration(
              border: Border.all(color: widget.borderColor, width: 4.0),
              borderRadius: BorderRadius.circular(widget.borderCornerRadius),
            ),
            child: CustomPaint(
              painter: _BorderPainter(widget.borderColor),
            ),
          ),
        ),

        // Instruction Text
        const Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(bottom: 20.0),
            child: Text(
              'Align QR code within the frame to scan',
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}

class _BorderPainter extends CustomPainter {
  final Color color;
  _BorderPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    const cornerSize = 20.0;

    // Top-left corner
    canvas.drawLine(const Offset(0, cornerSize), const Offset(0, 0), paint);
    canvas.drawLine(const Offset(0, 0), const Offset(cornerSize, 0), paint);

    // Top-right corner
    canvas.drawLine(
        Offset(size.width - cornerSize, 0), Offset(size.width, 0), paint);
    canvas.drawLine(
        Offset(size.width, 0), Offset(size.width, cornerSize), paint);

    // Bottom-left corner
    canvas.drawLine(
        Offset(0, size.height - cornerSize), Offset(0, size.height), paint);
    canvas.drawLine(
        Offset(0, size.height), Offset(cornerSize, size.height), paint);

    // Bottom-right corner
    canvas.drawLine(Offset(size.width - cornerSize, size.height),
        Offset(size.width, size.height), paint);
    canvas.drawLine(Offset(size.width, size.height - cornerSize),
        Offset(size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
