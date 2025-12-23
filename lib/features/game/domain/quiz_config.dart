enum QuizType {
  flagToName,    // Classic: See flag, guess name
  nameToFlag,    // Reverse: See name, guess flag
  capitalToName, // Capital: See capital, guess country
  nameToCapital  // Reverse Capital: See country, guess capital
}

enum QuizRegion {
  world,
  europe,
  africa,
  americas,
  asia,
  oceania
}

class QuizConfig {
  final QuizType type;
  final QuizRegion region;
  final int questionCount;

  const QuizConfig({
    this.type = QuizType.flagToName,
    this.region = QuizRegion.world,
    this.questionCount = 10,
  });
}
