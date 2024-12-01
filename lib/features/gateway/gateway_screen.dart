import 'package:dauys_remote/core/widget/app_scaffold.dart';
import 'package:dauys_remote/features/gateway/widget/app_bottom_navigation_bar.dart';
import 'package:dauys_remote/features/main/main_screen.dart';
import 'package:dauys_remote/features/profile/profile_screen.dart';
import 'package:flutter/material.dart';

import '../auth/auth_geateway_screen.dart';
import '../search/search_screen.dart';

class GateWayScreen extends StatefulWidget {
  const GateWayScreen({
    super.key,
  });

  @override
  State<GateWayScreen> createState() => _GateWayScreenState();
}

class _GateWayScreenState extends State<GateWayScreen> {
  int currentIndex = 0;

  final _keys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];
  final _pages = const [
    MainScreen(),
    SearchScreen(),
    ProfileScreen(),
    AuthGeatewayScreen(),
  ];

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
              child: IndexedStack(
                index: currentIndex,
                children: List.generate(
                  _keys.length,
                      (index) => Navigator(
                    key: _keys[index],
                    onGenerateRoute: (settings) => MaterialPageRoute(
                      builder: (context) => _pages[index],
                    ),
                  ),
                ),
              ),
            ),
            AppBottomNavigationBar(
              onChange: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
