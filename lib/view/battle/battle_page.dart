import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rpg/entity/language_entity.dart';
import 'package:rpg/provider/word_provider.dart';
import 'package:rpg/view/battle/components/rule_view.dart';
import 'package:rpg/view/battle/components/select_language.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class BattlePage extends ConsumerStatefulWidget {
  const BattlePage({Key? key}) : super(key: key);

  @override
  ConsumerState<BattlePage> createState() => _BattlePageState();
}

class _BattlePageState extends ConsumerState<BattlePage> with TickerProviderStateMixin {
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  bool _fade = true;
  String _lastWord = '';
  late Future getData = ref.read(wordProvider.notifier).getData();
  late Language language;
  late AnimationController animationController = AnimationController(vsync: this, duration: const Duration(seconds: 2));
  late AnimationController fadeAnimationController =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
  late AnimationController correctAnimationController =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
  late AnimationController shackAnimationController =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 500));

  @override
  void initState() {
    super.initState();
    shackAnimationController.addListener(() {
      if (shackAnimationController.status == AnimationStatus.completed) {
        shackAnimationController.reset();
      }
    });
    _initSpeech();
  }

  @override
  void dispose() {
    animationController.dispose();
    fadeAnimationController.dispose();
    correctAnimationController.dispose();
    shackAnimationController.dispose();
    super.dispose();
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    ref.read(wordProvider.notifier).getData();
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult, localeId: language.id);
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    if (result.finalResult) {
      if (result.recognizedWords == ref.watch(wordProvider).first.word) {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Speech Demo'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getData,
        builder: (context, snapShot) {
          if (snapShot.hasData) {
            return ClipRect(
              child: Stack(
                children: [
                  SelectLanguage(
                    animationController: animationController,
                    select: (x) => setState(() => language = x),
                  ),
                  RuleView(
                    fadeAnimationController: fadeAnimationController,
                    animationController: animationController,
                    speechEnabled: _speechEnabled,
                    fade: _fade,
                    function: () => setState(() => _fade = false),
                  ),
                  test(),
                ],
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Widget test() {
    return FadeTransition(
      opacity: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: fadeAnimationController,
        curve: const Interval(0.8, 1, curve: Curves.fastOutSlowIn),
      )),
      child: _fade
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
                              Text(ref.watch(wordProvider).first.word, style: const TextStyle(fontSize: 48)),
                              Text(ref.watch(wordProvider).first.hiragana, style: const TextStyle(fontSize: 42)),
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
                      onPressed: _speechToText.isNotListening ? _startListening : _stopListening,
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
