import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rpg/provider/ability.dart';
import 'package:rpg/router/routes.dart';
import 'package:rpg/utils/app_localizations.dart';

class MenuToolView extends ConsumerStatefulWidget {
  const MenuToolView({
    Key? key,
    required this.mainAnimationController,
    required this.pageAnimationController,
    required this.mainAnimation,
  }) : super(key: key);

  final AnimationController mainAnimationController;
  final AnimationController pageAnimationController;
  final Animation<double> mainAnimation;

  @override
  ConsumerState<MenuToolView> createState() => _MenuViewState();
}

class _MenuViewState extends ConsumerState<MenuToolView> with TickerProviderStateMixin {
  late AnimationController animationController;
  late AppLocalizations _str;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(duration: const Duration(milliseconds: 1200), vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _str = L10n.of(context)!;
  }

  @override
  dispose() {
    animationController.dispose();
    super.dispose();
  }

  Widget buildCard(Color color1, Color color2, String title, VoidCallback onTap, String image, Animation<double> animation) {
    animationController.forward();
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(100 * (1.0 - animation.value), 0.0, 0.0),
            child: InkWell(
              onTap: onTap,
              child: Stack(
                children: [
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [color1, color2],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: double.infinity,
                      height: 90,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Expanded(flex: 1, child: SizedBox()),
                          Expanded(
                            flex: 2,
                            child: Text(
                              title,
                              style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 5,
                    child: Image.asset(image, width: 100, height: 100),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _dialog(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.white,
      title: const Column(
        children: [
          Icon(Icons.report_problem_outlined, size: 48),
          Text('重生警告', style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      content: Builder(
        builder: (context) {
          return const SizedBox(
            width: 400,
            child: Text(
              '確認後當前資料將被銷毀，是否執行重生?',
              style: TextStyle(fontSize: 16),
            ),
          );
        },
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, 'welcome');
            ref.read(abilityProvider.notifier).removeData();
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
                  buildCard(
                    Colors.blue.shade300,
                    Colors.blue.shade200,
                    _str.change_name,
                    () => widget.pageAnimationController.forward(),
                    'assets/image/Eevee.png',
                    Tween<double>(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                        parent: animationController,
                        curve: const Interval((1 / 3) * 0, 1.0, curve: Curves.fastOutSlowIn),
                      ),
                    ),
                  ),
                  buildCard(
                    Colors.green.shade200,
                    Colors.green.shade400,
                    _str.change_language,
                    () => Navigator.of(context).pushNamed(localesUrl),
                    'assets/image/Eevee1.png',
                    Tween<double>(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                        parent: animationController,
                        curve: const Interval((1 / 3) * 1, 1.0, curve: Curves.fastOutSlowIn),
                      ),
                    ),
                  ),
                  buildCard(
                    Colors.pink.shade300,
                    Colors.pink.shade200,
                    _str.character_rebirth,
                    () => showGeneralDialog(
                      context: context,
                      pageBuilder: (ctx, a1, a2) => const SizedBox(),
                      transitionBuilder: (ctx, a1, a2, child) {
                        final curve = Curves.easeInOut.transform(a1.value);
                        return Transform.scale(
                          scale: curve,
                          child: _dialog(ctx),
                        );
                      },
                      transitionDuration: const Duration(milliseconds: 300),
                    ),
                    'assets/image/Eevee2.png',
                    Tween<double>(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                        parent: animationController,
                        curve: const Interval((1 / 3) * 2, 1.0, curve: Curves.fastOutSlowIn),
                      ),
                    ),
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
