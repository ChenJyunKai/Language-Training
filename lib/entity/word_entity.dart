import 'dart:convert';

WordEntity wordJpEntityFromJson(String str) => WordEntity.fromJson(json.decode(str));

String wordJpEntityToJson(WordEntity data) => json.encode(data.toJson());

class WordEntity {
  List<Word> words;
  String languageId;

  WordEntity({
    required this.words,
    required this.languageId,
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
