import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:rpg/provider/ability.dart';
import 'package:rpg/router/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeView extends ConsumerStatefulWidget {
  const WelcomeView({Key? key, required this.animationController}) : super(key: key);

  final AnimationController animationController;

  @override
  ConsumerState<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends ConsumerState<WelcomeView> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: const Duration(seconds: 1), vsync: this);
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );
  }

  Animation<Offset> createSlideAnimation(double begin) {
    return Tween<Offset>(begin: Offset(begin, 0), end: const Offset(0, 0)).animate(
      CurvedAnimation(
        parent: widget.animationController,
        curve: const Interval(0.75, 1, curve: Curves.fastOutSlowIn),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: constraints.maxWidth,
          child: SlideTransition(
            position: createSlideAnimation(1),
            child: ref.watch(abilityProvider).roleData != null ? buildRole() : buildLoading(),
          ),
        );
      },
    );
  }

  Widget buildLoading() {
    _animationController.animateTo(0);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SlideTransition(
          position: createSlideAnimation(4),
          child: Lottie.asset('assets/lottie/rikka.json', height: 250),
        ),
        SlideTransition(
          position: createSlideAnimation(2),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 32),
            child: Text('角色生成中...', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
          ),
        )
      ],
    );
  }

  FadeTransition buildRole() {
    _animationController.animateTo(1);
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(ref.watch(abilityProvider).roleData!.imageAsset!, height: 250),
          RichText(
            text: TextSpan(
              text: "你的職業為",
              style: const TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold, color: Colors.black),
              children: [
                TextSpan(
                  text: "「${ref.watch(abilityProvider).role}」",
                  style: const TextStyle(fontSize: 28, color: Colors.black54),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24, left: 64, right: 64, bottom: 48),
            child: Text(
              ref.watch(abilityProvider).roleData!.describe!,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14),
            ),
          ),
          AnimatedBuilder(
            animation: widget.animationController,
            builder: (context, child) {
              return InkWell(
                onTap: () async {
                  final SharedPreferences prefs = await SharedPreferences.getInstance();
                  await prefs.setString('ability', jsonEncode(ref.watch(abilityProvider).toJson()));
                  if (context.mounted) {
                    Navigator.pushReplacementNamed(context, homeUrl);
                  }
                },
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
