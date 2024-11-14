import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rpg/provider/ability.dart';
import 'package:rpg/view/welcome/components/island_view.dart';
import 'package:rpg/view/welcome/components/greet_view.dart';
import 'package:rpg/view/welcome/components/breakfast_view.dart';
import 'package:rpg/view/welcome/components/opening_view.dart';
import 'package:rpg/view/welcome/components/top_back_skip_view.dart';
import 'package:rpg/view/welcome/components/welcome_view.dart';
import 'package:flutter/material.dart';

class WelcomePage extends ConsumerStatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends ConsumerState<WelcomePage> with TickerProviderStateMixin {
  AnimationController? _animationController;
  List<int> options = [0, 0, 0];

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 6));
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
      body: Stack(
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
    );
  }

  void _onSkipClick() {
    _animationController?.animateTo(1, duration: const Duration(milliseconds: 1200));
    ref.read(abilityProvider.notifier).generate(option: options);
  }

  void _onBackClick() {
    if (_animationController!.value >= 0 && _animationController!.value <= 0.25) {
      _animationController?.animateTo(0.0);
    } else if (_animationController!.value > 0.25 && _animationController!.value <= 0.5) {
      _animationController?.animateTo(0.25);
    } else if (_animationController!.value > 0.5 && _animationController!.value <= 0.75) {
      _animationController?.animateTo(0.5);
    } else if (_animationController!.value > 0.75 && _animationController!.value <= 1) {
      _animationController?.animateTo(0.75).then((_) => ref.read(abilityProvider.notifier).removeData());
    }
  }

  _onNextClick(int option) {
    if (_animationController!.value >= 0.25 && _animationController!.value < 0.5) {
      options[0] = option;
      _animationController?.animateTo(0.5);
    } else if (_animationController!.value >= 0.5 && _animationController!.value < 0.75) {
      options[1] = option;
      _animationController?.animateTo(0.75);
    } else if (_animationController!.value >= 0.75 && _animationController!.value < 1) {
      options[2] = option;
      _animationController?.animateTo(1);
      ref.read(abilityProvider.notifier).generate(option: options);
    }
  }
}
