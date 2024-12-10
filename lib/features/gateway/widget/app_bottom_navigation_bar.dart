import 'package:dauys_remote/core/constants/app_icons.dart';
import 'package:dauys_remote/core/theme/app_gradients.dart';
import 'package:dauys_remote/features/gateway/widget/app_bottom_navigation_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class AppBottomNavigationBar extends StatefulWidget {
  const AppBottomNavigationBar({
    super.key,
    required this.onChange,
    required this.currentIndex,
  });

  final void Function(int index) onChange;
  final int currentIndex;

  @override
  State<AppBottomNavigationBar> createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  int currentIndex = 0;

  @override
  void initState() {
    currentIndex = widget.currentIndex;
    super.initState();
  }

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
            title: FlutterI18n.translate(context, "bottom_navigation.home"), // заменено
            icon: AppIcons.home,
            isActive: currentIndex == 0,
            onTap: () => setIndex(0),
          ),
          AppBottomNavigationItem(
            title: FlutterI18n.translate(context, "bottom_navigation.search"), // заменено
            icon: AppIcons.search,
            isActive: currentIndex == 1,
            onTap: () => setIndex(1),
          ),
          AppBottomNavigationItem(
            title: FlutterI18n.translate(context, "bottom_navigation.profile"), // заменено
            icon: AppIcons.profile,
            isActive: currentIndex == 2,
            onTap: () => setIndex(2),
          ),
        ],
      ),
    );
  }
}
