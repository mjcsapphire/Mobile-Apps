import 'package:fcfs_banking_app/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TextfieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String label;
  final int maxLines;
  final bool obscureText;
  final bool enabled;
  final TextAlign textAlign;
  final TextInputType? keyboardType;
  final FloatingLabelAlignment? floatingLabelAlignment;
  final bool showlabel;
  final ValueChanged<String>? onChanged;

  const TextfieldWidget({
    super.key,
    this.controller,
    required this.label,
    this.maxLines = 1,
    this.obscureText = false,
    this.enabled = true,
    this.textAlign = TextAlign.center,
    required this.keyboardType,
    this.floatingLabelAlignment = FloatingLabelAlignment.center,
    this.showlabel = true,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 6.h,
      child: TextFormField(
        onChanged: onChanged,
        textAlign: textAlign,
        controller: controller,
        enabled: enabled,
        maxLines: maxLines,
        obscureText: obscureText,
        cursorColor: AppColors.burgundy,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
        keyboardType: keyboardType,
        decoration: InputDecoration(
          alignLabelWithHint: true,
          labelText: label,

          floatingLabelAlignment: showlabel ? floatingLabelAlignment : null,
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.pinkGrey, width: 0.5),
          ),
          errorStyle: Theme.of(context)
              .textTheme
              .displayMedium
              ?.copyWith(color: AppColors.pinkColor, fontSize: 16.sp),
          labelStyle: Theme.of(context)
              .textTheme
              .displayMedium
              ?.copyWith(fontSize: 17.sp),
          fillColor: AppColors.textEditingBoxColor,
          filled: true,
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.white.withOpacity(0.4)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.white.withOpacity(0.4)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white70.withOpacity(0.4)),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[600]!),
          ),
          // contentPadding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.3),
        ),
        style: Theme.of(context).textTheme.displayMedium,
      ),
    );
  }
}
