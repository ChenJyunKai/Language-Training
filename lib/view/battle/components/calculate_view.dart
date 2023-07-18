import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CalculateView extends StatelessWidget {
  const CalculateView({
    Key? key,
    required this.fadeAnimationController,
    required this.animationController,
  }) : super(key: key);

  final AnimationController fadeAnimationController;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SlideTransition(
          position: Tween(begin: const Offset(2, 0), end: const Offset(0, 0)).animate(CurvedAnimation(
            parent: animationController,
            curve: const Interval(0.5, 1, curve: Curves.fastOutSlowIn),
          )),
          child: Lottie.asset('assets/lottie/rikka.json', height: 200),
        ),
        SlideTransition(
          position: Tween(begin: const Offset(3, 0), end: const Offset(0, 0)).animate(CurvedAnimation(
            parent: animationController,
            curve: const Interval(0.5, 1, curve: Curves.fastOutSlowIn),
          )),
          child: const Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text(
                "成績結算中...",
                style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
