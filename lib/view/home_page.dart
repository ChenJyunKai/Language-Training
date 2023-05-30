import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:rpg/entity/button_entity.dart';
import 'package:rpg/helper/app_theme.dart';
import 'package:rpg/helper/screen_size.dart';
import 'package:rpg/view/home_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _showFrontSide = true;
  final bool _flipXAxis = true;

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
            Container(
              alignment: Alignment.center,
              constraints: BoxConstraints.tight(const Size.square(280)),
              child: _buildFlipAnimation(),
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

  Widget __transitionBuilder(Widget widget, Animation<double> animation) {
    final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnim,
      child: widget,
      builder: (context, widget) {
        final isUnder = (ValueKey(_showFrontSide) != widget?.key);
        var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
        tilt *= isUnder ? -1.0 : 1.0;
        final value = isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;
        return Transform(
          transform: _flipXAxis
              ? (Matrix4.rotationY(value)..setEntry(3, 0, tilt))
              : (Matrix4.rotationX(value)..setEntry(3, 1, tilt)),
          alignment: Alignment.center,
          child: widget,
        );
      },
    );
  }

  Widget _buildFlipAnimation() {
    return GestureDetector(
      onTap: () => setState(() => _showFrontSide = !_showFrontSide),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 600),
        transitionBuilder: __transitionBuilder,
        layoutBuilder: (widget, list) => Stack(children: [widget!, ...list]),
        switchInCurve: Curves.easeInBack,
        switchOutCurve: Curves.easeInBack.flipped,
        child: _showFrontSide ? _buildFront() : _buildRear(),
      ),
    );
  }

  Widget _buildFront() {
    return __buildLayout(
      key: const ValueKey(true),
      backgroundColor: AppTheme.background,
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
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
            Lottie.asset('assets/lottie/loader-cat.json', fit: BoxFit.fitHeight),
          ],
        ),
      ),
    );
  }

  Widget _buildRear() {
    return __buildLayout(
      key: const ValueKey(false),
      backgroundColor: AppTheme.background,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue[200],
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  Widget __buildLayout({required Key key, required Color backgroundColor, required Widget child}) {
    return Container(
      key: key,
      width: screenWidth * 0.85,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20.0),
        color: backgroundColor,
      ),
      child: child,
    );
  }
}
