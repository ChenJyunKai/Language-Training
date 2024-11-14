import 'package:flutter_riverpod/flutter_riverpod.dart';

final messageProvider = StateNotifierProvider<MessageData, List<Message>>((ref) => MessageData());

class MessageData extends StateNotifier<List<Message>> {
  MessageData() : super([]);

  void setMessage(Message message) {
    state = [message, ...state];
  }
}

class Message {
  Message({
    required this.isBot,
    required this.message,
  });

  final bool isBot;
  final String message;
}

