import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:rpg/provider/word_provider.dart';

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
  @override
  Widget build(BuildContext context) {
    return (ref.watch(wordProvider).exp != null && widget.animationController.value == 1)
        ? buildSlideTransition()
        : buildColumn();
  }

  SlideTransition buildSlideTransition() {
    return SlideTransition(
          position: Tween<Offset>(begin: const Offset(2, 0), end: const Offset(0, 0)).animate(CurvedAnimation(
            parent: widget.animationController,
            curve: const Interval(0.666, 1, curve: Curves.fastOutSlowIn),
          )),
          child: Center(
            child: SizedBox(
              width: 200,
              child: TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 1000),
                curve: Curves.easeInOut,
                tween: Tween<double>(
                  begin: 0,
                  end: 1,
                ),
                builder: (context, value, _) => LinearProgressIndicator(value: value),
              ),
            ),
          ),
        );
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
          child: Lottie.asset('assets/lottie/rikka.json', height: 200),
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
                "123結算中...",
                style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
