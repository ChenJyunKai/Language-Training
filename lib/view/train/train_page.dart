import 'package:flutter/material.dart';
import 'package:rpg/view/train/components/calculate_view.dart';
import 'package:rpg/view/train/components/improve_view.dart';
import 'package:rpg/view/train/components/quiz_view.dart';
import 'package:rpg/view/train/components/rule_view.dart';
import 'package:rpg/view/train/components/select_language.dart';
import 'package:rpg/view/train/components/top_back_view.dart';

class TrainPage extends StatefulWidget {
  const TrainPage({Key? key}) : super(key: key);

  @override
  State<TrainPage> createState() => _TrainPageState();
}

class _TrainPageState extends State<TrainPage> with TickerProviderStateMixin {
  late AnimationController animationController = AnimationController(vsync: this, duration: const Duration(seconds: 5));
  late AnimationController fadeAnimationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 600),
  );

  @override
  void dispose() {
    animationController.dispose();
    fadeAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ClipRect(
        child: Stack(
          children: [
            SelectLanguage(
              animationController: animationController,
            ),
            RuleView(
              fadeAnimationController: fadeAnimationController,
              animationController: animationController,
            ),
            QuizView(
              fadeAnimationController: fadeAnimationController,
              animationController: animationController,
            ),
            CalculateView(
              animationController: animationController,
            ),
            ImproveView(
              animationController: animationController,
            ),
            TopBackView(
              onBackClick: _onBackClick,
              animationController: fadeAnimationController,
            ),
          ],
        ),
      ),
    );
  }

  void _onBackClick() {
    if (animationController.value == 0) {
      Navigator.pop(context);
    } else if (animationController.value > 0 && animationController.value <= 1 / 3) {
      animationController.animateTo(0.0);
    }
  }
}
