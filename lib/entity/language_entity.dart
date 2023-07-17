class Language {
  Language({required this.name, required this.id});

  final String name;
  final String id;

  static List<Language> list = [
    Language(name: '日語', id: 'ja_JA'),
    Language(name: '英語', id: 'en_US'),
    Language(name: '中文', id: 'zh_TW'),
  ];
}