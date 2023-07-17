import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rpg/provider/word_provider.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class QuizView extends ConsumerStatefulWidget {
  const QuizView({
    super.key,
    required this.fadeAnimationController,
    required this.fade,
  });

  final AnimationController fadeAnimationController;
  final bool fade;

  @override
  ConsumerState<QuizView> createState() => _QuizViewState();
}

class _QuizViewState extends ConsumerState<QuizView> with TickerProviderStateMixin {
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWord = '';

  late AnimationController correctAnimationController =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
  late AnimationController shackAnimationController =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 500));

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
              ref.read(wordProvider.notifier).remove(result.recognizedWords);
              _lastWord = '';
              setState(() {});
            }));
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
    return FadeTransition(
      opacity: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: widget.fadeAnimationController,
        curve: const Interval(0.8, 1, curve: Curves.fastOutSlowIn),
      )),
      child: widget.fade
          ? const SizedBox()
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                          child: Column(
                            children: [
                              Text(ref.watch(wordProvider).words.first.word, style: const TextStyle(fontSize: 48)),
                              Text(ref.watch(wordProvider).words.first.hiragana, style: const TextStyle(fontSize: 42)),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
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
    );
  }
}

// Fluttertoast.showToast(
// msg: "Speech not available",
// toastLength: Toast.LENGTH_SHORT,
// timeInSecForIosWeb: 1,
// textColor: Colors.white,
// backgroundColor: Colors.black.withAlpha(180),
// fontSize: 16,
// )
