import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'settings_controller.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Nastavení')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ShadCard(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Tmavý režim', style: TextStyle(fontSize: 16)),
                    ShadSwitch(
                      value: isDarkMode,
                      onChanged: (_) => ref.read(settingsControllerProvider.notifier).toggleDarkMode(),
                    ),
                  ],
                ),
              ),
            ),
            // Zde časem přibude výběr jazyka, zvuky, atd.
          ],
        ),
      ),
    );
  }
}
