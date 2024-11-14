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
  late AnimationController _animationController;
  late AnimationController _fadeAnimationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 5));
    _fadeAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
  }

  @override
  void dispose() {
    _animationController.dispose();
    _fadeAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SelectLanguage(
            animationController: _animationController,
          ),
          RuleView(
            fadeAnimationController: _fadeAnimationController,
            animationController: _animationController,
          ),
          QuizView(
            fadeAnimationController: _fadeAnimationController,
            animationController: _animationController,
          ),
          CalculateView(
            animationController: _animationController,
          ),
          ImproveView(
            animationController: _animationController,
          ),
          TopBackView(
            onBackClick: _onBackClick,
            animationController: _fadeAnimationController,
          ),
        ],
      ),
    );
  }

  void _onBackClick() {
    if (_animationController.value == 0) {
      Navigator.maybePop(context);
    } else if (_animationController.value > 0 && _animationController.value <= 1 / 3) {
      _animationController.animateTo(0.0);
    }
  }
}
