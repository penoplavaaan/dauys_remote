import 'package:dauys_remote/api/api.dart';
import 'package:dauys_remote/core/widget/app_button.dart';
import 'package:dauys_remote/core/widget/app_scaffold.dart';
import 'package:dauys_remote/core/widget/app_text_input.dart';
import 'package:dauys_remote/features/auth/widget/auth_top_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import '../profile/my_playlists_screen.dart';

class NewPlaylistScreen extends StatefulWidget {
  const NewPlaylistScreen({super.key});

  @override
  State<NewPlaylistScreen> createState() => _NewPlaylistScreenState();
}

class _NewPlaylistScreenState extends State<NewPlaylistScreen> {
  final controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isFormValid = false;

  void onChanged() {
    setState(() {
      isFormValid = _formKey.currentState?.validate() ?? false;
    });
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) return FlutterI18n.translate(context, "new_playlist.empty_name"); // заменено

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Column(
        children: [
          AuthTopPanel(title: FlutterI18n.translate(context, "new_playlist.title")), // заменено
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
                      hintText: FlutterI18n.translate(context, "new_playlist.hint"), // заменено
                      validator: validateName,
                    ),
                    const SizedBox(height: 30),
                    AppButton(
                      title: FlutterI18n.translate(context, "new_playlist.next"), // заменено
                      width: 130,
                      onTap: isFormValid
                          ? () {
                        Api.create().then((api) {
                          api.createNewPlaylist(controller.text).then((res) {
                            if (res == true) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const MyPlaylistsScreen()),
                              );
                            }
                          });
                        });
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
