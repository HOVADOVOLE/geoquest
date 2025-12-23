import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/countries_repository.dart';
import '../domain/country.dart';
import '../domain/game_logic.dart';
import '../domain/game_session.dart';
import '../domain/quiz_config.dart';
import 'leaderboard_controller.dart';
import '../../profile/presentation/user_profile_controller.dart';
import '../../profile/presentation/achievement_controller.dart';

part 'game_controller.g.dart';

/// Controller spravující stav a logiku aktuálně běžící hry.
///
/// **Účel:**
/// Slouží jako centrální bod pro řízení herní relace (GameSession). Spravuje časovač,
/// vyhodnocuje odpovědi, počítá skóre a komunikuje s ostatními controllery (Leaderboard, Profile).
@Riverpod(keepAlive: true)
class GameController extends _$GameController {
  final _logic = GameLogic();
  Timer? _timer;
  QuizConfig _currentConfig = const QuizConfig();

  QuizConfig get currentConfig => _currentConfig;

  @override
  AsyncValue<GameSession> build() {
    ref.onDispose(() => _timer?.cancel());
    // Na začátku je stav neaktivní (loading).
    return const AsyncValue.loading();
  }

  /// Spustí novou hru s danou konfigurací.
  ///
  /// **Co dělá:**
  /// Resetuje stav, načte země z repozitáře (filtrované podle regionu), vygeneruje otázky pomocí `GameLogic` a spustí časovač.
  ///
  /// **Vstupní parametry:**
  /// - `config`: Konfigurace kvízu (typ hry, region, počet otázek). Defaultně `QuizConfig()`.
  ///
  /// **Výstupní parametry:**
  /// - `Future<void>`: Asynchronní operace bez návratové hodnoty.
  ///
  /// **Interní logika:**
  /// 1. Nastaví stav na `loading`.
  /// 2. Získá seznam zemí (filtrovaný) z `CountriesRepository`.
  /// 3. Vygeneruje otázky.
  /// 4. Inicializuje `GameSession` s časem 60s.
  /// 5. Zavolá `_startTimer()`.
  ///
  /// **Známé problémy:**
  /// Pokud API/Cache vrátí prázdný seznam, hra skončí chybou.
  Future<void> startGame([QuizConfig config = const QuizConfig()]) async {
    print('GameController: Starting game with type: ${config.type}');
    _currentConfig = config;
    state = const AsyncValue.loading();
    _timer?.cancel();
    
    try {
      final repository = ref.read(countriesRepositoryProvider.notifier);
      // Získáme země filtrované podle vybraného regionu už na úrovni repozitáře
      final availableCountries = await repository.getCountriesByRegion(config.region);
      final questions = _logic.generateQuestions(availableCountries, config);
      
      const initialTime = 60;
      state = AsyncValue.data(GameSession(
        questions: questions,
        timeLeft: initialTime,
        totalTime: initialTime,
      ));

      _startTimer();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Ukončí hru a uloží výsledky.
  ///
  /// **Co dělá:**
  /// Zastaví časovač, označí session jako `isFinished`, a zapíše skóre do žebříčku a profilu hráče.
  ///
  /// **Vstupní parametry:**
  /// - `session`: Aktuální (poslední) stav herní relace.
  ///
  /// **Interní logika:**
  /// 1. Zruší časovač.
  /// 2. Uloží výsledek do `LeaderboardController`.
  /// 3. Vypočítá XP (10 za otázku + 50 bonus za 100% + zbývající čas) a pošle do `UserProfileController`.
  /// 4. Zkontroluje achievementy přes `AchievementController` a uloží nově získané do stavu hry.
  void _finishGame(GameSession session) {
    _timer?.cancel();
    
    // 1. Save to Leaderboard
    ref.read(leaderboardControllerProvider.notifier).addScore(
      session.score, 
      session.questions.length
    );

    // 2. Calculate and award XP
    int xp = session.score * 10;
    if (session.score == session.questions.length) xp += 50;
    xp += session.timeLeft;
    ref.read(userProfileControllerProvider.notifier).addExperience(xp);

    // 3. Check Achievements
    final totalGames = ref.read(userProfileControllerProvider).gamesPlayed;
    final newAchievements = ref.read(achievementControllerProvider.notifier)
        .checkAchievements(session, totalGames);

    // 4. Update state (Finished + Achievements)
    state = AsyncValue.data(session.copyWith(
      isFinished: true,
      newlyUnlockedAchievements: newAchievements,
    ));
  }

  /// Spustí odpočet času.
  ///
  /// **Co dělá:**
  /// Každou sekundu sníží `timeLeft` o 1. Pokud čas vyprší, ukončí hru.
  ///
  /// **Interní logika:**
  /// Používá `Timer.periodic`. Při každém tiknutí zkontroluje, zda hra neskončila.
  /// Pokud `timeLeft <= 0`, volá `_finishGame`.
  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final currentSession = state.value;
      if (currentSession == null || currentSession.isFinished) {
        timer.cancel();
        return;
      }
      final newTime = currentSession.timeLeft - 1;
      if (newTime <= 0) {
        _finishGame(currentSession.copyWith(timeLeft: 0));
      } else {
        state = AsyncValue.data(currentSession.copyWith(timeLeft: newTime));
      }
    });
  }

  /// Zpracuje odpověď uživatele.
  ///
  /// **Co dělá:**
  /// Porovná vybranou zemi s cílovou zemí. Aktualizuje skóre a posune hru na další otázku.
  ///
  /// **Vstupní parametry:**
  /// - `answer`: Země, kterou uživatel vybral.
  ///
  /// **Interní logika:**
  /// 1. Zjistí, zda je odpověď správná (porovnání `cca3`).
  /// 2. Inkrementuje `currentQuestionIndex`.
  /// 3. Pokud je to poslední otázka, volá `_finishGame`.
  /// 4. Jinak aktualizuje stav s novým skóre a indexem.
  void submitAnswer(Country answer) {
    final currentSession = state.value;
    if (currentSession == null || currentSession.isFinished) return;

    final target = currentSession.questions[currentSession.currentQuestionIndex];
    final isCorrect = answer.cca3 == target.cca3;

    final nextIndex = currentSession.currentQuestionIndex + 1;
    final isFinished = nextIndex >= currentSession.questions.length;

    final updatedSession = currentSession.copyWith(
      score: isCorrect ? currentSession.score + 1 : currentSession.score,
      currentQuestionIndex: isFinished ? currentSession.currentQuestionIndex : nextIndex,
    );

    if (isFinished) {
      _finishGame(updatedSession);
    } else {
      state = AsyncValue.data(updatedSession);
    }
  }
  
  /// Získá možnosti odpovědí pro aktuální otázku.
  ///
  /// **Co dělá:**
  /// Vrátí seznam zemí (zpravidla 4), které se zobrazí jako tlačítka. Obsahuje správnou odpověď a náhodné "decoys".
  ///
  /// **Výstupní parametry:**
  /// - `Future<List<Country>>`: Seznam 4 zemí.
  ///
  /// **Interní logika:**
  /// Volá `_logic.getOptions` s aktuální cílovou zemí a poolu zemí (stejný region).
  Future<List<Country>> getCurrentOptions() async {
    final currentSession = state.value;
    if (currentSession == null) return [];
    // Použijeme stejný pool (region) jako pro otázky, aby byly možnosti relevantní
    final pool = await ref.read(countriesRepositoryProvider.notifier)
        .getCountriesByRegion(_currentConfig.region);
    final target = currentSession.questions[currentSession.currentQuestionIndex];
    return _logic.getOptions(pool, target, _currentConfig.type);
  }
}