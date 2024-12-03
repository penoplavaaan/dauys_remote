import 'package:dauys_remote/core/constants/app_icons.dart';
import 'package:dauys_remote/core/theme/app_gradients.dart';
import 'package:dauys_remote/features/gateway/widget/app_bottom_navigation_item.dart';
import 'package:flutter/material.dart';

class AppBottomNavigationBar extends StatefulWidget {
  const AppBottomNavigationBar({
    super.key,
    required this.onChange,
  });

  final void Function(int index) onChange;

  @override
  State<AppBottomNavigationBar> createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  int currentIndex = 0;

  void setIndex(int index) {
    setState(() {
      currentIndex = index;
    });
    widget.onChange(index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 84,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: AppGradients.darkGradient80,
      ),
      child: Row(
        children: [
          AppBottomNavigationItem(
            title: 'Главная',
            icon: AppIcons.home,
            isActive: currentIndex == 0,
            onTap: () => setIndex(0),
          ),
          AppBottomNavigationItem(
            title: 'Поиск',
            icon: AppIcons.search,
            isActive: currentIndex == 1,
            onTap: () => setIndex(1),
          ),
          AppBottomNavigationItem(
            title: 'Профиль',
            icon: AppIcons.profile,
            isActive: currentIndex == 2,
            onTap: () => setIndex(2),
          ),
        ],
      ),
    );
  }
}
