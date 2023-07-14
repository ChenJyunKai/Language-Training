import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rpg/helper/app_theme.dart';
import 'package:rpg/helper/hex_color.dart';
import 'package:rpg/provider/abilities_provider.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class AbilityView extends ConsumerStatefulWidget {
  const AbilityView({Key? key}) : super(key: key);

  @override
  ConsumerState<AbilityView> createState() => _AbilityViewState();
}

class _AbilityViewState extends ConsumerState<AbilityView> {
  @override
  Widget build(BuildContext context) {
    final ability = ref.watch(abilitiesProvider);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black26),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            offset: Offset(1, 1),
            blurRadius: 1,
            color: Colors.grey,
          )
        ],
      ),
      child: DefaultTextStyle(
        style: const TextStyle(
          fontSize: 18,
          fontFamily: AppTheme.fontName,
          color: Colors.black54,
          fontWeight: FontWeight.bold,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.blue.withAlpha(40), width: 2),
                        ),
                        child: Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey.withAlpha(30), width: 2),
                          ),
                          child: ClipOval(
                            child: WaveWidget(
                              config: CustomConfig(
                                colors: [HexColor('FDD1E9FB'), HexColor('FFC8E7FB'), HexColor('FFBBDEFB')],
                                durations: [5000, 4000, 3000],
                                heightPercentages: [0.48, 0.49, 0.5],
                              ),
                              backgroundColor: Colors.white,
                              size: const Size(double.infinity, double.infinity),
                              waveAmplitude: 0,
                            ),
                          ),
                        ),
                      ),
                      Text('lv${ability.lv}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '名稱: ${ability.userName}',
                      style: TextStyle(color: Colors.blueGrey[600]),
                    ),
                    Text('職業: ${ability.role}'),
                  ],
                ),
              ],
            ),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              childAspectRatio: 1 / 0.3,
              children: [
                Text('血量: ${ability.hp}'),
                Text('魔力: ${ability.mp}'),
                Text('攻擊: ${ability.atk}'),
                Text('防禦: ${ability.def}'),
                Text('敏捷: ${ability.agi}'),
                Text('幸運: ${ability.luk}'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
