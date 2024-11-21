import 'package:dauys_remote/core/constants/app_icons.dart';
import 'package:dauys_remote/core/constants/app_svg.dart';
import 'package:dauys_remote/core/theme/app_colors.dart';
import 'package:dauys_remote/core/theme/app_styles.dart';
import 'package:dauys_remote/core/widget/app_radio_icon.dart';
import 'package:dauys_remote/core/widget/app_scaffold.dart';
import 'package:dauys_remote/features/auth/widget/auth_top_panel.dart';
import 'package:dauys_remote/features/main/widget/top_spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

List<Map<String, dynamic>> _cards = [
  {
    'icon': AppIcons.visa,
    'title': '**** 4335',
  },
  {
    'icon': AppIcons.applePay,
    'title': 'Apple Pay',
  },
];

class PaymentsScreen extends StatefulWidget {
  const PaymentsScreen({
    super.key,
  });

  @override
  State<PaymentsScreen> createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
  int selectedCard = 0;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      safeAreaTop: false,
      disableBackgroundColorSpots: true,
      body: Column(
        children: [
          const TopSpacer(),
          const AuthTopPanel(title: 'Платежи'),
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GestureDetector(
              onTap: () {},
              behavior: HitTestBehavior.opaque,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AppSvg.plusIcon,
                      height: 20,
                      width: 20,
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        'Добавить банковскую карту',
                        style: AppStyles.magistral16w500.copyWith(color: AppColors.white),
                      ),
                    ),
                    const SizedBox(width: 14),
                    const Icon(
                      Icons.chevron_right,
                      color: AppColors.white,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'ВАШИ КАРТЫ',
            style: AppStyles.magistral14w400.copyWith(color: AppColors.white.withOpacity(.6)),
          ),
          const SizedBox(height: 7),
          Flexible(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListView.separated(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _cards.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCard = index;
                    });
                  },
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Image.asset(
                          _cards[index]['icon'],
                          height: 20,
                          width: 47,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            _cards[index]['title'],
                            style: AppStyles.magistral16w500.copyWith(color: AppColors.white),
                          ),
                        ),
                        const SizedBox(width: 16),
                        AppRadioIcon(isActive: selectedCard == index),
                      ],
                    ),
                  ),
                ),
                separatorBuilder: (_, __) => Container(
                  width: double.infinity,
                  height: 1,
                  margin: const EdgeInsets.only(left: 20),
                  color: AppColors.white.withOpacity(.2),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
