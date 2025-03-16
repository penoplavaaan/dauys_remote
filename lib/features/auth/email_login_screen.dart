import 'package:dauys_remote/api/api.dart';
import 'package:dauys_remote/core/constants/regex.dart';
import 'package:dauys_remote/core/widget/app_button.dart';
import 'package:dauys_remote/core/widget/app_scaffold.dart';
import 'package:dauys_remote/core/widget/app_text_input.dart';
import 'package:dauys_remote/features/auth/auth_geateway_screen.dart';
import 'package:dauys_remote/features/auth/widget/auth_top_panel.dart';
import 'package:dauys_remote/features/auth/widget/password_input.dart';
import 'package:dauys_remote/features/gateway/gateway_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailLoginScreen extends StatefulWidget {
  const EmailLoginScreen({super.key});

  @override
  State<EmailLoginScreen> createState() => _EmailLoginScreenState();
}

class _EmailLoginScreenState extends State<EmailLoginScreen> {
  final emailPhoneController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

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

  Future<void> _signIn() async {
    final api = await Api.createFirstTime();

    try {
        await api.login(emailPhoneController.text,  passwordController.text);
        await api.makeSubscription();

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const GateWayScreen()),
        );
      } catch (e) {
        print(e);
      }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Column(
        children: [
          AuthTopPanel(
            title: 'Войти',
            onBack: () => {
              print('back'),
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const AuthGeatewayScreen()),
              )
            },
          ),
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
                      controller: emailPhoneController,
                      hintText: 'Ваш эл. адрес или номер телефона',
                      validator: validateEmailOrPhone,
                    ),
                    const SizedBox(height: 30),
                    PasswordInput(
                      controller: passwordController,
                      hintText: 'Ваш пароль',
                    ),
                    const SizedBox(height: 30),
                    AppButton(
                      title: 'Войти',
                      width: 130,
                      onTap: isFormValid
                          ? () {
                          print('click');
                          _signIn();
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
