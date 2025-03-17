import 'package:dauys_remote/api/api.dart';
import 'package:dauys_remote/core/constants/regex.dart';
import 'package:dauys_remote/core/theme/app_colors.dart';
import 'package:dauys_remote/core/theme/app_styles.dart';
import 'package:dauys_remote/core/widget/app_button.dart';
import 'package:dauys_remote/core/widget/app_scaffold.dart';
import 'package:dauys_remote/core/widget/app_text_input.dart';
import 'package:dauys_remote/features/auth/auth_geateway_screen.dart';
import 'package:dauys_remote/features/auth/widget/auth_top_panel.dart';
import 'package:dauys_remote/features/auth/widget/password_input.dart';
import 'package:dauys_remote/features/gateway/gateway_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

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
    if (value == null || value.isEmpty) return FlutterI18n.translate(context, "auth.login.email_phone_empty");

    if (AppRegExp.phone.hasMatch(value)) return null;

    if (AppRegExp.digitsOnly.hasMatch(value)) return FlutterI18n.translate(context, "auth.login.invalid_phone");

    if (AppRegExp.email.hasMatch(value)) return null;

    return FlutterI18n.translate(context, "auth.login.invalid_email");
  }

  Future<void> _signIn() async {
    final api = await Api.createFirstTime();

    try {
      await api.login(emailPhoneController.text, passwordController.text);
      await api.makeSubscription();

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const GateWayScreen()),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              FlutterI18n.translate(context, "auth.login.invalid_credentials"),
              style: AppStyles.magistral14w400.copyWith(color: AppColors.white),
            ),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Column(
        children: [
          AuthTopPanel(
            title: FlutterI18n.translate(context, "auth.login.title"),
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
                      hintText: FlutterI18n.translate(context, "auth.login.email_phone_hint"),
                      validator: validateEmailOrPhone,
                    ),
                    const SizedBox(height: 30),
                    PasswordInput(
                      controller: passwordController,
                      hintText: FlutterI18n.translate(context, "auth.login.password_hint"),
                    ),
                    const SizedBox(height: 30),
                    AppButton(
                      title: FlutterI18n.translate(context, "auth.login.button"),
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
