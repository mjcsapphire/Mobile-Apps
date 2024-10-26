import 'package:fcfs_banking_app/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final Icon? suffixIcon;
  final Icon? prefixIcon;
  final bool obscureText;
  final bool editable;

  final ValueChanged<String>? onChanged;
  final TextInputType keyboardType;
  final FormFieldValidator<String?> validator;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    required this.obscureText,
    this.onChanged,
    required this.keyboardType,
    required this.validator,
    this.editable = true,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChanged,
      controller: widget.controller,
      style: Theme.of(context).textTheme.displaySmall?.copyWith(
            fontSize: 15.sp,
          ),
      validator: widget.validator,
      obscureText: widget.obscureText && !isPasswordVisible,
      keyboardType: widget.keyboardType,
      cursorColor: AppColors.white,
      enabled: widget.editable,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        hintText: widget.hintText,
        hintStyle: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: AppColors.white.withOpacity(0.5),
            ),
        errorStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: AppColors.lightRed,
              fontSize: 13.sp,
            ),
        suffixIcon: widget.obscureText
            ? IconButton(
                onPressed: () {
                  setState(() => isPasswordVisible = !isPasswordVisible);
                },
                icon: Icon(isPasswordVisible
                    ? Icons.visibility
                    : Icons.visibility_off),
              )
            : widget.suffixIcon,
        suffixIconColor: AppColors.primaryColor,
        prefixIcon: widget.prefixIcon,
        prefixIconColor: AppColors.primaryColor,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        focusColor: AppColors.primaryColor,
        disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 0.6,
            color: AppColors.textGreyColor,
          ),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 0.6,
            color: AppColors.pinkColor,
          ),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 0.6,
            color: AppColors.textGreyColor,
          ),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
    );
  }
}
