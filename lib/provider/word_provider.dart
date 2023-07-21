import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rpg/entity/word_entity.dart';

final wordProvider = StateNotifierProvider<WordNotifier, WordEntity>((ref) => WordNotifier());

class WordNotifier extends StateNotifier<WordEntity> {
  WordNotifier() : super(WordEntity(words: [], languageId: 'ja_JA'));

  void getData(String languageId) async {
    final data = wordEntityFromJson(await rootBundle.loadString('assets/json/word_jp.json'));
    final words = <Word>{};
    while (words.length < 10) {
      words.add(data.words[Random().nextInt(data.words.length)]);
    }
    state = WordEntity(words: words.toList(), languageId: languageId);
  }

  void answer(int score) async {
    final newWords = state.words;
    final word = newWords.removeAt(0);
    word.score = score;
    state = WordEntity(
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
      state = state.copywith(totalScore: totalScore);
    });
  }

  void getExp() async {
    Future.delayed(const Duration(seconds: 2), () {
      state = state.copywith(exp: state.totalScore! * 10);
    });
  }

  void lastExp(int exp) async {
    state = state.copywith(exp: exp);
  }
}
