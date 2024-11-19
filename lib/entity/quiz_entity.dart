import 'package:freezed_annotation/freezed_annotation.dart';

part 'quiz_entity.freezed.dart';

part 'quiz_entity.g.dart';

@freezed
class QuizEntity with _$QuizEntity {
  const factory QuizEntity({
    @Default([]) List<WordEntity> words,
    @Default('') String languageId,
    @Default(1) count,
    int? totalScore,
    int? exp,
  }) = _QuizEntity;

  factory QuizEntity.fromJson(Map<String, dynamic> json) => _$QuizEntityFromJson(json);
}

@freezed
class WordEntity with _$WordEntity {
  const factory WordEntity({
    required String word,
    required String hint,
    @Default(0) int score,
  }) = _WordEntity;

  factory WordEntity.fromJson(Map<String, dynamic> json) => _$WordEntityFromJson(json);
}
