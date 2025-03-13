import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRGeneratorWidget extends StatelessWidget {
  final String phoneNumber;
  final double amount;
  final double size;
  final Color color;

  const QRGeneratorWidget({
    required this.phoneNumber,
    required this.amount,
    this.size = 200,
    this.color = Colors.black,
    super.key,
  });

  /// Generates QR data string based on phone number and amount
  String _generateQRData() {
    return 'phone=$phoneNumber&amount=$amount';
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: QrImageView(
        data: _generateQRData(),
        version: QrVersions.auto,
        size: size,
        foregroundColor: color,
        errorStateBuilder: (context, error) {
          return const Center(
            child: Text(
              'Error generating QR code. Please try again.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.red),
            ),
          );
        },
      ),
    );
  }
}
