import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:rpg/provider/quiz.dart';

class CalculateView extends ConsumerStatefulWidget {
  const CalculateView({
    Key? key,
    required this.animationController,
  }) : super(key: key);

  final AnimationController animationController;

  @override
  ConsumerState<CalculateView> createState() => _CalculateViewState();
}

class _CalculateViewState extends ConsumerState<CalculateView> with TickerProviderStateMixin {
  late AnimationController _fadeAnimaionController;

  static const textList = ['差強人意 (´-ω-｀)', '再接再厲 (๑•̀ㅂ•́)و✧', '表現優異 (*´▽`*)', '才華橫溢 d(`･∀･)b', '完美發揮 ヽ(●´∀`●)ﾉ'];
  static const lottieList = ['sasuke', 'sakura', 'good-job', 'kakashi', 'lucia'];

  @override
  void initState() {
    super.initState();
    _fadeAnimaionController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));
  }

  @override
  void dispose() {
    _fadeAnimaionController.dispose();
    super.dispose();
  }

  Animation<Offset> createSlideAnimation(double begin, double end, double startInterval, double endInterval) {
    return Tween<Offset>(begin: Offset(begin, 0), end: Offset(end, 0)).animate(
      CurvedAnimation(
        parent: widget.animationController,
        curve: Interval(startInterval, endInterval, curve: Curves.fastOutSlowIn),
      ),
    );
  }

  Animation<double> createFadeAnimation(double startInterval, double endInterval) {
    return Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _fadeAnimaionController,
        curve: Interval(startInterval, endInterval, curve: Curves.easeIn),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: createSlideAnimation(0, -2, 2 / 3, 1),
      child: (ref.watch(quizProvider).totalScore != null) ? buildCalculate() : buildLoading(),
    );
  }

  Widget buildLoading() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SlideTransition(
          position: createSlideAnimation(2, 0, 1 / 3, 2 / 3),
          child: Lottie.asset('assets/lottie/animation-elf.json', height: 200),
        ),
        SlideTransition(
          position: createSlideAnimation(3, 0, 1 / 3, 2 / 3),
          child: const Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text(
                "成績結算中...",
                style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildCalculate() {
    _fadeAnimaionController.forward();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FadeTransition(
          opacity: createFadeAnimation(0, 0.2),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  textList[(ref.watch(quizProvider).totalScore ?? 0) ~/ 25],
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ),
              Lottie.asset('assets/lottie/${lottieList[(ref.watch(quizProvider).totalScore ?? 0) ~/ 25]}.json', height: 180),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(fontSize: 36, color: Colors.blue),
                    children: [
                      TextSpan(
                        text: ref.watch(quizProvider).totalScore.toString(),
                        style: const TextStyle(fontSize: 56),
                      ),
                      const TextSpan(text: ' /100')
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        FadeTransition(
          opacity: createFadeAnimation(0.2, 0.4),
          child: buildListTile(Icons.thumb_up_alt_outlined, Colors.green, '完美答題數 ', 10),
        ),
        FadeTransition(
          opacity: createFadeAnimation(0.4, 0.6),
          child: buildListTile(Icons.tips_and_updates_outlined, Colors.amber, '提示答題數 ', 5),
        ),
        FadeTransition(
          opacity: createFadeAnimation(0.6, 0.8),
          child: buildListTile(Icons.dangerous_outlined, Colors.grey, '未答題數 ', 0),
        ),
        AnimatedBuilder(
          animation: _fadeAnimaionController,
          builder: (context, child) {
            final btnAnimation = createFadeAnimation(0.8, 1);
            return FadeTransition(
              opacity: btnAnimation,
              child: Transform(
                transform: Matrix4.translationValues(150 * (1.0 - btnAnimation.value), 0.0, 0.0),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        widget.animationController.animateTo(1);
                        ref.read(quizProvider.notifier).getExp();
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blueGrey,
                      ),
                      child: const Text("Next", style: TextStyle(fontSize: 18)),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  ListTile buildListTile(IconData iconData, Color color, String title, int standard) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 40),
      leading: Icon(iconData, size: 30, color: color),
      title: Text(title, style: TextStyle(fontSize: 24, color: color)),
      trailing: Text(
        '${ref.watch(quizProvider).words.where((e) => e.score == standard).length}',
        style: TextStyle(fontSize: 24, color: color, fontWeight: FontWeight.bold),
      ),
    );
  }
}
