import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:rpg/entity/word_jp_entity.dart';
import 'package:rpg/helper/screen_size.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class BattlePage extends StatefulWidget {
  const BattlePage({Key? key}) : super(key: key);

  @override
  State<BattlePage> createState() => _BattlePageState();
}

class _BattlePageState extends State<BattlePage> with SingleTickerProviderStateMixin {
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';
  late List<Word> words;
  static const List<String> language = ['日語', '英語', '中文'];
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _initSpeech();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    words = wordJpEntityFromJson(await rootBundle.loadString('assets/json/word_jp.json')).words;
    setState(() {});
  }

  void _startListening(String language) async {
    String localeId = 'zh_TW';
    switch (language) {
      case '日語':
        localeId = 'ja_JA';
      case '英語':
        localeId = 'en_US';
      case '中文':
        localeId = 'zh_TW';
    }
    await _speechToText.listen(onResult: _onSpeechResult, localeId: localeId);
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Speech Demo'),
        centerTitle: true,
      ),
      body: ClipRect(
        child: Stack(
          children: [
            selectLanguage(),
            rule(),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _speechToText.isNotListening ? _startListening : _stopListening,
      //   tooltip: 'Listen',
      //   child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
      // ),
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
              for (String i in language)
                SlideTransition(
                  position: Tween(begin: const Offset(0, 0), end: const Offset(-4, 0)).animate(CurvedAnimation(
                    parent: animationController,
                    curve: Interval(0.1 * language.indexWhere((e) => e == i), 1, curve: Curves.fastOutSlowIn),
                  )),
                  child: SizedBox(
                    height: 50,
                    width: screenWidth * 0.7,
                    child: ElevatedButton(
                      onPressed: () => animationController.animateTo(1),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white70,
                      ),
                      child: Text(i, style: const TextStyle(fontSize: 20)),
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SlideTransition(
          position: Tween(begin: const Offset(2, 0), end: const Offset(0, 0)).animate(CurvedAnimation(
            parent: animationController,
            curve: const Interval(0, 1, curve: Curves.fastOutSlowIn),
          )),
          child: Lottie.asset('assets/lottie/animation_elf.json',height: 200),
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
                onPressed: () {},
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
    );
  }
}
