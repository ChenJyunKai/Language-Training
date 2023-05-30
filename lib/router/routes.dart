import 'package:flutter/material.dart';
import 'package:rpg/view/battle_page.dart';
import 'package:rpg/view/chat_page.dart';
import 'package:rpg/view/home_page.dart';
import 'package:rpg/view/welcome/welcome_page.dart';

const homeUrl = 'home';
const welcomeUrl = 'welcome';
const chatUrl = 'chat';
const battleUrl = 'battle';

final Map<String, WidgetBuilder> routes = {
  homeUrl: (context) => const HomePage(),
  welcomeUrl: (context) => const WelcomePage(),
  chatUrl: (context) => const ChatPage(),
  battleUrl: (context) => const BattlePage(),
};
