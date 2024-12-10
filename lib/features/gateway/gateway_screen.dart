import 'package:dauys_remote/core/widget/app_scaffold.dart';
import 'package:dauys_remote/features/gateway/widget/app_bottom_navigation_bar.dart';
import 'package:dauys_remote/features/main/main_screen.dart';
import 'package:dauys_remote/features/profile/profile_screen.dart';
import 'package:flutter/material.dart';

import '../search/search_screen.dart';

class GateWayScreen extends StatefulWidget {
  const GateWayScreen({
    super.key,
    this.index = 0
  });

  final int index;

  @override
  State<GateWayScreen> createState() => _GateWayScreenState();
}

class _GateWayScreenState extends State<GateWayScreen> {
  int currentIndex = 0;

  final _keys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  final List<Widget Function()> _pageBuilders = [
        () => const MainScreen(),
        () => const SearchScreen(),
        () => const ProfileScreen(),
  ];

  @override
  void initState() {
    currentIndex = widget.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async {
        return !await _keys[currentIndex].currentState!.maybePop();
      },
      child: AppScaffold(
        safeAreaTop: false,
        body: Column(
          children: [
            Expanded(
              child: _pageBuilders[currentIndex]()
            ),
            AppBottomNavigationBar(
              onChange: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              currentIndex: currentIndex,
            ),
          ],
        ),
      ),
    );
  }
}
