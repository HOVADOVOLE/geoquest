// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameSession _$GameSessionFromJson(Map<String, dynamic> json) => GameSession(
      questions: (json['questions'] as List<dynamic>)
          .map((e) => Country.fromJson(e as Map<String, dynamic>))
          .toList(),
      currentQuestionIndex:
          (json['currentQuestionIndex'] as num?)?.toInt() ?? 0,
      score: (json['score'] as num?)?.toInt() ?? 0,
      isFinished: json['isFinished'] as bool? ?? false,
      timeLeft: (json['timeLeft'] as num?)?.toInt() ?? 30,
      totalTime: (json['totalTime'] as num?)?.toInt() ?? 30,
    );

Map<String, dynamic> _$GameSessionToJson(GameSession instance) =>
    <String, dynamic>{
      'questions': instance.questions,
      'currentQuestionIndex': instance.currentQuestionIndex,
      'score': instance.score,
      'isFinished': instance.isFinished,
      'timeLeft': instance.timeLeft,
      'totalTime': instance.totalTime,
    };
