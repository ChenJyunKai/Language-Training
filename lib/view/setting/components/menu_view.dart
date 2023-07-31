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

  Widget _dialog(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.white,
      title: const Column(
        children: [
          Icon(Icons.report_problem_outlined, size: 48),
          Text('重生警告', style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      content: Builder(
        builder: (context) {
          return SizedBox(
            width: screenWidth * 0.5,
            child: const Text(
              '確認後當前資料將被銷毀，是否執行重生?',
              style: TextStyle(fontSize: 16),
            ),
          );
        },
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pushNamed(context, 'welcome'),
          child: const Text("確定"),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            "取消",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }

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
                if (animationController.value == 0) {
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
              onPressed: () => showGeneralDialog(
                context: context,
                pageBuilder: (ctx, a1, a2) => const SizedBox(),
                transitionBuilder: (ctx, a1, a2, child) {
                  final curve = Curves.easeInOut.transform(a1.value);
                  return Transform.scale(
                    scale: curve,
                    child: _dialog(ctx),
                  );
                },
                transitionDuration: const Duration(milliseconds: 300),
              ),
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
