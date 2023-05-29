import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:rpg/helper/screen_size.dart';
import 'package:rpg/provider/abilities_provider.dart';

class WelcomeView extends ConsumerStatefulWidget {
  const WelcomeView({Key? key, required this.animationController}) : super(key: key);

  final AnimationController animationController;

  @override
  ConsumerState<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends ConsumerState<WelcomeView> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  );
  late final Animation<double> _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
    CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    ),
  );
  late final firstHalfAnimation = Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0)).animate(
    CurvedAnimation(
      parent: widget.animationController,
      curve: const Interval(
        0.6,
        0.8,
        curve: Curves.fastOutSlowIn,
      ),
    ),
  );
  late final secondHalfAnimation = Tween<Offset>(begin: const Offset(0, 0), end: const Offset(-1, 0)).animate(
    CurvedAnimation(
      parent: widget.animationController,
      curve: const Interval(
        0.8,
        1.0,
        curve: Curves.fastOutSlowIn,
      ),
    ),
  );
  late final welcomeFirstHalfAnimation = Tween<Offset>(begin: const Offset(2, 0), end: const Offset(0, 0)).animate(
    CurvedAnimation(
      parent: widget.animationController,
      curve: const Interval(
        0.6,
        0.8,
        curve: Curves.fastOutSlowIn,
      ),
    ),
  );
  late final welcomeImageAnimation = Tween<Offset>(begin: const Offset(4, 0), end: const Offset(0, 0)).animate(
    CurvedAnimation(
      parent: widget.animationController,
      curve: const Interval(
        0.6,
        0.8,
        curve: Curves.fastOutSlowIn,
      ),
    ),
  );

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: firstHalfAnimation,
      child: SlideTransition(
        position: secondHalfAnimation,
        child: ref.watch(abilitiesProvider).role != null ? buildFadeTransition() : buildColumn(),
      ),
    );
  }

  Column buildColumn() {
    _animationController.animateTo(0);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SlideTransition(
          position: welcomeImageAnimation,
          child: Lottie.asset('assets/lottie/rikka.json', height: 250),
        ),
        Container(
          alignment: Alignment.center,
          width: screenWidth,
          child: SlideTransition(
            position: welcomeFirstHalfAnimation,
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 32),
              child: Text('角色生成中...', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            ),
          ),
        )
      ],
    );
  }

  FadeTransition buildFadeTransition() {
    _animationController.animateTo(1);
    return FadeTransition(
      opacity: _animation,
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
            padding: EdgeInsets.only(top: 24, left: 64, right: 64, bottom: 48),
            child: Text(
              "「你是獨一無二的，因為我們都不希望再有第二個。」\n"
              "— Theodore Roosevelt, 26th U.S. President",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14),
            ),
          ),
          AnimatedBuilder(
            animation: widget.animationController,
            builder: (context, child) {
              return InkWell(
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
              );
            },
          ),
        ],
      ),
    );
  }
}
