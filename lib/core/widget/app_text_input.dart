import 'package:dauys_remote/core/theme/app_colors.dart';
import 'package:dauys_remote/core/theme/app_styles.dart';
import 'package:flutter/material.dart';

class AppTextInput extends StatefulWidget {
  const AppTextInput({
    super.key,
    this.hintText,
    required this.controller,
    this.validator,
    this.obscureText = false,
    this.suffixIcon,
  });

  final String? hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool obscureText;

  final Widget? suffixIcon;

  @override
  State<AppTextInput> createState() => _AppTextInputState();
}

class _AppTextInputState extends State<AppTextInput> {
  late bool obscureText = widget.obscureText;
  late final controller = widget.controller;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      style: AppStyles.magistral16w500.copyWith(color: AppColors.white),
      cursorColor: AppColors.white.withOpacity(0.5),
      cursorErrorColor: AppColors.white.withOpacity(0.5),
      validator: widget.validator,
      obscureText: widget.obscureText,
      decoration: InputDecoration(
        // constraints: const BoxConstraints(maxHeight: 50, maxWidth: double.infinity, minHeight: 50),
        hintText: widget.hintText,
        hintStyle: AppStyles.magistral16w500.copyWith(color: AppColors.white.withOpacity(0.5)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        filled: true,
        fillColor: AppColors.white.withOpacity(0.2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        suffixIcon: widget.suffixIcon,
        errorStyle: AppStyles.magistral16w500.copyWith(color: AppColors.white.withOpacity(0.5)),
        errorMaxLines: 10,
      ),
    );
  }
}
