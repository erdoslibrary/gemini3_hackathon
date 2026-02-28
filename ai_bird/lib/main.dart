import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';
import 'package:ai_bird/core/state.dart';
import 'package:ai_bird/core/theme.dart';
import 'package:ai_bird/features/mission_map/map_screen.dart';
import 'package:ai_bird/features/mission_runner/runner_screen.dart';
import 'package:ai_bird/features/shop/shop_screen.dart';

void main() {
  runApp(const AIBirdApp());
}

class AIBirdApp extends StatelessWidget {
  const AIBirdApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI-Bird',
      theme: AppTheme.lightTheme,
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Watch the current tab index from signals
    final activeTab = currentTabIndex.watch(context);

    final screens = [
      const MapScreen(),
      const RunnerScreen(),
      const ShopScreen(),
    ];

    return Scaffold(
      body: screens[activeTab],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: activeTab,
        onTap: (index) => currentTabIndex.value = index,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.map, size: 32), label: '지도'),
          BottomNavigationBarItem(icon: Icon(Icons.check_circle_outline, size: 32), label: '미션'),
          BottomNavigationBarItem(icon: Icon(Icons.store, size: 32), label: '상점'),
        ],
        selectedFontSize: 16,
        unselectedFontSize: 14,
      ),
    );
  }
}
