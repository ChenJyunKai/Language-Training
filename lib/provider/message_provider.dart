import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rpg/entity/message_entity.dart';

final messageProvider = StateNotifierProvider<MessageData, List<Message>>((ref) => MessageData());

class MessageData extends StateNotifier<List<Message>> {
  MessageData() : super([]);

  void setMessage(Message message) {
    state = [message, ...state];
  }
  //
  // void load() {
  //   state = [Message(isBot: true, message: '米卡想想... (´･ω･`) '), ...state];
  // }
}
