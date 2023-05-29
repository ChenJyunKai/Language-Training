import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({Key? key, required this.animationController}) : super(key: key);

  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    final firstHalfAnimation = Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0)).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          0.6,
          0.8,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
    final secondHalfAnimation = Tween<Offset>(begin: const Offset(0, 0), end: const Offset(-1, 0)).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          0.8,
          1.0,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
    final welcomeFirstHalfAnimation = Tween<Offset>(begin: const Offset(2, 0), end: const Offset(0, 0)).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          0.6,
          0.8,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
    final welcomeImageAnimation = Tween<Offset>(begin: const Offset(4, 0), end: const Offset(0, 0)).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          0.6,
          0.8,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
    final Animation<double> animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0, 1, curve: Curves.fastOutSlowIn),
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
              position: welcomeImageAnimation,
              child: Lottie.asset('assets/lottie/cute-tiger.json', height: 250),
            ),
            SlideTransition(
              position: welcomeFirstHalfAnimation,
              child: RichText(
                text: const TextSpan(
                  text: "你的職業為",
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold, color: Colors.black),
                  children: [TextSpan(text: "「冒險家」", style: TextStyle(fontSize: 28, color: Colors.black54))],
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 64),
              child: Text(
                "「你是獨一無二的，因為我們都不希望再有第二個。」\n"
                "— Theodore Roosevelt, 26th U.S. President",
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            AnimatedBuilder(
              animation: animationController,
              builder: (context, child) {
                return FadeTransition(
                  opacity: animation,
                  child: Transform(
                    transform: Matrix4.translationValues(100 * (1.0 - animation.value), 0.0, 0.0),
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        height: 58,
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 56),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(38.0),
                          color: const Color(0xff132137),
                        ),
                        child: const Text(
                          "Link Start !!",
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
