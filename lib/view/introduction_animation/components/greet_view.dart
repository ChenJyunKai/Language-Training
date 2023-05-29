import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rpg/helper/screen_size.dart';

class GreetView extends StatelessWidget {
  const GreetView({
    Key? key,
    required this.animationController,
    required this.onNextClick,
  }) : super(key: key);

  final AnimationController animationController;
  final VoidCallback onNextClick;
  static const List<String> option = ["喵哈囉~☆", "我一個人住", "決鬥!! 由我先攻", "小孩的名子就叫.."];

  @override
  Widget build(BuildContext context) {
    final firstHalfAnimation =
        Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0)).animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.4,
        0.6,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    final secondHalfAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(-1, 0)).animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.6,
        0.8,
        curve: Curves.fastOutSlowIn,
      ),
    ));

    final moodFirstHalfAnimation =
        Tween<Offset>(begin: const Offset(2, 0), end: const Offset(0, 0)).animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.4,
        0.6,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    final moodSecondHalfAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(-2, 0)).animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.6,
        0.8,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    final imageFirstHalfAnimation =
        Tween<Offset>(begin: const Offset(4, 0), end: const Offset(0, 0)).animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.4,
        0.6,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    final imageSecondHalfAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(-4, 0)).animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.6,
        0.8,
        curve: Curves.fastOutSlowIn,
      ),
    ));

    return SlideTransition(
      position: firstHalfAnimation,
      child: SlideTransition(
        position: secondHalfAnimation,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 16),
              width: screenWidth,
              child: const Text(
                "巧遇多年未見的青梅竹馬\n說出的第一句話...?",
                style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            SlideTransition(
              position: moodFirstHalfAnimation,
              child: SlideTransition(
                position: moodSecondHalfAnimation,
                child: Container(
                  height: screenHeight * 0.4,
                  padding: const EdgeInsets.only(top: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      for (String i in option)
                        SizedBox(
                          height: 50,
                          width: screenWidth * 0.7,
                          child: ElevatedButton(
                            onPressed: onNextClick,
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.black,
                              backgroundColor: Colors.white70,
                            ),
                            child: Text(i, style: const TextStyle(fontSize: 20)),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            SlideTransition(
              position: imageFirstHalfAnimation,
              child: SlideTransition(
                position: imageSecondHalfAnimation,
                child: Lottie.asset('assets/lottie/felix.json', height: 230),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
