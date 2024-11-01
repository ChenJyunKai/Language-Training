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
                position: Tween(begin: const Offset(2, 0), end: const Offset(0, 0)).animate(CurvedAnimation(
                  parent: animationController,
                  curve: const Interval(0, 0.333, curve: Curves.fastOutSlowIn),
                )),
                child: Lottie.asset('assets/lottie/animation-elf.json', height: 200),
              ),
              SlideTransition(
                position: Tween(begin: const Offset(3, 0), end: const Offset(0, 0)).animate(CurvedAnimation(
                  parent: animationController,
                  curve: const Interval(0, 0.333, curve: Curves.fastOutSlowIn),
                )),
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
                position: Tween(begin: const Offset(4, 0), end: const Offset(0, 0)).animate(CurvedAnimation(
                  parent: animationController,
                  curve: const Interval(0.2, 0.333, curve: Curves.fastOutSlowIn),
                )),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                    height: 50,
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
              ),
            ],
          ),
        );
      },
    );
  }
}
