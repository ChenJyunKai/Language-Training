import 'dart:convert';

WordJpEntity wordJpEntityFromJson(String str) => WordJpEntity.fromJson(json.decode(str));

String wordJpEntityToJson(WordJpEntity data) => json.encode(data.toJson());

class WordJpEntity {
  List<Word> words;

  WordJpEntity({
    required this.words,
  });

  factory WordJpEntity.fromJson(Map<String, dynamic> json) => WordJpEntity(
    words: List<Word>.from(json["words"].map((x) => Word.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "words": List<dynamic>.from(words.map((x) => x.toJson())),
  };
}

class Word {
  String word;
  String hiragana;

  Word({
    required this.word,
    required this.hiragana,
  });

  factory Word.fromJson(Map<String, dynamic> json) => Word(
    word: json["word"],
    hiragana: json["hiragana"],
  );

  Map<String, dynamic> toJson() => {
    "word": word,
    "hiragana": hiragana,
  };
}
