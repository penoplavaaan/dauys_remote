import 'package:dauys_remote/core/constants/regex.dart';
import 'package:dauys_remote/core/theme/app_colors.dart';
import 'package:dauys_remote/core/widget/app_text_input.dart';
import 'package:flutter/material.dart';

class PasswordInput extends StatefulWidget {
  const PasswordInput({
    super.key,
    required this.controller,
    required this.hintText,
  });

  final TextEditingController controller;
  final String hintText;

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
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

  String? validator(String? value) {
    if (value == null || value.isEmpty) return 'Введите пароль';

    if (AppRegExp.password.hasMatch(value)) return null;

    return 'Пароль должен содержать большие и маленькие буквы, цифры и быть не короче 8ми символов';
  }

  @override
  Widget build(BuildContext context) {
    return AppTextInput(
      controller: controller,
      hintText: widget.hintText,
      obscureText: obscureText,
      validator: validator,
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
