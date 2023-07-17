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

  void remove(String word) async {
    state = WordEntity(words: [
      for (Word i in state.words)
        if (i.word != word) i
    ], languageId: state.languageId);
  }
}
