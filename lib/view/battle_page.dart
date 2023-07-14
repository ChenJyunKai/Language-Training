import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:rpg/helper/screen_size.dart';
import 'package:rpg/provider/word_provider.dart';
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
  String _lastWord = '';
  late Future getData;
  late Language language;
  late AnimationController animationController;
  late AnimationController fadeAnimationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    fadeAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    getData = ref.read(wordProvider.notifier).getData();
    _initSpeech();
  }

  @override
  void dispose() {
    animationController.dispose();
    fadeAnimationController.dispose();
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
    if (_lastWord == ref.watch(wordProvider).first.word) {
      ref.read(wordProvider.notifier).remove(_lastWord);
      _lastWord = '';
    }
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWord = result.recognizedWords;
      if (_lastWord == ref.watch(wordProvider).first.word) {
        ref.read(wordProvider.notifier).remove(_lastWord);
        _lastWord = '';
      }
    });
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
                  selectLanguage(),
                  rule(),
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

  Widget selectLanguage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SlideTransition(
          position: Tween(begin: const Offset(0, 0), end: const Offset(-4, 0)).animate(CurvedAnimation(
            parent: animationController,
            curve: const Interval(0, 1, curve: Curves.fastOutSlowIn),
          )),
          child: Container(
            width: screenWidth,
            alignment: Alignment.center,
            child: const Text(
              "請選擇語言模式",
              style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Container(
          height: screenHeight * 0.3,
          padding: const EdgeInsets.only(top: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (Language i in Language.list)
                SlideTransition(
                  position: Tween(begin: const Offset(0, 0), end: const Offset(-4, 0)).animate(CurvedAnimation(
                    parent: animationController,
                    curve: Interval(0.1 * Language.list.indexWhere((e) => e == i), 1, curve: Curves.fastOutSlowIn),
                  )),
                  child: SizedBox(
                    height: 50,
                    width: screenWidth * 0.7,
                    child: ElevatedButton(
                      onPressed: () {
                        animationController.animateTo(1);
                        setState(() => language = i);
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white70,
                      ),
                      child: Text(i.name, style: const TextStyle(fontSize: 20)),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget rule() {
    return FadeTransition(
      opacity: Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: fadeAnimationController,
        curve: const Interval(0, 1, curve: Curves.fastOutSlowIn),
      )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SlideTransition(
            position: Tween(begin: const Offset(2, 0), end: const Offset(0, 0)).animate(CurvedAnimation(
              parent: animationController,
              curve: const Interval(0, 1, curve: Curves.fastOutSlowIn),
            )),
            child: Lottie.asset('assets/lottie/animation_elf.json', height: 200),
          ),
          SlideTransition(
            position: Tween(begin: const Offset(3, 0), end: const Offset(0, 0)).animate(CurvedAnimation(
              parent: animationController,
              curve: const Interval(0, 1, curve: Curves.fastOutSlowIn),
            )),
            child: Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: screenWidth * 0.6,
                child: const Text(
                  "請根據上面的單字唸出讀音",
                  style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          SlideTransition(
            position: Tween(begin: const Offset(4, 0), end: const Offset(0, 0)).animate(CurvedAnimation(
              parent: animationController,
              curve: const Interval(0.5, 1, curve: Curves.fastOutSlowIn),
            )),
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: _speechEnabled
                      ? () => fadeAnimationController.forward()
                      : () => Fluttertoast.showToast(
                            msg: "Speech not available",
                            toastLength: Toast.LENGTH_SHORT,
                            timeInSecForIosWeb: 1,
                            textColor: Colors.white,
                            backgroundColor: Colors.black.withAlpha(180),
                            fontSize: 16,
                          ),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xff132137),
                  ),
                  child: const Text("Let's begin", style: TextStyle(fontSize: 18)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget test() {
    return FadeTransition(
      opacity: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: fadeAnimationController,
        curve: const Interval(0.8, 1, curve: Curves.fastOutSlowIn),
      )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(ref.watch(wordProvider).first.word, style: const TextStyle(fontSize: 48)),
                Text(ref.watch(wordProvider).first.hiragana, style: const TextStyle(fontSize: 42)),
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

class Language {
  Language({required this.name, required this.id});

  final String name;
  final String id;

  static List<Language> list = [
    Language(name: '日語', id: 'ja_JA'),
    Language(name: '英語', id: 'en_US'),
    Language(name: '中文', id: 'zh_TW'),
  ];
}
