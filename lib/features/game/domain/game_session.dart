import 'package:json_annotation/json_annotation.dart';
import 'country.dart';
import '../../profile/domain/achievement.dart';

part 'game_session.g.dart';

/// Model reprezentující stav jedné herní relace.
///
/// **Účel:**
/// Drží data o právě probíhající hře (otázky, skóre, čas, stav dokončení).
@JsonSerializable()
class GameSession {
  final List<Country> questions;
  final int currentQuestionIndex;
  final int score;
  final bool isFinished;
  final int timeLeft; // Zbývající čas v sekundách
  final int totalTime; // Celkový čas na začátku (pro progress bar)
  
  /// Seznam achievementů odemčených v této hře (pro zobrazení notifikace na konci).
  /// Není součástí JSON serializace, protože slouží jen pro UI efekt.
  @JsonKey(includeFromJson: false, includeToJson: false)
  final List<Achievement> newlyUnlockedAchievements;

  GameSession({
    required this.questions,
    this.currentQuestionIndex = 0,
    this.score = 0,
    this.isFinished = false,
    this.timeLeft = 30, // Default 30 sekund
    this.totalTime = 30,
    this.newlyUnlockedAchievements = const [],
  });

  factory GameSession.fromJson(Map<String, dynamic> json) => _$GameSessionFromJson(json);
  Map<String, dynamic> toJson() => _$GameSessionToJson(this);
  
  GameSession copyWith({
    List<Country>? questions,
    int? currentQuestionIndex,
    int? score,
    bool? isFinished,
    int? timeLeft,
    int? totalTime,
    List<Achievement>? newlyUnlockedAchievements,
  }) {
    return GameSession(
      questions: questions ?? this.questions,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      score: score ?? this.score,
      isFinished: isFinished ?? this.isFinished,
      timeLeft: timeLeft ?? this.timeLeft,
      totalTime: totalTime ?? this.totalTime,
      newlyUnlockedAchievements: newlyUnlockedAchievements ?? this.newlyUnlockedAchievements,
    );
  }
}
