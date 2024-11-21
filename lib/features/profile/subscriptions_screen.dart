import 'package:dauys_remote/core/theme/app_colors.dart';
import 'package:dauys_remote/core/theme/app_styles.dart';
import 'package:dauys_remote/core/widget/app_button.dart';
import 'package:dauys_remote/core/widget/app_scaffold.dart';
import 'package:dauys_remote/features/auth/widget/auth_top_panel.dart';
import 'package:dauys_remote/features/main/widget/top_spacer.dart';
import 'package:dauys_remote/features/profile/widget/subscription_card.dart';
import 'package:dauys_remote/features/profile/widget/subscription_ckecked_card.dart';
import 'package:flutter/material.dart';

class SubscriptionsScreen extends StatefulWidget {
  const SubscriptionsScreen({super.key});

  @override
  State<SubscriptionsScreen> createState() => _SubscriptionsScreenState();
}

class _SubscriptionsScreenState extends State<SubscriptionsScreen> {
  int selectedScubscription = 1;
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      safeAreaTop: false,
      disableBackgroundColorSpots: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TopSpacer(),
          const AuthTopPanel(title: 'Подписки'),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 50),
              children: [
                Text(
                  'Подписки',
                  style: AppStyles.magistral20w500.copyWith(color: AppColors.white),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    SubscriptionCard(
                      percent: 0,
                      noMonth: 1,
                      month: 'месяц',
                      price: 4500,
                      priceMonth: 4500,
                      isSelected: selectedScubscription == 0,
                      onTap: () {
                        setState(() {
                          selectedScubscription = 0;
                        });
                      },
                    ),
                    const SizedBox(width: 10),
                    SubscriptionCard(
                      percent: -45,
                      noMonth: 12,
                      month: 'месяцев',
                      price: 45000,
                      priceMonth: 4500,
                      isSelected: selectedScubscription == 1,
                      onTap: () {
                        setState(() {
                          selectedScubscription = 1;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Text(
                  'Что дает подписка?',
                  style: AppStyles.magistral16w500.copyWith(color: AppColors.white),
                ),
                const SizedBox(height: 15),
                SubscriptionCheckedCard(texts: [
                  Textt('Дополнительные ', TextType.normal),
                  Textt('скидки', TextType.bold),
                  Textt(' и ', TextType.normal),
                  Textt('бонусы', TextType.bold),
                ]),
                const SizedBox(height: 10),
                SubscriptionCheckedCard(texts: [
                  Textt('Расширенная ', TextType.bold),
                  Textt('библиотека песен', TextType.normal),
                ]),
                const SizedBox(height: 10),
                SubscriptionCheckedCard(texts: [
                  Textt('Без ', TextType.normal),
                  Textt('реклам', TextType.bold),
                ]),
                const SizedBox(height: 10),
                SubscriptionCheckedCard(texts: [
                  Textt('Создание плейлистов, запись и сохранение выступлений.', TextType.normal),
                ]),
                const SizedBox(height: 30),
                AppButton(
                  title: selectedScubscription == 0 ? 'Купить подписку на 1 месяц' : 'Купить подписку на 12 месяцев',
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
