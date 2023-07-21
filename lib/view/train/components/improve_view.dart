import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:rpg/entity/abilities_entity.dart';
import 'package:rpg/helper/hex_color.dart';
import 'package:rpg/provider/abilities_provider.dart';
import 'package:rpg/provider/word_provider.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

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
  bool fall = false;
  late AbilitiesEntity ability;

  late AnimationController fadeAnimationController =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
  late AnimationController levelUpAnimationController =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 600));

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      ability = ref.watch(abilitiesProvider);
    });
    super.initState();
  }

  @override
  void dispose() {
    fadeAnimationController.dispose();
    levelUpAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return (ref.watch(wordProvider).exp != null && widget.animationController.value == 1)
        ? buildSlideTransition()
        : buildColumn();
  }

  Widget buildColumn() {
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

  SlideTransition buildSlideTransition() {
    fadeAnimationController.forward();
    final plusExp = ref.watch(wordProvider).exp ?? 0;
    return SlideTransition(
      position: Tween<Offset>(begin: const Offset(2, 0), end: const Offset(0, 0)).animate(CurvedAnimation(
        parent: widget.animationController,
        curve: const Interval(0.666, 1, curve: Curves.fastOutSlowIn),
      )),
      child: FadeTransition(
        opacity: Tween<double>(begin: 0.0, end: 1.0)
            .animate(CurvedAnimation(parent: fadeAnimationController, curve: Curves.easeIn)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text('本次獲得 +$plusExp Exp', style: const TextStyle(fontSize: 24)),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(
                '距離下一級還需 ${(ability.expL - plusExp) < 0 ? 0 : ability.expL - plusExp} Exp',
                style: const TextStyle(fontSize: 24),
              ),
            ),
            TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 1500),
              curve: Curves.easeInOut,
              tween: Tween<double>(
                begin: ability.exp / ability.expL,
                end: ((ability.exp + plusExp) / ability.expL) >= 1 ? 1.1 : (ability.exp + plusExp) / ability.expL,
              ),
              builder: (context, value, _) {
                final waterHeight = 1 - value;
                if (waterHeight < -0.1 && !fall) {
                  fall = !fall;
                  levelUpAnimationController.forward().then((value) {
                    // 計算升等公式
                    int lastExp = plusExp - ref.watch(abilitiesProvider).expL;
                    int newLv = ability.lv + 1;
                    int nextExpL = (((newLv - 1) ^ 3 + 60) / 5 * ((newLv - 1) * 2 + 60) + 60).floor();
                    nextExpL = (50 - (nextExpL % 50).floor()) + nextExpL;
                    while (lastExp > nextExpL) {
                      lastExp -= nextExpL;
                      newLv++;
                      nextExpL = (((newLv - 1) ^ 3 + 60) / 5 * ((newLv - 1) * 2 + 60) + 60).floor();
                      nextExpL = (50 - (nextExpL % 50).floor()) + nextExpL;
                    }
                    // 修改數值
                    ability = ability.copyWith(lv: newLv, expL: nextExpL);
                    ref.read(wordProvider.notifier).lastExp(lastExp);
                    levelUpAnimationController.reverse();
                  });
                }
                return ScaleTransition(
                  scale: Tween<double>(begin: 1.0, end: 1.1).animate(CurvedAnimation(
                    parent: levelUpAnimationController,
                    curve: Curves.easeOut,
                  )),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.blue.withAlpha(40), width: 2),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey.withAlpha(30), width: 2),
                          ),
                          child: ClipOval(
                            child: WaveWidget(
                              config: CustomConfig(
                                colors: [HexColor('FDD1E9FB'), HexColor('FFC8E7FB'), HexColor('FFBBDEFB')],
                                durations: [5000, 4000, 3000],
                                heightPercentages: [waterHeight, waterHeight + 0.01, waterHeight + 0.02],
                              ),
                              backgroundColor: Colors.white,
                              size: const Size(double.infinity, double.infinity),
                              waveAmplitude: 0,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        'lv ${ability.lv}',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 32, color: Colors.black54),
                      ),
                    ],
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(ability.userName!, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      const Icon(Icons.military_tech_outlined, color: Colors.grey),
                      Text(ability.role!, style: const TextStyle(fontSize: 20, color: Colors.grey)),
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
                  padding: const EdgeInsets.only(top: 12, left: 12),
                  child: DefaultTextStyle(
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                    child: GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      childAspectRatio: 1 / 0.3,
                      children: [
                        Text('血量: ${ability.hp}'),
                        Text('魔力: ${ability.mp}'),
                        Text('攻擊: ${ability.atk}'),
                        Text('防禦: ${ability.def}'),
                        Text('敏捷: ${ability.agi}'),
                        Text('幸運: ${ability.luk}'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blueGrey,
                  ),
                  child: const Text("回首頁", style: TextStyle(fontSize: 18)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
