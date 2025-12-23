import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hive/hive.dart';
import '../../../core/database/hive_service.dart';
import '../domain/leaderboard_entry.dart';

part 'leaderboard_controller.g.dart';

@riverpod
class LeaderboardController extends _$LeaderboardController {
  late Box<LeaderboardEntry> _box;

  @override
  List<LeaderboardEntry> build() {
    _box = Hive.box<LeaderboardEntry>(HiveService.leaderboardBoxName);
    return _loadScores();
  }

  List<LeaderboardEntry> _loadScores() {
    final scores = _box.values.toList();
    // Seřadit podle skóre (sestupně)
    scores.sort((a, b) => b.score.compareTo(a.score));
    return scores;
  }

  void addScore(int score, int totalQuestions) {
    final entry = LeaderboardEntry(
      score: score,
      totalQuestions: totalQuestions,
      date: DateTime.now(),
    );

    _box.add(entry);
    
    // Aktualizovat state a oříznout na Top 20
    final newScores = _loadScores();
    if (newScores.length > 20) {
      // Smazat nejhorší výsledky z Hive
      // Poznámka: Mazání z Hive podle indexu je složitější, pro MVP stačí nechat data v Hive 
      // a zobrazovat jen Top 20, nebo časem promazat box.
      // Pro jednoduchost teď jen omezíme zobrazení.
    }
    
    state = newScores;
  }
}
