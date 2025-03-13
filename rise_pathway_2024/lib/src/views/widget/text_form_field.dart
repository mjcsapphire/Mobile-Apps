import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rise_pathway/core/constants/package_export.dart';
import 'package:rise_pathway/core/helpers/helpers.dart';
import 'package:rise_pathway/core/utils/colors.dart';

class RiseTextField extends StatefulWidget {
  final GlobalKey<FormState>? formKey;
  final double? width;
  final bool? isPassword;
  final IconData? suffixIcon;
  final String? hintText;
  final String? labelText;
  final String? errorText;
  final String? title;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final bool? readOnly;
  final TextEditingController controller;
  final int? maxLength;
  final int? maxLines;
  final Function(String?)? onChanged;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;

  const RiseTextField({
    super.key,
    this.width,
    this.suffixIcon,
    this.hintText,
    this.labelText,
    this.errorText,
    this.validator,
    this.title,
    this.maxLines,
    required this.keyboardType,
    this.isPassword,
    this.readOnly,
    required this.controller,
    this.maxLength,
    this.onChanged,
    this.formKey,
    this.textInputAction,
    this.focusNode,
  });

  @override
  State<RiseTextField> createState() => _RiseTextFieldState();
}

class _RiseTextFieldState extends State<RiseTextField> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return SizedBox(
      width: widget.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null) ...{
            RiseText(
              widget.title ?? "",
              style: theme.bodySmall!.copyWith(
                color: AppColors.textFieldColor,
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 1.h),
          },
          TextFormField(
            controller: widget.controller,
            maxLines: widget.maxLines ?? 1,
            readOnly: widget.readOnly ?? false,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            obscureText: widget.isPassword ?? false,
            cursorColor: AppColors.darkBlue,
            validator: widget.validator,
            maxLength: widget.maxLength,
            maxLengthEnforcement: MaxLengthEnforcement.none,
            showCursor: true,
            onChanged: widget.onChanged,

            style: theme.bodySmall!.copyWith(
              color: AppColors.black,
              fontSize: 14.sp,
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                vertical: 2.4.h,
                horizontal: 6.w,
              ),
              errorStyle: theme.bodySmall!.copyWith(
                color: AppColors.error,
                fontSize: 9.sp,
              ),
              hintText: widget.hintText,
              hintStyle: theme.bodySmall!.copyWith(
                color: AppColors.textFieldColor,
                fontSize: 14.sp,
              ),
              suffixIcon: widget.suffixIcon != null
                  ? Padding(
                      padding: EdgeInsets.only(right: 2.h),
                      child: Icon(
                        widget.suffixIcon,
                        color: AppColors.textFieldBorderColor,
                      ),
                    )
                  : null,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(
                  color: AppColors.darkBlue,
                  width: 1.2,
                ),
              ),
              errorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(color: AppColors.error),
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(color: AppColors.error, width: 1.5),
              ),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(color: AppColors.textFieldBorderColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
