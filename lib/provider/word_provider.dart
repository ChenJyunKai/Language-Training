import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rpg/entity/word_jp_entity.dart';

final wordProvider = StateNotifierProvider<WordNotifier, List<Word>>((ref) => WordNotifier());

class WordNotifier extends StateNotifier<List<Word>> {
  WordNotifier() : super([]);

  Future<bool> getData() async {
    state = wordJpEntityFromJson(await rootBundle.loadString('assets/json/word_jp.json')).words;
    return true;
  }

  void remove(String word) async {
    state = [
      for (Word i in state)
        if (i.word != word) i
    ];
  }
}
