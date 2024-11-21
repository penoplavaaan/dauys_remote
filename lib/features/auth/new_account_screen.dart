import 'package:dauys_remote/core/constants/regex.dart';
import 'package:dauys_remote/core/widget/app_button.dart';
import 'package:dauys_remote/core/widget/app_scaffold.dart';
import 'package:dauys_remote/core/widget/app_text_input.dart';
import 'package:dauys_remote/features/auth/new_account_screen2.dart';
import 'package:dauys_remote/features/auth/widget/auth_top_panel.dart';
import 'package:flutter/material.dart';

class NewAccountScreen extends StatefulWidget {
  const NewAccountScreen({super.key});

  @override
  State<NewAccountScreen> createState() => _NewAccountScreenState();
}

class _NewAccountScreenState extends State<NewAccountScreen> {
  final controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isFormValid = false;

  void onChanged() {
    setState(() {
      isFormValid = _formKey.currentState?.validate() ?? false;
    });
  }

  String? validateEmailOrPhone(String? value) {
    if (value == null || value.isEmpty) return 'Введите email или телефон';

    if (AppRegExp.phone.hasMatch(value)) return null;

    if (AppRegExp.digitsOnly.hasMatch(value)) return 'Неправильный телефон';

    if (AppRegExp.email.hasMatch(value)) return null;

    return 'Неправильный email';
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Column(
        children: [
          const AuthTopPanel(title: 'Новый аккаунт'),
          const SizedBox(height: 40),
          Form(
            key: _formKey,
            onChanged: onChanged,
            child: Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    AppTextInput(
                      controller: controller,
                      hintText: 'Ваш эл. адрес или номер телефона',
                      validator: validateEmailOrPhone,
                    ),
                    const SizedBox(height: 30),
                    AppButton(
                      title: 'Далее',
                      width: 130,
                      onTap: isFormValid
                          ? () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const NewAccountScreen2()),
                              );
                            }
                          : null,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
