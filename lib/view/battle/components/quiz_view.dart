import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:rpg/provider/word_provider.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class QuizView extends ConsumerStatefulWidget {
  const QuizView({
    super.key,
    required this.fadeAnimationController,
    required this.animationController,
    required this.fade,
  });

  final AnimationController fadeAnimationController;
  final AnimationController animationController;
  final bool fade;

  @override
  ConsumerState<QuizView> createState() => _QuizViewState();
}

class _QuizViewState extends ConsumerState<QuizView> with TickerProviderStateMixin {
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  bool _tipVisable = false;
  String _lastWord = '';
  bool _isCalculate = false;

  late AnimationController correctAnimationController =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
  late AnimationController shackAnimationController =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
  late AnimationController skipAnimationController =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
  late AnimationController lottieAnimationController =
      AnimationController(vsync: this, duration: const Duration(seconds: 1));

  @override
  void initState() {
    shackAnimationController.addListener(() {
      if (shackAnimationController.status == AnimationStatus.completed) {
        shackAnimationController.reset();
      }
    });
    _initSpeech();
    super.initState();
  }

  @override
  void dispose() {
    correctAnimationController.dispose();
    shackAnimationController.dispose();
    skipAnimationController.dispose();
    lottieAnimationController.dispose();
    super.dispose();
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult, localeId: ref.watch(wordProvider).languageId);
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    if (result.finalResult) {
      if (result.recognizedWords == ref.watch(wordProvider).words.first.word) {
        correctAnimationController.forward().then((value) => correctAnimationController.reverse().then((value) {
              ref.read(wordProvider.notifier).answer(_tipVisable ? 5 : 10);
              _lastWord = '';
              _tipVisable = false;
              setState(() {});
            }));
        if (ref.watch(wordProvider).count == 10) {
          setState(() {
            _isCalculate = true;
          });
          widget.animationController.animateTo(1);
        }
      } else {
        setState(() {
          _lastWord = result.recognizedWords;
          shackAnimationController.forward();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(begin: const Offset(0, 0), end: const Offset(-2, 0)).animate(
        CurvedAnimation(parent: widget.animationController, curve: const Interval(0.5, 1, curve: Curves.fastOutSlowIn)),
      ),
      child: FadeTransition(
        opacity: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: widget.fadeAnimationController,
          curve: const Interval(0.8, 1, curve: Curves.fastOutSlowIn),
        )),
        child: widget.fade
            ? const SizedBox()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        ref.read(wordProvider.notifier).calculate();
                        setState(() {
                          _isCalculate = true;
                        });
                        widget.animationController.animateTo(1);
                      },
                      child: const Text('結算', style: TextStyle(fontSize: 18, color: Colors.grey)),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: Text(
                            '${ref.watch(wordProvider).count} / 10 題',
                            style: const TextStyle(fontSize: 26, color: Colors.blue),
                          ),
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            AnimatedBuilder(
                              animation: shackAnimationController,
                              builder: (context, child) {
                                final sineValue = sin(4 * 2 * pi * shackAnimationController.value);
                                return Transform.translate(
                                  offset: Offset(sineValue * 10, 0),
                                  child: child,
                                );
                              },
                              child: ScaleTransition(
                                scale: Tween<double>(begin: 1.0, end: 1.4).animate(CurvedAnimation(
                                  parent: correctAnimationController,
                                  curve: Curves.fastOutSlowIn,
                                )),
                                child: FadeTransition(
                                  opacity: Tween<double>(begin: 1.0, end: 0.0).animate(skipAnimationController),
                                  child: Column(
                                    children: [
                                      Text(
                                        ref.watch(wordProvider).words.first.word,
                                        style: const TextStyle(fontSize: 48),
                                      ),
                                      Text(
                                        ref.watch(wordProvider).words.first.hiragana,
                                        style: TextStyle(
                                          fontSize: 42,
                                          color: _tipVisable ? Colors.black : Colors.transparent,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SlideTransition(
                              position: Tween<Offset>(begin: const Offset(1, 0), end: const Offset(-1, 0)).animate(
                                  CurvedAnimation(parent: lottieAnimationController, curve: Curves.slowMiddle)),
                              child: !_isCalculate
                                  ? Lottie.asset('assets/lottie/dog-running.json', height: 150)
                                  : const SizedBox(
                                      height: 150,
                                    ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton.icon(
                                onPressed: _tipVisable ? null : () => setState(() => _tipVisable = true),
                                icon: const Icon(Icons.tips_and_updates, size: 30),
                                label: const Text('提示', style: TextStyle(fontSize: 24)),
                              ),
                              const Text('|'),
                              TextButton.icon(
                                onPressed: () {
                                  if (ref.watch(wordProvider).count < 10) {
                                    lottieAnimationController
                                        .forward()
                                        .then((value) => lottieAnimationController.reset());
                                    skipAnimationController.forward().then((value) {
                                      ref.read(wordProvider.notifier).answer(0);
                                      _tipVisable = false;
                                      _lastWord = '';
                                      skipAnimationController.reverse();
                                    });
                                  } else {
                                    ref.read(wordProvider.notifier).calculate();
                                    setState(() {
                                      _isCalculate = true;
                                    });
                                    widget.animationController.animateTo(1);
                                  }
                                },
                                icon: const Icon(Icons.skip_next, size: 30),
                                label: const Text('跳過', style: TextStyle(fontSize: 24)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text(_lastWord, style: const TextStyle(fontSize: 38, color: Colors.red)),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: FloatingActionButton.large(
                        onPressed: _speechEnabled
                            ? _speechToText.isNotListening
                                ? _startListening
                                : _stopListening
                            : () => Fluttertoast.showToast(
                                  msg: "Speech not available",
                                  toastLength: Toast.LENGTH_SHORT,
                                  timeInSecForIosWeb: 1,
                                  textColor: Colors.white,
                                  backgroundColor: Colors.black.withAlpha(180),
                                  fontSize: 16,
                                ),
                        foregroundColor: Colors.blue,
                        backgroundColor: Colors.white,
                        shape: const CircleBorder(),
                        child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
