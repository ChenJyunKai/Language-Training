// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QuizEntityImpl _$$QuizEntityImplFromJson(Map<String, dynamic> json) =>
    _$QuizEntityImpl(
      words: (json['words'] as List<dynamic>?)
              ?.map((e) => WordEntity.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      languageId: json['languageId'] as String? ?? '',
      count: json['count'] ?? 0,
      totalScore: (json['totalScore'] as num?)?.toInt(),
      exp: (json['exp'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$QuizEntityImplToJson(_$QuizEntityImpl instance) =>
    <String, dynamic>{
      'words': instance.words,
      'languageId': instance.languageId,
      'count': instance.count,
      'totalScore': instance.totalScore,
      'exp': instance.exp,
    };

_$WordEntityImpl _$$WordEntityImplFromJson(Map<String, dynamic> json) =>
    _$WordEntityImpl(
      word: json['word'] as String,
      hint: json['hint'] as String,
      score: (json['score'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$WordEntityImplToJson(_$WordEntityImpl instance) =>
    <String, dynamic>{
      'word': instance.word,
      'hint': instance.hint,
      'score': instance.score,
    };
