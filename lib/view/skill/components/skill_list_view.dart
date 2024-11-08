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

  Widget _dialog(BuildContext context, SkillEntity skill) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Column(
        children: [
          Icon(skill.level == 0 ? Icons.lock_open_outlined : Icons.add_chart_outlined, size: 48),
          Text('${skill.level == 0 ? '解鎖' : '升級'}提示', style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      content: Builder(
        builder: (context) {
          return SizedBox(
            width: 400,
            child: Text(
              '將對【 ${skill.skillName} 】進行${skill.level == 0 ? '解鎖' : '升級'}，確認後將消耗1技能點',
              style: const TextStyle(fontSize: 16),
            ),
          );
        },
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            ref.read(abilityProvider.notifier).skillUpgrade(skill);
            Navigator.of(context).pop();
          },
          child: const Text("確定"),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            "取消",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }

  Widget buildSkill(Animation<double> animation, SkillEntity skill) {
    final color = skill.level == 0
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
                          skill.level > 0
                              ? Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: Text('LV. ${skill.level == 5 ? 'Max' : skill.level}'),
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
                    onPressed: skill.level == 5
                        ? null
                        : ref.watch(abilityProvider).sp > 0
                            ? () => showGeneralDialog(
                                  context: context,
                                  pageBuilder: (ctx, a1, a2) => const SizedBox(),
                                  transitionBuilder: (ctx, a1, a2, child) {
                                    final curve = Curves.easeInOut.transform(a1.value);
                                    return Transform.scale(
                                      scale: curve,
                                      child: _dialog(ctx, skill),
                                    );
                                  },
                                  transitionDuration: const Duration(milliseconds: 300),
                                )
                            : () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('技能點不足'))),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.black,
                      visualDensity: VisualDensity.compact,
                    ),
                    icon: Icon(skill.level > 0 ? Icons.upload_outlined : Icons.lock_open_outlined),
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
                  for (final skill in ref.watch(abilityProvider).skill)
                    buildSkill(
                      Tween<double>(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                          parent: animationController,
                          curve: Interval(
                            (1 / 5) * ((ref.watch(abilityProvider).skill.indexWhere((e) => e.skillCode == skill.skillCode) + 1)),
                            1.0,
                            curve: Curves.fastOutSlowIn,
                          ),
                        ),
                      ),
                      skill,
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
