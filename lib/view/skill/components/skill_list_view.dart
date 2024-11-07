import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rpg/entity/skill_entity.dart';
import 'package:rpg/provider/ability.dart';

class SkillListView extends ConsumerStatefulWidget {
  const SkillListView({
    Key? key,
    required this.mainAnimationController,
    required this.mainAnimation,
  }) : super(key: key);

  final AnimationController mainAnimationController;
  final Animation<double> mainAnimation;

  @override
  ConsumerState<SkillListView> createState() => _SkillListViewState();
}

class _SkillListViewState extends ConsumerState<SkillListView> with TickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(duration: const Duration(milliseconds: 1400), vsync: this);
    animationController.forward();
  }

  @override
  dispose() {
    animationController.dispose();
    super.dispose();
  }

  Widget buildSkill(Animation<double> animation, SkillEntity skill, int skillLv) {
    final color = skillLv == 0
        ? Colors.black
        : skill.skillType == SkillType.attack
            ? Colors.red
            : skill.skillType == SkillType.gain
                ? Colors.blue
                : Colors.green;
    final icon = Icon(
      skill.skillType == SkillType.attack
          ? Icons.bolt_outlined
          : skill.skillType == SkillType.gain
              ? Icons.shield_outlined
              : Icons.audiotrack_outlined,
      color: color,
      size: 40,
    );

    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(100 * (1.0 - animation.value), 0.0, 0.0),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color.withOpacity(0.2), color.withOpacity(0.3)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                width: double.infinity,
                height: 90,
                child: ListTile(
                  contentPadding: const EdgeInsets.only(left: 20, right: 10),
                  leading: icon,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            skill.skillName,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          skillLv > 0
                              ? Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: Text('LV. ${skillLv == 5 ? 'Max' : skillLv}'),
                                )
                              : const SizedBox(),
                          const Icon(Icons.hourglass_empty_outlined, size: 18),
                          Text(skill.coolDown.toString()),
                        ],
                      )
                    ],
                  ),
                  subtitle: Text(skill.skillDescription),
                  trailing: IconButton(
                    onPressed: skillLv == 5 ? null : () {},
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.black,
                      visualDensity: VisualDensity.compact,
                    ),
                    icon: Icon(skillLv > 0 ? Icons.upload_outlined : Icons.lock_open_outlined),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final skillLv = ref.watch(abilityProvider).skillLv;
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: AnimatedBuilder(
        animation: widget.mainAnimationController,
        builder: (BuildContext context, Widget? child) {
          return FadeTransition(
            opacity: widget.mainAnimation,
            child: Transform(
              transform: Matrix4.translationValues(0.0, 30 * (1.0 - widget.mainAnimation.value), 0.0),
              child: Column(
                children: [
                  buildSkill(
                    Tween<double>(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                        parent: animationController,
                        curve: const Interval((1 / 5) * 1, 1.0, curve: Curves.fastOutSlowIn),
                      ),
                    ),
                    SkillEntity(
                      skillName: '斬擊',
                      skillDescription: '強力打擊敵人造成物理傷害',
                      levelRestriction: 0,
                      coolDown: 3,
                      skillType: SkillType.attack,
                    ),
                    skillLv[0],
                  ),
                  buildSkill(
                    Tween<double>(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                        parent: animationController,
                        curve: const Interval((1 / 5) * 2, 1.0, curve: Curves.fastOutSlowIn),
                      ),
                    ),
                    SkillEntity(
                      skillName: '橫揮斬',
                      skillDescription: '揮動武器對全體敵人造成物理傷害',
                      levelRestriction: 0,
                      coolDown: 3,
                      skillType: SkillType.attack,
                    ),
                    skillLv[1],
                  ),
                  buildSkill(
                    Tween<double>(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                        parent: animationController,
                        curve: const Interval((1 / 5) * 3, 1.0, curve: Curves.fastOutSlowIn),
                      ),
                    ),
                    SkillEntity(
                      skillName: '守護',
                      skillDescription: '短時間增加施術者的防禦數值',
                      levelRestriction: 0,
                      coolDown: 3,
                      skillType: SkillType.gain,
                    ),
                    skillLv[2],
                  ),
                  buildSkill(
                    Tween<double>(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                        parent: animationController,
                        curve: const Interval((1 / 5) * 4, 1.0, curve: Curves.fastOutSlowIn),
                      ),
                    ),
                    SkillEntity(
                      skillName: '治療術',
                      skillDescription: '恢復自身失去的部分生命值',
                      levelRestriction: 0,
                      coolDown: 3,
                      skillType: SkillType.recovery,
                    ),
                    skillLv[3],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
