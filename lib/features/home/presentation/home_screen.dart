import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../../../i18n/strings.g.dart';
import '../../game/presentation/game_controller.dart';
import '../../game/presentation/game_screen.dart';
import '../../game/presentation/leaderboard_screen.dart';
import '../../settings/presentation/settings_controller.dart';

/// Hlavní obrazovka s menu.
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final isDarkMode = ref.watch(settingsControllerProvider);

    return Scaffold(
      body: Center(
        child: ShadCard(
          width: 300,
          title: Text(
            t.mainMenu.title,
            style: ShadTheme.of(context).textTheme.h1,
          ),
          description: const Text('Otestuj své znalosti světových vlajek!'),
          footer: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Tmavý režim'),
              ShadSwitch(
                value: isDarkMode,
                onChanged: (_) => ref
                    .read(settingsControllerProvider.notifier)
                    .toggleDarkMode(),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              ShadButton(
                width: double.infinity,
                enabled: !_isLoading,
                onPressed: () async {
                  setState(() => _isLoading = true);
                  // Spustíme hru a navigujeme na GameScreen
                  await ref.read(gameControllerProvider.notifier).startGame();
                  if (mounted) {
                    setState(() => _isLoading = false);
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const GameScreen()),
                    );
                  }
                },
                child: _isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(t.mainMenu.start),
              ),
              const SizedBox(height: 10),
              ShadButton.outline(
                width: double.infinity,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const LeaderboardScreen(),
                    ),
                  );
                },
                child: Text(t.mainMenu.leaderboard),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
