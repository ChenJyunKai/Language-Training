import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rpg/entity/language_entity.dart';
import 'package:rpg/provider/word.dart';

class SelectLanguage extends ConsumerWidget {
  const SelectLanguage({
    super.key,
    required this.animationController,
  });

  final AnimationController animationController;

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
                curve: const Interval(0, 0.333, curve: Curves.fastOutSlowIn),
              )),
              child: Container(
                width: constraints.maxWidth,
                alignment: Alignment.center,
                child: const Text(
                  "請選擇語言模式",
                  style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              height: constraints.maxHeight * 0.3,
              padding: const EdgeInsets.only(top: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (Language i in Language.list)
                    SlideTransition(
                      position: Tween(begin: const Offset(0, 0), end: const Offset(-4, 0)).animate(CurvedAnimation(
                        parent: animationController,
                        curve: Interval(0.05 * Language.list.indexWhere((e) => e == i), 0.333, curve: Curves.fastOutSlowIn),
                      )),
                      child: SizedBox(
                        height: 50,
                        width: constraints.maxWidth * 0.7,
                        child: ElevatedButton(
                          onPressed: () {
                            animationController.animateTo(0.333);
                            ref.read(wordProvider.notifier).getData(i.id);
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
            ),
          ],
        );
      },
    );
  }
}
