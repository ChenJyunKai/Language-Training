import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:rpg/entity/ability_entity.dart';
import 'package:rpg/provider/ability.dart';
import 'package:rpg/provider/quiz.dart';
import 'package:rpg/view/train/components/level_view.dart';

class ImproveView extends ConsumerStatefulWidget {
  const ImproveView({
    Key? key,
    required this.animationController,
  }) : super(key: key);

  final AnimationController animationController;

  @override
  ConsumerState<ImproveView> createState() => _ImproveViewState();
}

class _ImproveViewState extends ConsumerState<ImproveView> with TickerProviderStateMixin {
  AbilityEntity improveAbility = const AbilityEntity();
  int plusExp = 0;
  bool fall = false;
  late AbilityEntity ability;
  late AnimationController fadeAnimationController;
  late AnimationController levelUpAnimationController;
  late AnimationController improveAnimationController;
  late AnimationController nextAnimationController;
  late Animation<double> nextAnimation;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      ability = ref.watch(abilityProvider);
    });
    fadeAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));
    levelUpAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    improveAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    nextAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    nextAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: nextAnimationController,
      curve: const Interval(0, 1, curve: Curves.easeIn),
    ));
  }

  @override
  void dispose() {
    fadeAnimationController.dispose();
    levelUpAnimationController.dispose();
    improveAnimationController.dispose();
    nextAnimationController.dispose();
    super.dispose();
  }

  void improvedAbility() {
    final hp = 50 + 25 * (Random().nextInt(3));
    final mp = 10 + 5 * (Random().nextInt(3));
    final atk = 1 + Random().nextInt(5);
    final def = 1 + Random().nextInt(5);
    final agi = 1 + Random().nextInt(5);
    final luk = 1 + Random().nextInt(5);
    setState(() {
      improveAbility = AbilityEntity(hp: hp, mp: mp, atk: atk, def: def, agi: agi, luk: luk, sp: 1);
    });
    improveAnimationController.forward();
  }

  void handleLevelUp() {
    levelUpAnimationController.forward().then((value) {
      // 計算升等公式
      int remainExp = ref.watch(quizProvider).exp! - ability.expL + ability.exp;
      int newLv = ability.lv + 1;
      int nextExpL = ((pow((newLv - 1), 3) + 60) / 5 * ((newLv - 1) * 2 + 60) + 60).floor();
      nextExpL = (50 - ((nextExpL % 50).floor() == 0 ? 50 : (nextExpL % 50).floor())) + nextExpL;
      improvedAbility();
      // 跳級計算
      while (remainExp > nextExpL) {
        remainExp -= nextExpL;
        newLv++;
        nextExpL = ((pow((newLv - 1), 3) + 60) / 5 * ((newLv - 1) * 2 + 60) + 60).floor();
        nextExpL = (50 - ((nextExpL % 50).floor() == 0 ? 50 : (nextExpL % 50).floor())) + nextExpL;
        improvedAbility();
      }
      // 修改數值
      fall = true;
      plusExp = remainExp;
      ability = ability.copyWith(lv: newLv, exp: remainExp, expL: nextExpL);
      levelUpAnimationController.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return (ref.watch(quizProvider).exp != null && widget.animationController.value == 1) ? buildImprove() : buildLoading();
  }

  Widget buildLoading() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SlideTransition(
          position: Tween(begin: const Offset(2, 0), end: const Offset(0, 0)).animate(CurvedAnimation(
            parent: widget.animationController,
            curve: const Interval(0.666, 1, curve: Curves.fastOutSlowIn),
          )),
          child: Lottie.asset('assets/lottie/animation-elf.json', height: 200),
        ),
        SlideTransition(
          position: Tween(begin: const Offset(3, 0), end: const Offset(0, 0)).animate(CurvedAnimation(
            parent: widget.animationController,
            curve: const Interval(0.666, 1, curve: Curves.fastOutSlowIn),
          )),
          child: const Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text(
                "經驗結算中...",
                style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }

  SlideTransition buildImprove() {
    fadeAnimationController.forward();
    if (!fall) {
      plusExp = ref.watch(quizProvider).exp!;
    }
    if (ref.watch(quizProvider).exp == 0) {
      nextAnimationController.forward();
    }
    return SlideTransition(
      position: Tween<Offset>(begin: const Offset(2, 0), end: const Offset(0, 0)).animate(CurvedAnimation(
        parent: widget.animationController,
        curve: const Interval(0.666, 1, curve: Curves.fastOutSlowIn),
      )),
      child: FadeTransition(
        opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: fadeAnimationController, curve: Curves.easeIn),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text('本次獲得 +${ref.watch(quizProvider).exp} Exp', style: const TextStyle(fontSize: 24)),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(
                '距離下一級還需 ${fall ? (ability.expL - plusExp) : (ability.expL - ability.exp - plusExp) > 0 ? ability.expL - ability.exp - plusExp : 0} Exp',
                style: const TextStyle(fontSize: 24),
              ),
            ),
            LevelView(
              levelUpAnimationController: levelUpAnimationController,
              nextAnimationController: nextAnimationController,
              ability: ability,
              plusExp: plusExp,
              fall: fall,
              handleLevelUp: handleLevelUp,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24, left: 8, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(ability.userName!, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  FadeTransition(
                    opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(parent: improveAnimationController, curve: Curves.easeIn),
                    ),
                    child: const Text(
                      'Level up!!',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.military_tech_outlined, color: Colors.grey),
                      Text(ability.role!, style: const TextStyle(fontSize: 16, color: Colors.grey)),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                elevation: 3,
                surfaceTintColor: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              buildListTile('血量', ability.hp, improveAbility.hp, 0),
                              buildListTile('攻擊', ability.atk, improveAbility.atk, 2),
                              buildListTile('敏捷', ability.agi, improveAbility.agi, 4),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              buildListTile('魔力', ability.mp, improveAbility.mp, 1),
                              buildListTile('防禦', ability.def, improveAbility.def, 3),
                              buildListTile('幸運', ability.luk, improveAbility.luk, 5),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            AnimatedBuilder(
              animation: nextAnimationController,
              builder: (context, child) {
                return FadeTransition(
                  opacity: nextAnimation,
                  child: Transform(
                    transform: Matrix4.translationValues(100 * (1.0 - nextAnimation.value), 0.0, 0.0),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            ref.read(abilityProvider.notifier).improveAbility(
                                  fall ? ability : ability.copyWith(exp: ability.exp + plusExp),
                                  improveAbility,
                                );
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blueGrey,
                          ),
                          child: const Text("回首頁", style: TextStyle(fontSize: 18)),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  ListTile buildListTile(String title, int ability, int improveAbility, double index) {
    return ListTile(
      contentPadding: const EdgeInsetsDirectional.symmetric(horizontal: 6),
      title: Row(
        children: [
          Expanded(child: Text('$title: $ability', style: const TextStyle(fontSize: 18))),
          FadeTransition(
            opacity: Tween<double>(begin: 0, end: 1).animate(
              CurvedAnimation(
                parent: improveAnimationController,
                curve: Interval(index / 6, (index + 1) / 6, curve: Curves.easeIn),
              ),
            ),
            child: Text('+$improveAbility', style: const TextStyle(fontSize: 18, color: Colors.green)),
          ),
        ],
      ),
    );
  }
}
