import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rpg/helper/screen_size.dart';

class BreakfastView extends StatelessWidget {
  const BreakfastView({
    Key? key,
    required this.animationController,
    required this.onNextClick,
  }) : super(key: key);

  final AnimationController animationController;
  final Function(int) onNextClick;
  static const List<String> options = ["醬油", "醬油膏", "番茄醬", "糖醋醬"];

  @override
  Widget build(BuildContext context) {
    final firstHalfAnimation = Tween<Offset>(begin: const Offset(0, 1), end: const Offset(0, 0)).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          0.0,
          0.2,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
    final secondHalfAnimation = Tween<Offset>(begin: const Offset(0, 0), end: const Offset(-1, 0)).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          0.2,
          0.4,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
    final optionsAnimation = Tween<Offset>(begin: const Offset(0, 0), end: const Offset(-2, 0)).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          0.2,
          0.4,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
    final imageAnimation = Tween<Offset>(begin: const Offset(0, 0), end: const Offset(-4, 0)).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          0.2,
          0.4,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );

    final titleAnimation = Tween<Offset>(begin: const Offset(0, -2), end: const Offset(0, 0)).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          0.0,
          0.2,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );

    return SlideTransition(
      position: firstHalfAnimation,
      child: SlideTransition(
        position: secondHalfAnimation,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SlideTransition(
              position: titleAnimation,
              child: Container(
                width: screenWidth,
                alignment: Alignment.center,
                child: const Text(
                  "早餐的荷包蛋應該沾...?",
                  style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SlideTransition(
              position: optionsAnimation,
              child: Container(
                height: screenHeight * 0.5,
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 36),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (String i in options)
                      SizedBox(
                        height: 50,
                        width: screenWidth * 0.7,
                        child: ElevatedButton(
                          onPressed: () => onNextClick(options.indexOf(i)),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.white,
                          ),
                          child: Text(i, style: const TextStyle(fontSize: 20)),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            SlideTransition(
              position: imageAnimation,
              child: Lottie.asset('assets/lottie/breakfast.json', height: 150),
            ),
          ],
        ),
      ),
    );
  }
}
