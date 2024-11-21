import 'package:dauys_remote/core/widget/app_button.dart';
import 'package:dauys_remote/core/widget/app_scaffold.dart';
import 'package:dauys_remote/features/auth/widget/auth_top_panel.dart';
import 'package:dauys_remote/features/auth/widget/password_input.dart';
import 'package:dauys_remote/features/gateway/gateway_screen.dart';
import 'package:flutter/material.dart';

class NewAccountScreen2 extends StatefulWidget {
  const NewAccountScreen2({super.key});

  @override
  State<NewAccountScreen2> createState() => _NewAccountScreen2State();
}

class _NewAccountScreen2State extends State<NewAccountScreen2> {
  final controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isFormValid = false;

  @override
  void initState() {
    super.initState();
  }

  void onChanged() {
    setState(() {
      isFormValid = _formKey.currentState?.validate() ?? false;
    });
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
                    PasswordInput(
                      controller: controller,
                      hintText: 'Придумайте пароль',
                    ),
                    const SizedBox(height: 30),
                    AppButton(
                      title: 'Далее',
                      width: 130,
                      onTap: isFormValid
                          ? () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => const GateWayScreen()),
                                (Route<dynamic> route) => false,
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
