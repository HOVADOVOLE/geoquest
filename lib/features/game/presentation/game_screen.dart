import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:confetti/confetti.dart';
import '../../../i18n/strings.g.dart';
import '../domain/country.dart';
import '../domain/game_session.dart';
import '../domain/quiz_config.dart';
import '../../profile/domain/achievement.dart';
import 'game_controller.dart';

/// Hlavní herní obrazovka.
///
/// **Účel:**
/// Zobrazuje aktuální herní stav, otázku, možnosti odpovědí a výsledky.
/// Zajišťuje interakci uživatele s hrou (klikání na odpovědi).
class GameScreen extends ConsumerStatefulWidget {
  const GameScreen({super.key});

  @override
  ConsumerState<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {
  List<Country>? _options;
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 3),
    );
    _loadOptions();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  /// Načte možnosti odpovědí pro aktuální otázku.
  ///
  /// **Co dělá:**
  /// Asynchronně získá seznam zemí (odpovědí) z `GameController` a aktualizuje stav widgetu.
  ///
  /// **Interní logika:**
  /// Volá `gameControllerProvider.notifier.getCurrentOptions()`.
  /// Pokud je widget stále aktivní (mounted), nastaví `_options`.
  Future<void> _loadOptions() async {
    final options = await ref
        .read(gameControllerProvider.notifier)
        .getCurrentOptions();
    if (mounted) setState(() => _options = options);
  }

  /// Zpracuje výběr odpovědi uživatelem.
  ///
  /// **Co dělá:**
  /// Spustí haptickou odezvu (vibrace), odešle odpověď do controlleru a načte nové možnosti pro další otázku.
  ///
  /// **Vstupní parametry:**
  /// - `option`: Vybraná země.
  /// - `isCorrect`: Příznak, zda je odpověď správná (pro haptiku).
  ///
  /// **Interní logika:**
  /// 1. Zavolá `HapticFeedback.lightImpact` (správně) nebo `heavyImpact` (špatně).
  /// 2. Zavolá `submitAnswer` na controlleru.
  /// 3. Zavolá `_loadOptions` pro přípravu dalšího kola.
  void _handleAnswer(Country option, bool isCorrect) {
    if (isCorrect) {
      HapticFeedback.lightImpact();
    } else {
      HapticFeedback.heavyImpact();
    }

    ref.read(gameControllerProvider.notifier).submitAnswer(option);
    _loadOptions();
  }

  /// Vykreslí UI herní obrazovky.
  ///
  /// **Co dělá:**
  /// Reaguje na stav hry (loading, error, data).
  /// Zobrazuje hlavičku se skóre a časem, progress bar a samotnou herní plochu (otázka + odpovědi).
  @override
  Widget build(BuildContext context) {
    final gameState = ref.watch(gameControllerProvider);
    final quizType = ref
        .read(gameControllerProvider.notifier)
        .currentConfig
        .type;
    final t = Translations.of(context);

    ref.listen<AsyncValue<GameSession>>(gameControllerProvider, (prev, next) {
      next.whenData((session) {
        if (session.isFinished && session.newlyUnlockedAchievements.isNotEmpty) {
          final prevSession = prev?.valueOrNull;
          // Zobrazit pouze pokud předchozí stav nebyl dokončený (aby se to neopakovalo)
          if (prevSession == null || !prevSession.isFinished) {
            for (var achievement in session.newlyUnlockedAchievements) {
              ShadToaster.of(context).show(
                ShadToast(
                  title: Row(
                    children: [
                      const Icon(LucideIcons.trophy, color: Colors.amber, size: 20),
                      const SizedBox(width: 8),
                      Text(t.game.achievementUnlocked),
                    ],
                  ),
                  description: Text(achievement.title),
                ),
              );
            }
          }
        }
      });
    });

    return gameState.when(
      loading: () =>
          Scaffold(body: Center(child: Text(t.common.loading))),
      error: (err, stack) => Scaffold(body: Center(child: Text(t.common.error(error: err)))),
      data: (session) {
        if (session.isFinished) {
          if (session.score > session.questions.length / 2) {
            _confettiController.play();
          }
          return _buildResultScreen(context, session, t);
        }

        final currentQuestion = session.questions[session.currentQuestionIndex];
        final progress = session.timeLeft / session.totalTime;

        return Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${t.game.score}: ${session.score}'),
                Text(
                  t.game.timer(time: session.timeLeft),
                  style: TextStyle(
                    color: session.timeLeft < 10 ? Colors.red : null,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            automaticallyImplyLeading: false,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(4),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey[300],
                color: session.timeLeft < 10 ? Colors.red : Colors.green,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(
                  t.game.progress(
                    current: session.currentQuestionIndex + 1, 
                    total: session.questions.length
                  ),
                  style: ShadTheme.of(context).textTheme.large,
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ShadCard(
                    padding: const EdgeInsets.all(16),
                    child: Center(
                      child: _buildQuestionContent(
                        context,
                        currentQuestion,
                        quizType,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                if (_options != null)
                  GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: quizType == QuizType.nameToFlag
                        ? 1.2
                        : 1.5,
                    children: _options!
                        .map(
                          (option) => _buildOptionButton(
                            context,
                            option,
                            currentQuestion,
                            quizType,
                          ),
                        )
                        .toList(),
                  )
                else
                  const Center(child: CircularProgressIndicator()),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Vytvoří vizuální obsah otázky podle typu kvízu.
  ///
  /// **Co dělá:**
  /// Vrací widget (obrázek vlajky, text hlavního města nebo název země) podle `QuizType`.
  ///
  /// **Vstupní parametry:**
  /// - `country`: Cílová země.
  /// - `type`: Typ aktuálního kvízu.
  ///
  /// **Interní logika:**
  /// - `flagToName`: Zobrazí SVG vlajku.
  /// - `capitalToName`: Zobrazí název hlavního města (lokalizovaný dotaz).
  /// - `nameToFlag`: Zobrazí název země.
  Widget _buildQuestionContent(
    BuildContext context,
    Country country,
    QuizType type,
  ) {
    final t = Translations.of(context);
    switch (type) {
      case QuizType.flagToName:
        return AspectRatio(
          aspectRatio: 5 / 3,
          child: SvgPicture.network(country.flags.svg, fit: BoxFit.contain),
        ).animate(key: ValueKey(country.cca3)).fadeIn().scale();
      case QuizType.capitalToName:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              t.game.questionCapital,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              (country.capital?.isNotEmpty == true) 
                  ? country.capital!.first 
                  : t.game.unknownCapital,
              style: ShadTheme.of(context).textTheme.h2,
              textAlign: TextAlign.center,
            ),
          ],
        ).animate(key: ValueKey(country.cca3)).fadeIn().slideX();
      case QuizType.nameToFlag:
      case QuizType.nameToCapital:
        return Text(
          country.translations['ces']?.common ?? country.name.common,
          style: ShadTheme.of(context).textTheme.h1,
          textAlign: TextAlign.center,
        ).animate(key: ValueKey(country.cca3)).fadeIn().scale();
    }
  }

  /// Vytvoří tlačítko pro jednu možnost odpovědi.
  ///
  /// **Co dělá:**
  /// Vykreslí interaktivní kartu s odpovědí (text nebo vlajka).
  ///
  /// **Interní logika:**
  /// - Pokud `nameToFlag`, zobrazí vlajku.
  /// - Jinak zobrazí text (název země nebo města).
  /// - Po kliknutí zavolá `_handleAnswer`.
  Widget _buildOptionButton(
    BuildContext context,
    Country option,
    Country target,
    QuizType type,
  ) {
    final t = Translations.of(context);
    final isCorrect = option.cca3 == target.cca3;

    Widget content;
    if (type == QuizType.nameToFlag) {
      content = SvgPicture.network(option.flags.svg, fit: BoxFit.contain);
    } else if (type == QuizType.nameToCapital) {
      content = Text(
        (option.capital?.isNotEmpty == true) 
            ? option.capital!.first 
            : t.game.unknownCapital,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 12),
      );
    } else {
      content = Text(
        option.translations['ces']?.common ?? option.name.common,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 12),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: ShadTheme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: ShadTheme.of(context).colorScheme.border),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () => _handleAnswer(option, isCorrect),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: content),
          ),
        ),
      ),
    ).animate().fade().slideY(begin: 0.2, end: 0);
  }

  /// Vytvoří obrazovku s výsledky hry.
  ///
  /// **Co dělá:**
  /// Zobrazí finální skóre, získané XP a tlačítko pro návrat.
  /// Pokud hráč vyhrál, zobrazí konfety.
  Widget _buildResultScreen(BuildContext context, GameSession session, Translations t) {
    // Vypočítat XP pro zobrazení (stejná logika jako v controlleru)
    int xp = session.score * 10;
    if (session.score == session.questions.length) xp += 50;
    xp += session.timeLeft;

    return Stack(
      children: [
        Scaffold(
          body: Center(
            child: ShadCard(
              title: Text(t.game.gameOver.title),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    t.game.gameOver.scoreText(
                      score: session.score, 
                      total: session.questions.length
                    ),
                    style: ShadTheme.of(context).textTheme.h2,
                  ).animate().scale(),
                  const SizedBox(height: 10),
                  Text(
                    t.game.gameOver.xpEarned(xp: xp),
                    style: const TextStyle(
                      color: Colors.amber,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ).animate(delay: 500.ms).fadeIn().slideY(begin: 0.5, end: 0),
                  const SizedBox(height: 10),
                  if (session.timeLeft == 0)
                    Text(
                      t.game.gameOver.timeOut,
                      style: const TextStyle(color: Colors.red),
                    ),
                  const SizedBox(height: 20),
                  ShadButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(t.game.gameOver.backToMenu),
                  ),
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive,
          ),
        ),
      ],
    );
  }
}
