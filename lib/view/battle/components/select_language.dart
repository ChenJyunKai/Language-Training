import 'package:flutter/material.dart';
import 'package:rpg/entity/language_entity.dart';
import 'package:rpg/helper/screen_size.dart';

class SelectLanguage extends StatelessWidget {
  const SelectLanguage({
    super.key,
    required this.animationController,
    required this.select,
  });

  final AnimationController animationController;
  final Function(Language) select;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SlideTransition(
          position: Tween(begin: const Offset(0, 0), end: const Offset(-4, 0)).animate(CurvedAnimation(
            parent: animationController,
            curve: const Interval(0, 1, curve: Curves.fastOutSlowIn),
          )),
          child: Container(
            width: screenWidth,
            alignment: Alignment.center,
            child: const Text(
              "請選擇語言模式",
              style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Container(
          height: screenHeight * 0.3,
          padding: const EdgeInsets.only(top: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (Language i in Language.list)
                SlideTransition(
                  position: Tween(begin: const Offset(0, 0), end: const Offset(-4, 0)).animate(CurvedAnimation(
                    parent: animationController,
                    curve: Interval(0.1 * Language.list.indexWhere((e) => e == i), 1, curve: Curves.fastOutSlowIn),
                  )),
                  child: SizedBox(
                    height: 50,
                    width: screenWidth * 0.7,
                    child: ElevatedButton(
                      onPressed: () {
                        animationController.animateTo(1);
                        select(i);
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
  }
}
