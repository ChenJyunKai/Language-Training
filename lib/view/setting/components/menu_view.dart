import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rpg/helper/screen_size.dart';

class MenuView extends StatelessWidget {
  const MenuView({
    super.key,
    required this.animationController,
    required this.renameSet,
  });

  final AnimationController animationController;
  final VoidCallback renameSet;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(begin: const Offset(0, 0), end: const Offset(-1, 0)).animate(CurvedAnimation(
        parent: animationController,
        curve: Curves.easeIn,
      )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Text(
              '系統設定',
              style: TextStyle(
                fontSize: 42,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Lottie.asset(
            'assets/lottie/animation-elf.json',
            height: 200,
            width: screenWidth,
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            height: 50,
            width: screenWidth * 0.7,
            child: ElevatedButton(
              onPressed: () {
                // 卡控
                if(animationController.value == 0){
                  animationController.forward();
                  renameSet();
                }
              },
              style: ElevatedButton.styleFrom(
                surfaceTintColor: Colors.transparent,
                foregroundColor: Colors.green[300],
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                side: const BorderSide(color: Colors.green),
              ),
              child: const Text('更改名稱', style: TextStyle(fontSize: 20)),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            height: 50,
            width: screenWidth * 0.7,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                surfaceTintColor: Colors.transparent,
                foregroundColor: Colors.red[300],
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                side: const BorderSide(color: Colors.red),
              ),
              child: const Text('角色重生', style: TextStyle(fontSize: 20)),
            ),
          ),
        ],
      ),
    );
  }
}
