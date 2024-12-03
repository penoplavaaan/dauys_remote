import 'package:dauys_remote/core/constants/regex.dart';
import 'package:dauys_remote/core/theme/app_colors.dart';
import 'package:dauys_remote/core/widget/app_text_input.dart';
import 'package:flutter/material.dart';

class NullablePasswordInput extends StatefulWidget {
  const NullablePasswordInput({
    super.key,
    required this.controller,
    required this.hintText,
  });

  final TextEditingController controller;
  final String hintText;

  @override
  State<NullablePasswordInput> createState() => _NullablePasswordInputState();
}

class _NullablePasswordInputState extends State<NullablePasswordInput> {
  late final controller = widget.controller;

  bool obscureText = true;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppTextInput(
      controller: controller,
      hintText: widget.hintText,
      obscureText: obscureText,
      suffixIcon: IconButton(
        icon: Icon(
          obscureText ? Icons.visibility : Icons.visibility_off,
          color: AppColors.white.withOpacity(0.5),
        ),
        onPressed: _togglePasswordVisibility,
      ),
    );
  }
}
