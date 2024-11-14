import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class GreetView extends StatelessWidget {
  const GreetView({
    Key? key,
    required this.animationController,
    required this.onNextClick,
  }) : super(key: key);

  final AnimationController animationController;
  final Function(int) onNextClick;
  static const List<String> options = ["喵哈囉~☆", "我一個人住", "決鬥!! 由我先攻", "小孩的名子就叫.."];

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
    final titleFirstHalfAnimation = createSlideAnimation(1, 0, 0.5, 0.75);
    final titleSecondHalfAnimation = createSlideAnimation(0, -1, 0.75, 1);
    final optionsFirstAnimation = createSlideAnimation(2, 0, 0.5, 0.75);
    final optoionsSecondAnimation = createSlideAnimation(0, -2, 0.75, 1);
    final imageFirstHalfAnimation = createSlideAnimation(4, 0, 0.5, 0.75);
    final imageSecondHalfAnimation = createSlideAnimation(0, -4, 0.75, 1);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SlideTransition(
              position: titleFirstHalfAnimation,
              child: SlideTransition(
                position: titleSecondHalfAnimation,
                child: Container(
                  padding: const EdgeInsets.only(top: 16),
                  width: constraints.maxWidth,
                  child: const Text(
                    "巧遇多年未見的青梅竹馬\n說出的第一句話...?",
                    style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
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
            SlideTransition(
              position: imageFirstHalfAnimation,
              child: SlideTransition(
                position: imageSecondHalfAnimation,
                child: Lottie.asset('assets/lottie/felix.json', height: 230),
              ),
            ),
          ],
        );
      },
    );
  }
}
