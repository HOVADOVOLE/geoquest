import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../../../i18n/strings.g.dart';
import '../presentation/user_profile_controller.dart';
import '../presentation/achievement_controller.dart';

/// Obrazovka uživatelského profilu.
///
/// **Účel:**
/// Zobrazuje statistiky hráče (level, XP, odehrané hry, streak) a seznam achievementů.
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  /// Vykreslí profil hráče.
  ///
  /// **Co dělá:**
  /// Načte data z `UserProfileController` a `AchievementController` a zobrazí je.
  /// Achievementy jsou vizuálně odlišeny (zamčené/odemčené).
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(userProfileControllerProvider);
    final achievements = ref.watch(achievementControllerProvider);
    final t = Translations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(t.profile.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // User Header
            ShadCard(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 40,
                      child: Icon(LucideIcons.user, size: 40),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      t.profile.level(level: profile.currentLevel), 
                      style: ShadTheme.of(context).textTheme.h2
                    ),
                    const SizedBox(height: 8),
                    Text(
                      t.profile.totalXp(xp: profile.totalXp), 
                      style: TextStyle(color: Colors.grey[600])
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStat(t.profile.gamesPlayed, profile.gamesPlayed.toString()),
                        _buildStat(t.profile.streak, t.profile.days(count: profile.streakDays)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(t.profile.achievements, style: ShadTheme.of(context).textTheme.h3),
            ),
            const SizedBox(height: 16),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: achievements.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final a = achievements[index];
                return ShadCard(
                  child: ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: a.isUnlocked ? Colors.amber.withValues(alpha: 0.2) : Colors.grey.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        a.isUnlocked ? LucideIcons.trophy : LucideIcons.lock,
                        color: a.isUnlocked ? Colors.amber : Colors.grey,
                      ),
                    ),
                    title: Text(a.title, style: TextStyle(fontWeight: FontWeight.bold, color: a.isUnlocked ? null : Colors.grey)),
                    subtitle: Text(a.description, style: TextStyle(fontSize: 12, color: a.isUnlocked ? null : Colors.grey)),
                    trailing: a.isUnlocked ? const Icon(Icons.check_circle, color: Colors.green, size: 16) : null,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Pomocná metoda pro zobrazení statistiky.
  Widget _buildStat(String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}
