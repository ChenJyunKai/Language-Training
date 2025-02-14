import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rpg/constants/home_button_data.dart';
import 'package:rpg/utils/app_localizations.dart';
import 'package:rpg/utils/app_theme.dart';
import 'package:rpg/utils/hex_color.dart';

class HomeButton extends StatefulWidget {
  const HomeButton({
    Key? key,
    required this.animationController,
    required this.data,
  }) : super(key: key);

  final AnimationController animationController;
  final HomeButtonEntity data;

  @override
  State<HomeButton> createState() => _HomeButtonState();
}

class _HomeButtonState extends State<HomeButton> {
  late Animation<double> _animation;
  late AppLocalizations _str;
  late List<String> _title;

  @override
  void initState() {
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: widget.animationController,
        curve: Interval((1 / 4) * widget.data.index, 1.0, curve: Curves.fastOutSlowIn),
      ),
    );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _str = L10n.of(context)!;
    _title = [_str.exercise, _str.skill, _str.battle, _str.setting];
  }

  @override
  void dispose() {
    widget.animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _animation,
          child: Transform(
            transform: Matrix4.translationValues(100 * (1.0 - _animation.value), 0.0, 0.0),
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(context, widget.data.navigatorUrl!),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: HexColor(widget.data.startColor).withOpacity(0.6),
                            offset: const Offset(1.1, 4.0),
                            blurRadius: 8.0,
                          ),
                        ],
                        gradient: LinearGradient(
                          colors: <HexColor>[HexColor(widget.data.startColor), HexColor(widget.data.endColor)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 70, left: 16, right: 24, bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              _title[widget.data.index],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontFamily: AppTheme.fontName,
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                letterSpacing: 0.2,
                                color: AppTheme.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: AppTheme.nearlyWhite.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned(
                    top: widget.data.imageTopPosition,
                    left: widget.data.imageLeftPosition,
                    child: SizedBox(
                      width: widget.data.imageSize,
                      height: 180,
                      child: Lottie.asset(widget.data.imagePath),
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
