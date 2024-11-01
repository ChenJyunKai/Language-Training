import 'dart:math';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:rpg/entity/button_entity.dart';
import 'package:rpg/helper/app_theme.dart';
import 'package:rpg/view/home/ability_view.dart';
import 'package:rpg/view/home/home_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _showFrontSide = true;
  final bool _flipXAxis = true;
  DateTime? lastPressedAt;

  bool closeOnConfirm() {
    DateTime now = DateTime.now();
    if (lastPressedAt == null || DateTime.now().difference(lastPressedAt!) > const Duration(seconds: 1)) {
      lastPressedAt = now;
      Fluttertoast.showToast(
        msg: "再次點擊返回將關閉程序",
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
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (closeOnConfirm()) {
          SystemNavigator.pop();
        }
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
          transform:
              _flipXAxis ? (Matrix4.rotationY(value)..setEntry(3, 0, tilt)) : (Matrix4.rotationX(value)..setEntry(3, 1, tilt)),
          alignment: Alignment.center,
          child: widget,
        );
      },
    );
  }

  Widget _buildFlipAnimation() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onTap: () => setState(() => _showFrontSide = !_showFrontSide),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 600),
            transitionBuilder: __transitionBuilder,
            layoutBuilder: (widget, list) => Stack(children: [widget!, ...list]),
            switchInCurve: Curves.easeInBack,
            switchOutCurve: Curves.easeInBack.flipped,
            child: _showFrontSide ? _buildFront(constraints.maxWidth * 0.85) : _buildRear(constraints.maxWidth * 0.85),
          ),
        );
      },
    );
  }

  Widget _buildFront(double width) {
    return __buildLayout(
      key: const ValueKey(true),
      backgroundColor: AppTheme.background,
      child: Container(
        padding: const EdgeInsets.only(top: 20),
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black26),
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0.5, 0.5),
              blurRadius: 1,
              color: Colors.grey,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DefaultTextStyle(
              style: const TextStyle(fontSize: 30, color: Colors.black),
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
            Lottie.asset('assets/lottie/loader-cat.json', fit: BoxFit.fitHeight),
          ],
        ),
      ),
    );
  }

  Widget _buildRear(double width) {
    return __buildLayout(
      key: const ValueKey(false),
      backgroundColor: AppTheme.background,
      child: SizedBox(width: width, child: const AbilityView()),
    );
  }

  Widget __buildLayout({required Key key, required Color backgroundColor, required Widget child}) {
    return Container(
      key: key,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20.0),
        color: backgroundColor,
      ),
      child: child,
    );
  }
}
