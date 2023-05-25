import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:rpg/entity/button_entity.dart';
import 'package:rpg/view/home_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime? lastPressedAt;

    return WillPopScope(
      onWillPop: () async {
        if (lastPressedAt == null || DateTime.now().difference(lastPressedAt!) > const Duration(seconds: 1)) {
          Fluttertoast.showToast(
            msg: "再點一下返回離開。",
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            backgroundColor: Colors.black.withAlpha(180),
            fontSize: 16,
          );
          lastPressedAt = DateTime.now();
          return false;
        }
        Fluttertoast.cancel();
        return true;
      },
      child: Scaffold(
        body: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 40,
            bottom: 62 + MediaQuery.of(context).padding.bottom,
          ),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: DefaultTextStyle(
                      style: const TextStyle(
                        fontSize: 36,
                        color: Colors.black,
                      ),
                      child: AnimatedTextKit(
                        animatedTexts: [
                          TypewriterAnimatedText(
                            'Welcome Back~',
                            speed: const Duration(milliseconds: 200),
                          ),
                        ],
                        isRepeatingAnimation: true,
                        pause: const Duration(seconds: 2),
                        totalRepeatCount: 1,
                      ),
                    ),
                  ),
                  Lottie.asset('assets/lottie/loader-cat.json'),
                ],
              ),
            ),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              children: [
                for (ButtonEntity data in ButtonEntity.home) HomeButton(data: data),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
