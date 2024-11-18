import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class RuleView extends StatelessWidget {
  const RuleView({
    super.key,
    required this.fadeAnimationController,
    required this.animationController,
  });

  final AnimationController fadeAnimationController;
  final AnimationController animationController;

  Animation<Offset> createSlideAnimation(double begin) {
    return Tween<Offset>(begin: Offset(begin, 0), end: const Offset(0, 0)).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0, 1 / 3, curve: Curves.fastOutSlowIn),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return FadeTransition(
          opacity: Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
            parent: fadeAnimationController,
            curve: const Interval(0, 1, curve: Curves.fastOutSlowIn),
          )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SlideTransition(
                position: createSlideAnimation(2),
                child: Lottie.asset('assets/lottie/animation-elf.json', height: 200),
              ),
              SlideTransition(
                position: createSlideAnimation(4),
                child: Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: constraints.maxWidth * 0.6,
                    child: const Text(
                      "請根據上面的單字唸出讀音",
                      style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              SlideTransition(
                position: createSlideAnimation(8),
                child: Container(
                  height: 100,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () => fadeAnimationController.forward(),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color(0xff132137),
                    ),
                    child: const Text("Let's begin", style: TextStyle(fontSize: 18)),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
