import 'package:flutter/material.dart';
import 'package:rpg/entity/ability_entity.dart';
import 'package:rpg/utils/hex_color.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class LevelView extends StatelessWidget {
  final AnimationController levelUpAnimationController;
  final AnimationController nextAnimationController;
  final AbilityEntity ability;
  final int plusExp;
  final bool fall;
  final VoidCallback handleLevelUp;

  const LevelView({
    super.key,
    required this.levelUpAnimationController,
    required this.nextAnimationController,
    required this.ability,
    required this.plusExp,
    required this.fall,
    required this.handleLevelUp,
  });

  static final waveColors = [HexColor('FDD1E9FB'), HexColor('FFC8E7FB'), HexColor('FFBBDEFB')];
  static const waveDurations = [5000, 4000, 3000];

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 1500),
      curve: Curves.easeInOut,
      tween: Tween<double>(
        begin: fall ? 0 : ability.exp / ability.expL,
        end: (fall ? plusExp : (ability.exp + plusExp)) / ability.expL,
      ),
      onEnd: () => Future.delayed(const Duration(milliseconds: 300), () => nextAnimationController.forward()),
      builder: (context, value, _) => _buildLevelUpView(value),
    );
  }

  Widget _buildLevelUpView(double value) {
    final waterHeight = 1 - value;

    if (waterHeight < -0.1 && !fall) {
      handleLevelUp();
    }

    return ScaleTransition(
      scale: Tween<double>(begin: 1.0, end: 1.1).animate(CurvedAnimation(
        parent: levelUpAnimationController,
        curve: Curves.easeOut,
      )),
      child: Stack(
        alignment: Alignment.center,
        children: [
          _buildWaveContainer(waterHeight),
          Text(
            'lv ${ability.lv}',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 32, color: Colors.black54),
          ),
        ],
      ),
    );
  }

  Widget _buildWaveContainer(double waterHeight) {
    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.blue.withAlpha(40), width: 2),
      ),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey.withAlpha(30), width: 2),
        ),
        child: ClipOval(
          child: WaveWidget(
            config: CustomConfig(
              colors: waveColors,
              durations: waveDurations,
              heightPercentages: [waterHeight, waterHeight + 0.01, waterHeight + 0.02],
            ),
            backgroundColor: Colors.white,
            size: const Size(double.infinity, double.infinity),
            waveAmplitude: 0,
          ),
        ),
      ),
    );
  }
}
