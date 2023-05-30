import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rpg/helper/screen_size.dart';

class OpeningView extends StatefulWidget {
  const OpeningView({Key? key, required this.animationController}) : super(key: key);

  final AnimationController animationController;

  @override
  State<OpeningView> createState() => _OpeningViewState();
}

class _OpeningViewState extends State<OpeningView> with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final introductionAnimation = Tween<Offset>(begin: const Offset(0, 0), end: const Offset(0.0, -1.0)).animate(
      CurvedAnimation(
        parent: widget.animationController,
        curve: const Interval(0.0, 0.2, curve: Curves.fastOutSlowIn),
      ),
    );
    final Animation<double> animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0, 1, curve: Curves.fastOutSlowIn),
      ),
    );
    return SlideTransition(
      position: introductionAnimation,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Lottie.asset(
                'assets/lottie/loader-cat.json',
                width: screenWidth,
                height: 300,
                fit: BoxFit.fitWidth,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 40),
              child: Text(
                "歡迎你喵!",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36),
              child: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    '冒險者啊，你的命運正等待著你。勇敢的心將帶領你穿越奇幻的世界，挑戰無數的怪物與試煉。準備好了嗎？握緊你的武器，踏上屬於你的英雄之旅！',
                    speed: const Duration(milliseconds: 100),
                    textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ],
                isRepeatingAnimation: true,
                totalRepeatCount: 1,
                onFinished: () => _animationController.animateTo(1),
              ),
            ),
            const SizedBox(height: 60),
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return FadeTransition(
                  opacity: animation,
                  child: Transform(
                    transform: Matrix4.translationValues(100 * (1.0 - animation.value), 0.0, 0.0),
                    child: InkWell(
                      onTap: () {
                        widget.animationController.animateTo(0.2);
                      },
                      child: Container(
                        height: 58,
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 56),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(38.0),
                          color: const Color(0xff132137),
                        ),
                        child: const Text(
                          "Let's begin",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
