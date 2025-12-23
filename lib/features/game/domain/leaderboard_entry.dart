import 'package:hive/hive.dart';

part 'leaderboard_entry.g.dart';

@HiveType(typeId: 4)
class LeaderboardEntry {
  @HiveField(0)
  final int score;

  @HiveField(1)
  final int totalQuestions;

  @HiveField(2)
  final DateTime date;

  LeaderboardEntry({
    required this.score,
    required this.totalQuestions,
    required this.date,
  });
}
