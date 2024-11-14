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

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween(begin: const Offset(0, 0), end: const Offset(-2, 0)).animate(CurvedAnimation(
        parent: widget.animationController,
        curve: const Interval(2 / 3, 1, curve: Curves.fastOutSlowIn),
      )),
      child: (ref.watch(quizProvider).totalScore != null) ? calulate() : buildColumn(),
    );
  }

  Widget buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SlideTransition(
          position: Tween(begin: const Offset(2, 0), end: const Offset(0, 0)).animate(CurvedAnimation(
            parent: widget.animationController,
            curve: const Interval(1 / 3, 2 / 3, curve: Curves.fastOutSlowIn),
          )),
          child: Lottie.asset('assets/lottie/animation-elf.json', height: 200),
        ),
        SlideTransition(
          position: Tween(begin: const Offset(3, 0), end: const Offset(0, 0)).animate(CurvedAnimation(
            parent: widget.animationController,
            curve: const Interval(1 / 3, 2 / 3, curve: Curves.fastOutSlowIn),
          )),
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

  Widget calulate() {
    _fadeAnimaionController.forward();
    return SlideTransition(
      position: Tween(begin: const Offset(2, 0), end: const Offset(0, 0)).animate(CurvedAnimation(
        parent: widget.animationController,
        curve: const Interval(1 / 3, 2 / 3, curve: Curves.fastOutSlowIn),
      )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeTransition(
            opacity: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
              parent: _fadeAnimaionController,
              curve: const Interval(0, 0.2, curve: Curves.easeIn),
            )),
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
            opacity: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
              parent: _fadeAnimaionController,
              curve: const Interval(0.2, 0.4, curve: Curves.easeIn),
            )),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 40),
              leading: const Icon(
                Icons.thumb_up_alt_outlined,
                size: 30,
                color: Colors.green,
              ),
              title: const Text('完美答題數 ', style: TextStyle(fontSize: 24, color: Colors.green)),
              trailing: Text(
                '${ref.watch(quizProvider).words.where((e) => e.score == 10).length}',
                style: const TextStyle(fontSize: 24, color: Colors.green, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          FadeTransition(
            opacity: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
              parent: _fadeAnimaionController,
              curve: const Interval(0.4, 0.6, curve: Curves.easeIn),
            )),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 40),
              leading: const Icon(
                Icons.tips_and_updates_outlined,
                size: 30,
                color: Colors.amber,
              ),
              title: const Text('提示答題數 ', style: TextStyle(fontSize: 24, color: Colors.amber)),
              trailing: Text(
                '${ref.watch(quizProvider).words.where((e) => e.score == 5).length}',
                style: const TextStyle(fontSize: 24, color: Colors.amber, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          FadeTransition(
            opacity: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
              parent: _fadeAnimaionController,
              curve: const Interval(0.6, 0.8, curve: Curves.easeIn),
            )),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 40),
              leading: const Icon(
                Icons.dangerous_outlined,
                size: 30,
                color: Colors.grey,
              ),
              title: const Text('未答題數 ', style: TextStyle(fontSize: 24, color: Colors.grey)),
              trailing: Text(
                '${ref.watch(quizProvider).words.where((e) => e.score == 0).length}',
                style: const TextStyle(fontSize: 24, color: Colors.grey, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          AnimatedBuilder(
            animation: _fadeAnimaionController,
            builder: (context, child) {
              final btnAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                parent: _fadeAnimaionController,
                curve: const Interval(0.8, 1, curve: Curves.easeIn),
              ));
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
      ),
    );
  }
}
