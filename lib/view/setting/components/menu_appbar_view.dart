import 'package:flutter/material.dart';

class MenuAppbarView extends StatelessWidget {
  const MenuAppbarView({
    Key? key,
    required this.animationController,
    required this.topBarOpacity,
    required this.title,
  }) : super(key: key);

  final AnimationController animationController;
  final double topBarOpacity;
  final String title;

  @override
  Widget build(BuildContext context) {
    final topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(0, 0.5, curve: Curves.fastOutSlowIn),
    ));
    return Column(
      children: <Widget>[
        AnimatedBuilder(
          animation: animationController,
          builder: (BuildContext context, Widget? child) {
            return FadeTransition(
              opacity: topBarAnimation,
              child: Transform(
                transform: Matrix4.translationValues(0.0, 30 * (1.0 - topBarAnimation.value), 0.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(topBarOpacity),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(32.0),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.4 * topBarOpacity), offset: const Offset(1.1, 1.1), blurRadius: 10.0),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).padding.top,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 16,
                          right: 16,
                          top: 16 - 4 * topBarOpacity,
                          bottom: 12 - 4 * topBarOpacity,
                        ),
                        child: Row(
                          children: <Widget>[
                            const BackButton(),
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.only(right: 30),
                                child: Text(
                                  title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 28 - 6 * topBarOpacity,
                                    letterSpacing: 1.2,
                                    color: const Color(0xFF253840),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
