import 'package:flutter/material.dart';

class BattleView extends StatefulWidget {
  const BattleView({Key? key}) : super(key: key);

  @override
  State<BattleView> createState() => _BattleViewState();
}

class _BattleViewState extends State<BattleView> with TickerProviderStateMixin {
  List<bool> selectedList = List<bool>.filled(4, false);

  List<AnimationController> scales = [];
  List<AnimationController> fades = [];
  late AnimationController slide;
  late AnimationController rotation;
  bool isSelected = false;

  @override
  void initState() {
    for (int i = 0; i < 4; i++) {
      scales.add(AnimationController(vsync: this, duration: const Duration(milliseconds: 600)));
      fades.add(AnimationController(vsync: this, duration: const Duration(milliseconds: 300)));
      slide = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));
      rotation = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    }
    super.initState();
  }

  @override
  void dispose() {
    for (final controller in [...scales, ...fades, slide, rotation]) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              const Expanded(
                flex: 1,
                child: SizedBox(),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  // 向上飄移
                  child: SlideTransition(
                    position: Tween<Offset>(begin: const Offset(0, 0), end: const Offset(0, -1)).animate(
                      CurvedAnimation(
                        parent: slide,
                        curve: Curves.fastOutSlowIn,
                      ),
                    ),
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: List.generate(4, (i) {
                        // 選中的置中
                        return AnimatedPositioned(
                          duration: const Duration(milliseconds: 500),
                          top: selectedList[i] ? 40 : (i < 2 ? 0 : constraints.maxHeight / 8),
                          left:
                              selectedList[i] ? constraints.maxWidth / 3 - 40 : (i % 2 == 1 ? 0 : constraints.maxWidth / 2 - 20),
                          // 放大
                          child: ScaleTransition(
                            scale: Tween<double>(begin: 1.0, end: 1.6).animate(CurvedAnimation(
                              parent: scales[i],
                              curve: Curves.fastOutSlowIn,
                            )),
                            // 沒選中的消失
                            child: FadeTransition(
                              opacity: Tween<double>(begin: 1.0, end: 0.0).animate(fades[i]),
                              // 正確時旋轉
                              child: RotationTransition(
                                turns: Tween<double>(begin: 0, end: 1).animate(
                                  CurvedAnimation(parent: rotation, curve: Curves.easeInOutExpo),
                                ),
                                child: AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 500),
                                  transitionBuilder: (Widget child, Animation<double> animation) {
                                    return ScaleTransition(scale: animation, child: child);
                                  },
                                  child: isSelected
                                      ? buildAction(i, constraints.maxWidth * 0.4)
                                      : buildCard(i, constraints.maxWidth * 0.4),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Card buildCard(int i, double width) {
    return Card(
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.black12),
        borderRadius: BorderRadius.circular(10),
      ),
      child: SizedBox(
        width: width,
        height: 80,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            setState(() => selectedList[i] = !selectedList[i]);
            scales[i].forward().then((_) {
              rotation.forward().then((_) {
                //縮小向上消失
                scales[i].reverse();
                slide.forward();
              });
            });
            for (int j = 0; j < 4; j++) {
              if (j != i) {
                fades[j].forward();
              }
            }
          },
          child: const ListTile(),
        ),
      ),
    );
  }

  Widget buildAction(int i, double width) {
    return Container(
      alignment: Alignment.center,
      width: width,
      height: 85,
      child: Container(
        height: 50,
        width: 50,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey,
        ),
      ),
    );
  }
}
