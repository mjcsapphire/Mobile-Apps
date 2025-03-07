// import 'package:fcfs_banking_app/core/theme/colors.dart';
// import 'package:fcfs_banking_app/src/controllers/theme_controller.dart';
// import 'package:flutter/material.dart';

// class FundCard extends StatelessWidget {
//   final String fundName;
//   final double amountSaved;
//   final double goalAmount;
//   final double progressPercentage;
//   final String goalDate;
//   final ThemeController themeController;
//   final BuildContext context;

//   const FundCard(
//       {super.key,
//       required this.fundName,
//       required this.amountSaved,
//       required this.goalAmount,
//       required this.progressPercentage,
//       required this.goalDate,
//       required this.themeController,
//       required this.context});

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     bool isOverViewSelected = true;
//     return Container(
//       height: 600,
//       margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(
//           colors: [Color(0xFF9B42F6), Color(0xFF3D1B88)],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               gradient: themeController.themeMode == ThemeMode.dark
//                   ? AppColors.darkAppBarGradient
//                   : AppColors.stackContainerBackground,
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Column(
//               children: [
//                 Text(
//                   fundName.toUpperCase(),
//                   style: theme.textTheme.displayMedium!.copyWith(
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   "\$${amountSaved.toStringAsFixed(0)}",
//                   style: theme.textTheme.displayMedium!.copyWith(
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 12),
//           Container(
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: themeController.themeMode == ThemeMode.dark
//                   ? AppColors.darkBorderColor
//                   : AppColors.red,
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: _buildToggleButtons(),
//           ),
//           const SizedBox(height: 16),
//           Text(
//             "${progressPercentage.toStringAsFixed(0)}% saved",
//             style: const TextStyle(color: Colors.white, fontSize: 16),
//           ),
//           const SizedBox(height: 6),
//           LinearProgressIndicator(
//             value: progressPercentage / 100,
//             backgroundColor: Colors.white30,
//             valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
//             minHeight: 5,
//           ),
//           const SizedBox(height: 6),
//           Text(
//             "On track to reach goal of $goalDate",
//             style: const TextStyle(color: Colors.white70, fontSize: 12),
//           ),
//           const SizedBox(height: 16),
//           _actionButton("Withdraw"),
//           _actionButton("Set new savings rule"),
//           _actionButton("Edit savings rule"),
//         ],
//       ),
//     );

//   }

//   Widget _buildToggleButtons() {
//     return Container(
//       height: 40,
//       width: MediaQuery.of(context).size.width * 0.6,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12),
//         color: Colors.white.withOpacity(0.2),
//       ),
//       child: Row(
//         children: [
//           _toggleButton('CONTACTS', isOverViewSelected, () {
//             setState(() {
//               isOverViewSelected = true;
//             });
//           }),
//           _toggleButton('PHONE NUMBER', !isOverViewSelected, () {
//             setState(() {
//               isOverViewSelected = false;
//             });
//           }),
//         ],
//       ),
//     );
//   }

//   Widget _toggleButton(String text, bool isSelected, VoidCallback onPressed) {
//     return Expanded(
//       child: GestureDetector(
//         onTap: onPressed,
//         child: Container(
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//             color: isSelected ? Colors.white : Colors.transparent,
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Text(
//             text,
//             style: Theme.of(context).textTheme.displaySmall?.copyWith(
//                   color: isSelected ? Colors.black : Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _actionButton(String text) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Text(
//         text,
//         style: const TextStyle(
//           color: Colors.red,
//           fontSize: 16,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     );
//   }
// }
