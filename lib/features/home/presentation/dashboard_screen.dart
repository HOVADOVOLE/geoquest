import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:lucide_icons/lucide_icons.dart' as lucide; // Použijeme alias pro jistotu
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../game/presentation/game_controller.dart';
import '../../game/presentation/game_screen.dart';
import '../../game/domain/quiz_config.dart';
import '../../profile/presentation/user_profile_controller.dart';
import '../../../i18n/strings.g.dart';

/// Hlavní obrazovka aplikace (Dashboard).
///
/// **Účel:**
/// Slouží jako rozcestník pro výběr herních módů a zobrazuje základní statistiky hráče (Level, Progress).
class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  bool _isLoading = false;

  /// Spustí hru se zadanou konfigurací.
  ///
  /// **Co dělá:**
  /// Nastaví `_isLoading` na true, zavolá `GameController.startGame` a po úspěšné inicializaci naviguje na `GameScreen`.
  ///
  /// **Vstupní parametry:**
  /// - `config`: Konfigurace hry (typ, region).
  ///
  /// **Interní logika:**
  /// 1. Zobrazí loading indikátor na kartě.
  /// 2. Počká na načtení dat (start game).
  /// 3. Přepne na herní obrazovku.
  Future<void> _startGame(QuizConfig config) async {
    setState(() => _isLoading = true);
    await ref.read(gameControllerProvider.notifier).startGame(config);
    if (mounted) {
      setState(() => _isLoading = false);
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const GameScreen()),
      );
    }
  }

  /// Zobrazí dialog pro výběr regionu.
  ///
  /// **Co dělá:**
  /// Otevře `ShadDialog` se seznamem dostupných regionů. Po výběru spustí hru filtrovanou na daný region.
  ///
  /// **Vstupní parametry:**
  /// - `context`: BuildContext pro zobrazení dialogu a načtení překladů.
  ///
  /// **Interní logika:**
  /// Využívá `QuizRegion.values` k vygenerování tlačítek. Názvy regionů jsou lokalizované.
  void _showRegionSelection(BuildContext context) {
    final t = Translations.of(context);
    
    showShadDialog(
      context: context,
      builder: (context) => ShadDialog(
        title: Text(t.dashboard.regionDialog.title),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            ...QuizRegion.values.where((r) => r != QuizRegion.world).map((region) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: ShadButton.outline(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _startGame(QuizConfig(
                      type: QuizType.flagToName, 
                      region: region,
                    ));
                  },
                  child: Text(_getRegionName(context, region)),
                ),
              );
            }),
          ],
        ),
        actions: [
          ShadButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(t.common.cancel),
          ),
        ],
      ),
    );
  }

  /// Převede enum `QuizRegion` na lokalizovaný název.
  String _getRegionName(BuildContext context, QuizRegion region) {
    final t = Translations.of(context);
    switch (region) {
      case QuizRegion.europe: return t.regions.europe;
      case QuizRegion.africa: return t.regions.africa;
      case QuizRegion.americas: return t.regions.americas;
      case QuizRegion.asia: return t.regions.asia;
      case QuizRegion.oceania: return t.regions.oceania;
      default: return t.regions.world;
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProfile = ref.watch(userProfileControllerProvider);
    final t = Translations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(t.appName),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Row(
              children: [
                SizedBox(
                  width: 80,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        t.dashboard.level(level: userProfile.currentLevel), 
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)
                      ),
                      const SizedBox(height: 2),
                      LinearProgressIndicator(
                        value: userProfile.levelProgress,
                        minHeight: 4,
                        backgroundColor: ShadTheme.of(context).colorScheme.secondary,
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.bolt, size: 20, color: Colors.amber),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(t.dashboard.gameModes, style: ShadTheme.of(context).textTheme.h3),
            SizedBox(height: 16.h),
            
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.9,
              children: [
                _buildGameModeCard(
                  context,
                  title: t.dashboard.cards.flags.title,
                  subtitle: t.dashboard.cards.flags.subtitle,
                  icon: lucide.LucideIcons.flag,
                  color: Colors.blueAccent,
                  onTap: () => _startGame(const QuizConfig(type: QuizType.flagToName)),
                  isLoading: _isLoading,
                ),
                _buildGameModeCard(
                  context,
                  title: t.dashboard.cards.capitals.title,
                  subtitle: t.dashboard.cards.capitals.subtitle,
                  icon: lucide.LucideIcons.building2,
                  color: Colors.orangeAccent,
                  onTap: () => _startGame(const QuizConfig(type: QuizType.capitalToName)),
                  isLoading: _isLoading,
                ),
                _buildGameModeCard(
                  context,
                  title: t.dashboard.cards.reverse.title,
                  subtitle: t.dashboard.cards.reverse.subtitle,
                  icon: lucide.LucideIcons.image,
                  color: Colors.purpleAccent,
                  onTap: () => _startGame(const QuizConfig(type: QuizType.nameToFlag)),
                  isLoading: _isLoading,
                ),
                _buildGameModeCard(
                  context,
                  title: t.dashboard.cards.regions.title,
                  subtitle: t.dashboard.cards.regions.subtitle,
                  icon: lucide.LucideIcons.globe,
                  color: Colors.green,
                  onTap: () => _showRegionSelection(context),
                  isLocked: false,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Vytvoří kartu herního módu.
  ///
  /// **Vstupní parametry:**
  /// - `title`: Název módu.
  /// - `subtitle`: Krátký popisek.
  /// - `icon`: Ikona módu.
  /// - `color`: Hlavní barva karty.
  /// - `onTap`: Akce po kliknutí.
  /// - `isLocked`: Zda je karta zamčená (default `false`).
  /// - `isLoading`: Zda se načítá (default `false`).
  Widget _buildGameModeCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    bool isLocked = false,
    bool isLoading = false,
  }) {
    return ShadCard(
      padding: EdgeInsets.zero,
      child: InkWell(
        onTap: isLocked || isLoading ? null : onTap,
        borderRadius: BorderRadius.circular(8),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(icon, size: 32, color: color),
                  ),
                  const Spacer(),
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(subtitle, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                ],
              ),
            ),
            if (isLocked)
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Icon(lucide.LucideIcons.lock, color: Colors.white),
                ),
              ),
            if (isLoading)
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
