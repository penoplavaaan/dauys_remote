import 'package:dauys_remote/api/api.dart';
import 'package:dauys_remote/core/constants/regex.dart';
import 'package:dauys_remote/core/widget/app_button.dart';
import 'package:dauys_remote/core/widget/app_scaffold.dart';
import 'package:dauys_remote/core/widget/app_text_input.dart';
import 'package:dauys_remote/features/auth/widget/auth_top_panel.dart';
import 'package:dauys_remote/features/auth/widget/password_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../gateway/gateway_screen.dart';

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
        final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: emailPhoneController.text,
          password: passwordController.text,
        );
        await api.login(emailPhoneController.text,  passwordController.text);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const GateWayScreen()),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          try {
            final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
              email: emailPhoneController.text,
              password: passwordController.text,
            );

            await api.login(emailPhoneController.text,  passwordController.text);
            print('we are logged in');
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const GateWayScreen()),
            );
          } on FirebaseAuthException catch (e) {
            if (e.code == 'user-not-found') {
            } else if (e.code == 'wrong-password') {
            }
          }
        }
      } catch (e) {
        print(e);
      }
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
                      title: 'Войти1',
                      width: 130,
                      onTap: isFormValid
                          ? () {
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
