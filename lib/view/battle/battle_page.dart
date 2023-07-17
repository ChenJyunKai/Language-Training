import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rpg/entity/language_entity.dart';
import 'package:rpg/provider/word_provider.dart';
import 'package:rpg/view/battle/components/quiz_view.dart';
import 'package:rpg/view/battle/components/rule_view.dart';
import 'package:rpg/view/battle/components/select_language.dart';

class BattlePage extends ConsumerStatefulWidget {
  const BattlePage({Key? key}) : super(key: key);

  @override
  ConsumerState<BattlePage> createState() => _BattlePageState();
}

class _BattlePageState extends ConsumerState<BattlePage> with TickerProviderStateMixin {
  bool _fade = true;
  late Future getData = ref.read(wordProvider.notifier).getData();
  late Language language;
  late AnimationController animationController = AnimationController(vsync: this, duration: const Duration(seconds: 2));
  late AnimationController fadeAnimationController =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 600));

  @override
  void dispose() {
    animationController.dispose();
    fadeAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Speech Demo'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getData,
        builder: (context, snapShot) {
          if (snapShot.hasData) {
            return ClipRect(
              child: Stack(
                children: [
                  SelectLanguage(
                    animationController: animationController,
                    select: (x) => setState(() => language = x),
                  ),
                  RuleView(
                    fadeAnimationController: fadeAnimationController,
                    animationController: animationController,
                    fade: _fade,
                    function: () => setState(() => _fade = false),
                  ),
                  QuizView(
                    fadeAnimationController: fadeAnimationController,
                    fade: _fade,
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
