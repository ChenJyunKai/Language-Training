import 'package:flutter/material.dart';
import 'package:rpg/view/battle/battle_page.dart';
import 'package:rpg/view/setting/settings_page.dart';
import 'package:rpg/view/train/train_page.dart';
import 'package:rpg/view/chat/chat_page.dart';
import 'package:rpg/view/home_page.dart';
import 'package:rpg/view/welcome/welcome_page.dart';

const homeUrl = 'home';
const welcomeUrl = 'welcome';
const chatUrl = 'chat';
const trainUrl = 'train';
const settingUrl = 'setting';
const battleUrl = 'battle';

final Map<String, WidgetBuilder> routes = {
  homeUrl: (context) => const HomePage(),
  welcomeUrl: (context) => const WelcomePage(),
  chatUrl: (context) => const ChatPage(),
  trainUrl: (context) => const TrainPage(),
  settingUrl: (context) => const SettingsPage(),
  battleUrl: (context) => const BattlePage(),
};
