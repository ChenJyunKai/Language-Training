import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rpg/utils/time_format.dart';

class MenuTitleView extends StatefulWidget {
  const MenuTitleView({
    Key? key,
    required this.mainAnimationController,
    required this.mainAnimation,
  }) : super(key: key);

  final AnimationController mainAnimationController;
  final Animation<double> mainAnimation;

  @override
  State<MenuTitleView> createState() => _MenuTitleViewState();
}

class _MenuTitleViewState extends State<MenuTitleView> {
  late Timer _timer;
  late DateTime _currentTime;

  @override
  void initState() {
    super.initState();
    _currentTime = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        _currentTime = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.mainAnimationController,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.mainAnimation,
          child: Transform(
            transform: Matrix4.translationValues(0.0, 30 * (1.0 - widget.mainAnimation.value), 0.0),
            child: SizedBox(
              height: 240,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Positioned(
                    top: 0,
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.lightBlue.withAlpha(45),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: MediaQuery.of(context).size.width - 120,
                        height: 100,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 20,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.lightBlue.withAlpha(75).withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: MediaQuery.of(context).size.width - 80,
                      height: 100,
                    ),
                  ),
                  Card(
                    elevation: 3,
                    child: CustomPaint(
                      size: Size(MediaQuery.of(context).size.width, 200), // 自訂方塊的大小
                      painter: WaveBoxPainter(),
                    ),
                  ),
                  Positioned(
                    top: -20,
                    right: 10,
                    child: Image.asset(
                      'assets/image/pikachu_surf.png',
                      width: 200,
                      height: 200,
                    ),
                  ),
                  Positioned(
                    bottom: 40,
                    left: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          TimeFormat().local('yyyy-MM-dd EEEE', _currentTime),
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          TimeFormat().local('HH:mm', _currentTime),
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
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
    );
  }
}

class WaveBoxPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..shader = LinearGradient(
        colors: [Colors.lightBlue[400]!, Colors.lightBlue[100]!],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    Path path = Path()
      ..moveTo(0, 10) // 左上角從圓角開始
      ..quadraticBezierTo(0, 0, 10, 0) // 左上圓角
      ..lineTo(size.width - 10, 0) // 上邊直線
      ..quadraticBezierTo(size.width, 0, size.width, 10) // 右上圓角
      ..lineTo(size.width, size.height - 30) // 右邊直線到波浪
      ..quadraticBezierTo(size.width * 0.75, size.height + 5, size.width * 0.5, size.height - 15) // 第二道波
      ..quadraticBezierTo(size.width * 0.25, size.height - 35, 0, size.height - 15) // 第一道波
      ..lineTo(0, 20) // 左邊直線到圓角
      ..close(); // 封閉路徑

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false; // 不需要重繪
  }
}
