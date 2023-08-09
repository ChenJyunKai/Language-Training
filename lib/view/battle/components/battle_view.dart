import 'package:flutter/material.dart';
import 'package:rpg/helper/screen_size.dart';

class BattleView extends StatefulWidget {
  const BattleView({Key? key}) : super(key: key);

  @override
  State<BattleView> createState() => _BattleViewState();
}

class _BattleViewState extends State<BattleView> {
  List<bool> selectedList = List<bool>.filled(4, false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Expanded(
            flex: 1,
            child: SizedBox(),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: List.generate(4, (i) {
                  return AnimatedPositioned(
                    duration: const Duration(milliseconds: 500),
                    top: selectedList[i] ? 25 : (i < 2 ? 0 : screenHeight / 8),
                    left: selectedList[i] ? screenWidth / 3 - 40 : (i % 2 == 1 ? 0 : screenWidth / 2 - 20),
                    child: Card(
                      child: SizedBox(
                        width: screenWidth * 0.4,
                        height: 80,
                        child: ListTile(
                          onTap: () => setState(() => selectedList[i] = !selectedList[i]),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
