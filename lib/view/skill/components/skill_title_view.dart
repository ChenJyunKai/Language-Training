import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:rpg/provider/ability.dart';

class SkillTitleView extends ConsumerStatefulWidget {
  const SkillTitleView({
    Key? key,
    required this.mainAnimationController,
    required this.mainAnimation,
  }) : super(key: key);

  final AnimationController mainAnimationController;
  final Animation<double> mainAnimation;

  @override
  ConsumerState<SkillTitleView> createState() => _SkillTitleViewState();
}

class _SkillTitleViewState extends ConsumerState<SkillTitleView> {
  @override
  Widget build(BuildContext context) {
    final ability = ref.watch(abilityProvider);
    return AnimatedBuilder(
      animation: widget.mainAnimationController,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.mainAnimation,
          child: Transform(
            transform: Matrix4.translationValues(0.0, 30 * (1.0 - widget.mainAnimation.value), 0.0),
            child: Column(
              children: <Widget>[
                Stack(
                  clipBehavior: Clip.none,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            offset: const Offset(1.1, 1.1),
                            blurRadius: 10.0,
                          ),
                        ],
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        height: 160,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 220, top: 16),
                              child: Text(
                                ability.userName!,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  letterSpacing: 0.0,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 220, bottom: 20, top: 4),
                              child: Text(
                                ability.role!,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  letterSpacing: 0.0,
                                  color: Colors.black45,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: -8,
                      left: 6,
                      child: SizedBox(
                        width: 180,
                        height: 180,
                        child: Lottie.asset(ability.roleData!.imageAsset!),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
