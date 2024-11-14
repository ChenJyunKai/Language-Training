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

  Animation<Offset> createSlideAnimation(double begin, double end, double startInterval, double endInterval) {
    return Tween<Offset>(begin: Offset(begin, 0), end: Offset(end, 0)).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(startInterval, endInterval, curve: Curves.fastOutSlowIn),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final titleFirstHalfAnimation = createSlideAnimation(2, 0, 0.25, 0.5);
    final titleSecondHalfAnimation = createSlideAnimation(0, -2, 0.5, 0.75);
    final imageFirstHalfAnimation = createSlideAnimation(4, 0, 0.25, 0.5);
    final imageSecondHalfAnimation = createSlideAnimation(0, -4, 0.5, 0.75);
    final optionsFirstAnimation = createSlideAnimation(1, 0, 0.25, 0.5);
    final optoionsSecondAnimation = createSlideAnimation(0, -1, 0.5, 0.75);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
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
            SlideTransition(
              position: optionsFirstAnimation,
              child: SlideTransition(
                position: optoionsSecondAnimation,
                child: Container(
                  height: constraints.maxHeight * 0.4,
                  width: constraints.maxWidth,
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
              ),
            ),
          ],
        );
      },
    );
  }
}
