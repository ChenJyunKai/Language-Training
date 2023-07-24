import 'package:flutter/material.dart';

class TopBackView extends StatelessWidget {
  final AnimationController animationController;
  final VoidCallback onBackClick;

  const TopBackView({
    Key? key,
    required this.onBackClick,
    required this.animationController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final animation = Tween<Offset>(begin: const Offset(0, 0), end: const Offset(0, -1)).animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(0, 1, curve: Curves.easeIn),
    ));

    return SlideTransition(
      position: animation,
      child: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 16),
          child: IconButton(
            onPressed: onBackClick,
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
        ),
      ),
    );
  }
}
