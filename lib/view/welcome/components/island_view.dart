import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IslandView extends StatelessWidget {
  const IslandView({
    Key? key,
    required this.animationController,
    required this.onNextClick,
  }) : super(key: key);

  final AnimationController animationController;
  final Function(int) onNextClick;
  static const List<String> options = ["紙船", "遙控車", "香菸", "熊玩偶"];

  @override
  Widget build(BuildContext context) {
    final firstHalfAnimation = Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0)).animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.25,
        0.5,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    final secondHalfAnimation = Tween<Offset>(begin: const Offset(0, 0), end: const Offset(-1, 0)).animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.5,
        0.75,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    final titleFirstHalfAnimation = Tween<Offset>(begin: const Offset(2, 0), end: const Offset(0, 0)).animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.25,
        0.5,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    final titleSecondHalfAnimation = Tween<Offset>(begin: const Offset(0, 0), end: const Offset(-2, 0)).animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.5,
        0.75,
        curve: Curves.fastOutSlowIn,
      ),
    ));

    final imageFirstHalfAnimation = Tween<Offset>(begin: const Offset(4, 0), end: const Offset(0, 0)).animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.25,
        0.5,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    final imageSecondHalfAnimation = Tween<Offset>(begin: const Offset(0, 0), end: const Offset(-4, 0)).animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.5,
        0.75,
        curve: Curves.fastOutSlowIn,
      ),
    ));

    return LayoutBuilder(
      builder: (context, constraints) {
        return SlideTransition(
          position: firstHalfAnimation,
          child: SlideTransition(
            position: secondHalfAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SlideTransition(
                  position: imageFirstHalfAnimation,
                  child: SlideTransition(
                    position: imageSecondHalfAnimation,
                    child: Lottie.asset(
                      'assets/lottie/island.json',
                      height: 300,
                    ),
                  ),
                ),
                SlideTransition(
                  position: titleFirstHalfAnimation,
                  child: SlideTransition(
                    position: titleSecondHalfAnimation,
                    child: Container(
                      width: constraints.maxWidth,
                      alignment: Alignment.center,
                      child: const Text(
                        "前往荒島前會帶上...?",
                        style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: constraints.maxHeight * 0.4,
                  padding: const EdgeInsets.only(top: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      for (String i in options)
                        SizedBox(
                          height: 50,
                          width: constraints.maxWidth * 0.7,
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
              ],
            ),
          ),
        );
      },
    );
  }
}
