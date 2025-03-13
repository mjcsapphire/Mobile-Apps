import 'package:fcfs_banking_app/core/utils/app_helpers.dart';
import 'package:fcfs_banking_app/services/router/routes_name.dart';
import 'package:fcfs_banking_app/src/views/qr_code/scan_qr_widget.dart';
import 'package:fcfs_banking_app/src/views/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Scan QR",
        showMoreVertIcon: false,
        showNotificationIcon: false,
        showProfilePic: false,
      ),
      body: QRCodeScannerWidget(
        onScanCompleted: (String scannedData) {
          print('Scanned Data: $scannedData'); // Debugging line

          // Use regular expression to extract phone and amount
          final RegExp regExp = RegExp(r'phone=(.+?)&amount=(.+)');
          final match = regExp.firstMatch(scannedData);

          if (match != null && match.groupCount == 2) {
            final String phoneNumber = match.group(1)!.trim();
            final String amountString = match.group(2)!.trim();

            print('Phone Number: $phoneNumber'); // Debugging line
            print('Amount String: $amountString'); // Debugging line

            final double? amount = double.tryParse(amountString);

            if (amount != null && amount > 0) {
              print('Parsed Amount: $amount'); // Debugging line
              // _showPaymentDialog(context, phoneNumber, amount);
              context.pushNamed(RoutesName.qrPaymentScreen, pathParameters: {
                'phoneNumber': phoneNumber,
                'amount': amount.toString(),
              });
            } else {
              AppHelpers.toast('Invalid amount in QR code.');
            }
          } else {
            // Handle invalid format
            AppHelpers.toast('Invalid QR code format.');
          }
        },
        borderSize: 350,
        borderColor: Colors.blue,
        borderCornerRadius: 12.0,
      ),
    );
  }
}
