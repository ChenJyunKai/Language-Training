import 'dart:async';

import 'package:flutter/material.dart';

class BattlePage extends StatefulWidget {
  const BattlePage({Key? key}) : super(key: key);

  @override
  State<BattlePage> createState() => _BattlePageState();
}

class _BattlePageState extends State<BattlePage> {
  final Stopwatch stopwatch = Stopwatch();
  late Timer timer;

  void _start() {
    // Timer.periodic() will call the callback function every 100 milliseconds
    timer = Timer.periodic(const Duration(milliseconds: 30), (Timer t) {
      if (stopwatch.elapsedMilliseconds < 5000) {
        setState(() {});
      } else {
        _stop();
        setState(() {});
      }
    });
    stopwatch.start();
  }

  void _stop() {
    timer.cancel();
    stopwatch.stop();
  }

  void _reset() {
    _stop();
    stopwatch.reset();
    setState(() {});
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(stopwatch.elapsedMilliseconds > 5000 ? 'err' : ''),
            LinearProgressIndicator(
              value: stopwatch.elapsedMilliseconds / 5000,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _start,
                  child: const Text('start'),
                ),
                ElevatedButton(
                  onPressed: _stop,
                  child: const Text('stop'),
                ),
                ElevatedButton(
                  onPressed: _reset,
                  child: const Text('reset'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
