import 'dart:convert';

WordEntity wordEntityFromJson(String str) => WordEntity.fromJson(json.decode(str));

String wordEntityToJson(WordEntity data) => json.encode(data.toJson());

class WordEntity {
  List<Word> words;
  String languageId;
  int count;

  WordEntity({
    required this.words,
    required this.languageId,
    this.count = 1,
  });

  factory WordEntity.fromJson(Map<String, dynamic> json) => WordEntity(
    languageId: json["language_id"],
    words: List<Word>.from(json["words"].map((x) => Word.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "language_id": languageId,
    "words": List<dynamic>.from(words.map((x) => x.toJson())),
  };
}

class Word {
  String word;
  String hiragana;
  // 得分
  int score;

  Word({
    required this.word,
    required this.hiragana,
    this.score = 0,
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
