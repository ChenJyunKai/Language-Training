import 'dart:convert';

WordEntity wordEntityFromJson(String str) => WordEntity.fromJson(json.decode(str));

String wordEntityToJson(WordEntity data) => json.encode(data.toJson());

class WordEntity {
  List<Word> words;
  String languageId;
  int count;
  int? totalScore;
  int? exp;

  WordEntity({
    required this.words,
    required this.languageId,
    this.count = 1,
    this.totalScore,
    this.exp,
  });

  WordEntity copywith({int? totalScore,int? exp}) {
    return WordEntity(
      words: words,
      languageId: languageId,
      count: count,
      totalScore: totalScore ?? this.totalScore,
      exp: exp ?? this.exp,
    );
  }

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

  // 每題得分
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
