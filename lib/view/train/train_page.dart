import 'package:flutter/material.dart';
import 'package:rpg/view/train/components/calculate_view.dart';
import 'package:rpg/view/train/components/improve_view.dart';
import 'package:rpg/view/train/components/quiz_view.dart';
import 'package:rpg/view/train/components/rule_view.dart';
import 'package:rpg/view/train/components/select_language.dart';

class TrainPage extends StatefulWidget {
  const TrainPage({Key? key}) : super(key: key);

  @override
  State<TrainPage> createState() => _TrainPageState();
}

class _TrainPageState extends State<TrainPage> with TickerProviderStateMixin {
  bool _fade = true;
  late AnimationController animationController = AnimationController(vsync: this, duration: const Duration(seconds: 5));
  late AnimationController fadeAnimationController =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 600));

  @override
  void dispose() {
    animationController.dispose();
    fadeAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Speech Demo'),
        centerTitle: true,
      ),
      body: ClipRect(
        child: Stack(
          children: [
            SelectLanguage(
              animationController: animationController,
            ),
            RuleView(
              fadeAnimationController: fadeAnimationController,
              animationController: animationController,
              fade: _fade,
              function: () => setState(() => _fade = false),
            ),
            QuizView(
              fadeAnimationController: fadeAnimationController,
              animationController: animationController,
              fade: _fade,
            ),
            CalculateView(
              animationController: animationController,
            ),
            ImproveView(
              animationController: animationController,
            ),
          ],
        ),
      ),
    );
  }
}
