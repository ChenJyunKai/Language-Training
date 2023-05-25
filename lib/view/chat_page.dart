import 'dart:developer';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rpg/entity/message_entity.dart';
import 'package:rpg/env/env.dart';
import 'package:rpg/provider/message_provider.dart';
import 'package:rpg/helper/screen_size.dart';

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({super.key});

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController txtController = TextEditingController();

  late OpenAI openAI;

  @override
  void initState() {
    openAI = OpenAI.instance.build(
      token: Env.openAIKey,
      baseOption: HttpSetup(
        receiveTimeout: const Duration(seconds: 20),
        connectTimeout: const Duration(seconds: 6),
      ),
      enableLog: true,
    );
    super.initState();
  }

  Widget _chat(BuildContext context, int index) {
    final message = ref.watch(messageProvider)[index];
    return Column(
      crossAxisAlignment: message.isBot ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            message.isBot ? "MIKA" : "User",
            style: const TextStyle(fontSize: 16),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: message.isBot && index == 0
                ? AnimatedTextKit(
                    animatedTexts: [
                      TyperAnimatedText(
                        message.message,
                        textStyle: const TextStyle(fontSize: 16.0, color: Colors.black),
                      )
                    ],
                    totalRepeatCount: 1,
                  )
                : Text(
                    message.message,
                    style: const TextStyle(fontSize: 16.0),
                  ),
          ),
        ),
      ],
    );
  }

  void _sendMessage() async {
    FocusScope.of(context).requestFocus(FocusNode());

    ///放自己的資料
    setState(() {
      ref.read(messageProvider.notifier).setMessage(Message(isBot: false, message: txtController.text));
    });

    ///ChatGTP
    final request = CompleteText(prompt: txtController.text, model: Model.textDavinci3, maxTokens: 3500);
    txtController.text = "";
    final response = await openAI.onCompletion(request: request).onError((error, stackTrace) => null);
    log(response?.choices.last.text ?? 'null');

    if (response != null) {
      setState(() {
        ref.read(messageProvider.notifier).setMessage(Message(isBot: true, message: response.choices.last.text));
      });
    } else {
      setState(() {
        ref.read(messageProvider.notifier).setMessage(Message(isBot: true, message: "表達 練習更清楚一點"));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shrinkWrap: true,
                itemBuilder: _chat,
                itemCount: ref.watch(messageProvider).length,
                reverse: true,
              ),
            ),
            SizedBox(
              height: screenHeight * 0.09,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: screenWidth * 0.8,
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "你怎麼不問問神奇米卡...?",
                        isDense: true,
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      controller: txtController,
                    ),
                  ),
                  IconButton(
                    onPressed: _sendMessage,
                    icon: const Icon(Icons.send),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
