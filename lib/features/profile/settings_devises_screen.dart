import 'package:dauys_remote/core/constants/app_icons.dart';
import 'package:dauys_remote/core/theme/app_colors.dart';
import 'package:dauys_remote/core/theme/app_styles.dart';
import 'package:dauys_remote/core/widget/app_scaffold.dart';
import 'package:dauys_remote/features/auth/widget/auth_top_panel.dart';
import 'package:dauys_remote/features/main/widget/top_spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SettingsDevisesScreen extends StatefulWidget {
  const SettingsDevisesScreen({
    super.key,
  });

  @override
  State<SettingsDevisesScreen> createState() => SettingsDevisesScreenState();
}

class SettingsDevisesScreenState extends State<SettingsDevisesScreen> {
  int selectedLanguage = 0;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      safeAreaTop: false,
      disableBackgroundColorSpots: true,
      body: Column(
        children: [
          const TopSpacer(),
          const AuthTopPanel(title: 'Подключенные устройства'),
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
              itemCount: 3,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () => setState(() {
                  selectedLanguage = index;
                }),
                behavior: HitTestBehavior.opaque,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  height: 60,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Dauys Karaoke Box',
                              style: AppStyles.magistral16w500.copyWith(color: AppColors.white),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'KB102242201911WW',
                              style: AppStyles.magistral12w400.copyWith(color: AppColors.white.withOpacity(.5)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Container(
                        height: 26,
                        width: 26,
                        decoration: BoxDecoration(
                          color: AppColors.white.withOpacity(.2),
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: Image.asset(
                          AppIcons.close,
                          height: 12,
                          width: 12,
                          color: AppColors.white,
                        ),
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
}
