import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'dashboard_screen.dart';
import '../../profile/presentation/profile_screen.dart';
import '../../settings/presentation/settings_screen.dart';
import '../../encyclopedia/presentation/encyclopedia_screen.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const EncyclopediaScreen(),
    const ProfileScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: ShadTheme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(LucideIcons.gamepad2),
            label: 'Hra',
          ),
          BottomNavigationBarItem(
            icon: Icon(LucideIcons.bookOpen),
            label: 'Atlas',
          ),
          BottomNavigationBarItem(
            icon: Icon(LucideIcons.user),
            label: 'Profil',
          ),
          BottomNavigationBarItem(
            icon: Icon(LucideIcons.settings),
            label: 'Nastavení',
          ),
        ],
      ),
    );
  }
}