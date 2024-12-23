import 'package:flutter/material.dart';
import 'package:dauys_remote/core/widget/app_scaffold.dart';
import 'package:dauys_remote/features/auth/widget/auth_top_panel.dart';
import 'package:dauys_remote/features/main/widget/top_spacer.dart';
import 'package:dauys_remote/api/api.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import '../../core/widget/app_button.dart';
import '../../core/widget/app_text_input.dart'; // Подключаем API

class MyDataScreen extends StatefulWidget {
  const MyDataScreen({
    super.key,
  });

  @override
  State<MyDataScreen> createState() => _MyDataScreenState();
}

class _MyDataScreenState extends State<MyDataScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _loginController;
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;

  bool _isSaving = false;
  bool _dataFetched = false;

  @override
  void initState() {
    super.initState();
    _loginController = TextEditingController();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _emailController = TextEditingController();
    _fetchUserData();
  }

  @override
  void dispose() {
    _loginController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _fetchUserData() async {
    try {
      final api = await Api.create();
      final user = await api.getUserSettings();

      setState(() {
        _phoneController.text = user.mobile ?? '';
        _nameController.text = user.username ?? '';
        _emailController.text = user.userMail ?? '';
        _dataFetched = true;
      });
    } catch (error) {
      print('Error fetching user data: $error');
    }
  }

  Future<void> _saveUserData() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      final api = await Api.create();
      await api.updateUserData(
        userMail: _emailController.text,
        mobile: _phoneController.text,
        username: _nameController.text,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(FlutterI18n.translate(context, "my_data.data_saved_successfully"))),
      );
    } catch (error) {
      print('Error saving user data: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(FlutterI18n.translate(context, "my_data.error_saving_data"))),
      );
    } finally {
      setState(() {
        _isSaving = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      safeAreaTop: false,
      disableBackgroundColorSpots: true,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            const TopSpacer(),
            AuthTopPanel(title: FlutterI18n.translate(context, "my_data.my_data"), screenId: 2,),
            const SizedBox(height: 30),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  AppTextInput(
                    controller: _nameController,
                    hintText: FlutterI18n.translate(context, "my_data.your_name"),
                    validator: null,
                  ),
                  const SizedBox(height: 10),
                  AppTextInput(
                    controller: _emailController,
                    hintText: FlutterI18n.translate(context, "my_data.email_address"),
                    validator: null,
                  ),
                  const SizedBox(height: 10),
                  AppTextInput(
                    controller: _phoneController,
                    hintText: FlutterI18n.translate(context, "my_data.phone_number"),
                    validator: null,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            AppButton(
              title: FlutterI18n.translate(context, "my_data.save"),
              width: 130,
              onTap: _isSaving || !_dataFetched ? null : _saveUserData,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label,
      TextEditingController controller,
      bool isEmail,
      ) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
      keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return FlutterI18n.translate(context, "my_data.field_cannot_be_empty");
        }
        return null;
      },
    );
  }
}
