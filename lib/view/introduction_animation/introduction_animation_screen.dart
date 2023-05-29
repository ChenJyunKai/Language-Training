import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rpg/provider/abilities_provider.dart';
import 'package:rpg/view/introduction_animation/components/island_view.dart';
import 'package:rpg/view/introduction_animation/components/greet_view.dart';
import 'package:rpg/view/introduction_animation/components/breakfast_view.dart';
import 'package:rpg/view/introduction_animation/components/opening_view.dart';
import 'package:rpg/view/introduction_animation/components/top_back_skip_view.dart';
import 'package:rpg/view/introduction_animation/components/welcome_view.dart';
import 'package:flutter/material.dart';

class IntroductionAnimationScreen extends ConsumerStatefulWidget {
  const IntroductionAnimationScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<IntroductionAnimationScreen> createState() => _IntroductionAnimationScreenState();
}

class _IntroductionAnimationScreenState extends ConsumerState<IntroductionAnimationScreen>
    with TickerProviderStateMixin {
  AnimationController? _animationController;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 8));
    _animationController?.animateTo(0.0);
    super.initState();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7EBE1),
      body: ClipRect(
        child: Stack(
          children: [
            OpeningView(
              animationController: _animationController!,
            ),
            BreakfastView(
              animationController: _animationController!,
              onNextClick: _onNextClick,
            ),
            IslandView(
              animationController: _animationController!,
              onNextClick: _onNextClick,
            ),
            GreetView(
              animationController: _animationController!,
              onNextClick: _onNextClick,
            ),
            WelcomeView(
              animationController: _animationController!,
            ),
            TopBackSkipView(
              onBackClick: _onBackClick,
              onSkipClick: _onSkipClick,
              animationController: _animationController!,
            ),
          ],
        ),
      ),
    );
  }

  void _onSkipClick() {
    ref.read(abilitiesProvider.notifier).generate();
    _animationController?.animateTo(0.8, duration: const Duration(milliseconds: 1200));
  }

  void _onBackClick() {
    if (_animationController!.value >= 0 && _animationController!.value <= 0.2) {
      _animationController?.animateTo(0.0);
    } else if (_animationController!.value > 0.2 && _animationController!.value <= 0.4) {
      _animationController?.animateTo(0.2);
    } else if (_animationController!.value > 0.4 && _animationController!.value <= 0.6) {
      _animationController?.animateTo(0.4);
    } else if (_animationController!.value > 0.6 && _animationController!.value <= 0.8) {
      _animationController?.animateTo(0.6);
    } else if (_animationController!.value > 0.8 && _animationController!.value <= 1.0) {
      _animationController?.animateTo(0.8);
    }
  }

  void _onNextClick() {
    if (_animationController!.value >= 0 && _animationController!.value <= 0.2) {
      _animationController?.animateTo(0.4);
    } else if (_animationController!.value > 0.2 && _animationController!.value <= 0.4) {
      _animationController?.animateTo(0.6);
    } else if (_animationController!.value > 0.4 && _animationController!.value <= 0.6) {
      _animationController?.animateTo(0.8);
      ref.read(abilitiesProvider.notifier).generate();
    } else if (_animationController!.value > 0.6 && _animationController!.value <= 0.8) {
      _signUpClick();
    }
  }

  void _signUpClick() {
    Navigator.pop(context);
  }
}
