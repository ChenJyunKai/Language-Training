import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rpg/entity/quiz_entity.dart';

part 'quiz.g.dart';

@Riverpod(keepAlive: true)
class Quiz extends _$Quiz {
  @override
  QuizEntity build() {
    return const QuizEntity();
  }

  void getData(String languageId) async {
    final data = QuizEntity.fromJson(jsonDecode(
      await rootBundle.loadString('assets/json/word_${languageId.substring(0, 2)}.json'),
    ));
    final words = <WordEntity>{};
    while (words.length < 10) {
      words.add(data.words[Random().nextInt(data.words.length)]);
    }
    state = QuizEntity(words: words.toList(), languageId: languageId);
  }

  void answer(int score) async {
    final newWords = List.from(state.words);
    final word = newWords.removeAt(0).copyWith(score: score);

    state = QuizEntity(
      words: state.count == 10 ? [word, ...newWords] : [...newWords, word],
      languageId: state.languageId,
      count: (state.count < 10 ? state.count + 1 : state.count),
    );
    if (state.count == 10) {
      calculate();
    }
  }

  void calculate() async {
    final totalScore = [for (final i in state.words) i.score].reduce((value, current) => value + current);
    Future.delayed(const Duration(seconds: 2), () {
      state = state.copyWith(totalScore: totalScore);
    });
  }

  void getExp() async {
    Future.delayed(const Duration(seconds: 2), () {
      state = state.copyWith(exp: state.totalScore! * 10);
    });
  }
}

