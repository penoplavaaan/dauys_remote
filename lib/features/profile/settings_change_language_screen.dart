import 'package:dauys_remote/core/theme/app_colors.dart';
import 'package:dauys_remote/core/theme/app_styles.dart';
import 'package:dauys_remote/core/widget/app_radio_icon.dart';
import 'package:dauys_remote/core/widget/app_scaffold.dart';
import 'package:dauys_remote/features/auth/widget/auth_top_panel.dart';
import 'package:dauys_remote/features/main/widget/top_spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import '../../storage/local_storage.dart';
import '../gateway/gateway_screen.dart';

class SettingsChangeLanguageScreen extends StatefulWidget {
  const SettingsChangeLanguageScreen({
    super.key,
  });

  @override
  State<SettingsChangeLanguageScreen> createState() => SettingsChangeLanguageScreenState();
}

class SettingsChangeLanguageScreenState extends State<SettingsChangeLanguageScreen> {
  LocalStorage storage = LocalStorage();
  List<String> languages = [
    'Русский',
    'Қазақша',
    'English',
  ];

  int selectedLanguage = 0;

  @override
  Widget build(BuildContext context) {
    String lang = FlutterI18n.currentLocale(context)?.languageCode ?? 'ru';
    setState(() {
      switch (lang) {
        case 'ru':
          selectedLanguage = 0;
          break;
        case 'kk':
          selectedLanguage = 1;
          break;
        case 'en':
          selectedLanguage = 2;
          break;
        default:
          selectedLanguage = 0;
          break;
      }
    });
    return AppScaffold(
      safeAreaTop: false,
      disableBackgroundColorSpots: true,
      body: Column(
        children: [
          const TopSpacer(),
          const AuthTopPanel(title: 'Сменить язык'),
          const SizedBox(height: 50),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: AppColors.white.withOpacity(.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListView.separated(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: languages.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () async {
                  setState(() {
                    selectedLanguage = index;
                  });

                  if(index == 0){
                    await _changeLanguage(const Locale('ru'));
                  }
                  if(index == 1){
                    await _changeLanguage(const Locale('kk'));
                  }
                  if(index == 2){
                    await _changeLanguage(const Locale('en'));
                  }

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const GateWayScreen(index: 2,)),
                  );
                },
                behavior: HitTestBehavior.opaque,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  height: 60,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          languages[index],
                          style: AppStyles.magistral16w500.copyWith(color: AppColors.white),
                        ),
                      ),
                      const SizedBox(width: 16),
                      AppRadioIcon(
                        isActive: selectedLanguage == index,
                      ),
                    ],
                  ),
                ),
              ),
              separatorBuilder: (_, __) => Container(
                height: 1,
                width: double.infinity,
                margin: const EdgeInsets.only(left: 20),
                color: AppColors.white.withOpacity(.2),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _changeLanguage(Locale locale) async {
    FlutterI18n.refresh(context, locale);
    return await storage.setLocale(locale.languageCode);
  }
}
