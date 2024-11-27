import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rpg/provider/quiz.dart';

class SelectLanguage extends ConsumerWidget {
  const SelectLanguage({
    super.key,
    required this.animationController,
  });

  final AnimationController animationController;

  static List<Language> languages = [
    Language(name: '日語', id: 'ja_JA'),
    Language(name: '英語', id: 'en_US'),
    Language(name: '韓語', id: 'ko_KR'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SlideTransition(
              position: Tween(begin: const Offset(0, 0), end: const Offset(-4, 0)).animate(CurvedAnimation(
                parent: animationController,
                curve: const Interval(0, 1 / 3, curve: Curves.fastOutSlowIn),
              )),
              child: Container(
                width: constraints.maxWidth,
                alignment: Alignment.center,
                margin: const EdgeInsets.only(bottom: 30),
                child: const Text(
                  "請選擇語言模式",
                  style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Column(
              children: [
                for (Language i in languages)
                  SlideTransition(
                    position: Tween(begin: const Offset(0, 0), end: const Offset(-4, 0)).animate(CurvedAnimation(
                      parent: animationController,
                      curve: Interval(0.05 * languages.indexWhere((e) => e == i), 1 / 3, curve: Curves.fastOutSlowIn),
                    )),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      height: 50,
                      width: constraints.maxWidth * 0.7,
                      child: ElevatedButton(
                        onPressed: () {
                          animationController.animateTo(1 / 3);
                          ref.read(quizProvider.notifier).getData(i.id);
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.white70,
                        ),
                        child: Text(i.name, style: const TextStyle(fontSize: 20)),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class Language {
  Language({
    required this.name,
    required this.id,
  });

  final String name;
  final String id;
}
