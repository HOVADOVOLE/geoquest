import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hive/hive.dart';
import '../../../core/database/hive_service.dart';
import '../domain/achievement.dart';
import '../../game/domain/game_session.dart';

part 'achievement_controller.g.dart';

/// Controller spravující achievementy (úspěchy).
///
/// **Účel:**
/// Ukládá stav achievementů do Hive, inicializuje výchozí hodnoty a kontroluje podmínky pro jejich odemčení.
@riverpod
class AchievementController extends _$AchievementController {
  late Box<Achievement> _box;
  // ignore: unused_field
  static const String _boxName = 'achievementsBox';

  @override
  List<Achievement> build() {
    _box = Hive.box<Achievement>(HiveService.achievementsBoxName);
    if (_box.isEmpty) {
      _initDefaultAchievements();
    }
    return _box.values.toList();
  }

  void _initDefaultAchievements() {
    final defaults = [
      const Achievement(id: 'first_game', title: 'První krůčky', description: 'Odehraj svou první hru.'),
      const Achievement(id: 'perfect_score', title: 'Sniper', description: 'Získej 10/10 bodů v jedné hře.'),
      const Achievement(id: 'speedster', title: 'Rychlík', description: 'Dokonči hru s více než 30 sekundami k dobru.'),
      const Achievement(id: 'veteran', title: 'Zkušený cestovatel', description: 'Odehraj celkem 10 her.'),
    ];
    for (var a in defaults) {
      _box.put(a.id, a);
    }
  }

  /// Zkontroluje podmínky pro splnění achievementů po ukončení hry.
  ///
  /// **Co dělá:**
  /// Projde pravidla (počet her, skóre, čas) a pokud je podmínka splněna a achievement ještě nebyl odemčen,
  /// odemkne ho a uloží do databáze.
  ///
  /// **Vstupní parametry:**
  /// - `session`: Data o právě ukončené hře.
  /// - `totalGamesPlayed`: Celkový počet odehraných her (včetně této).
  ///
  /// **Výstupní parametry:**
  /// - `List<Achievement>`: Seznam právě odemčených achievementů (pro notifikace).
  List<Achievement> checkAchievements(GameSession session, int totalGamesPlayed) {
    final newUnlocks = <Achievement>[];
    bool changed = false;

    void unlock(String id) {
      final a = _box.get(id);
      if (a != null && !a.isUnlocked) {
        final unlocked = a.copyWith(isUnlocked: true, unlockedAt: DateTime.now());
        _box.put(id, unlocked);
        newUnlocks.add(unlocked);
        changed = true;
      }
    }

    // 1. První hra
    if (totalGamesPlayed >= 1) unlock('first_game');

    // 2. Perfektní skóre
    if (session.score == session.questions.length) unlock('perfect_score');

    // 3. Rychlík
    if (session.timeLeft > 30 && session.isFinished) unlock('speedster');

    // 4. Veteran
    if (totalGamesPlayed >= 10) unlock('veteran');

    if (changed) {
      state = _box.values.toList();
    }
    
    return newUnlocks;
  }
}
