import 'package:flutter/material.dart';
import 'package:rpg/view/battle/components/battle_view.dart';
import 'package:rpg/view/setting/locales_page.dart';
import 'package:rpg/view/setting/settings_page.dart';
import 'package:rpg/view/skill/skill_page.dart';
import 'package:rpg/view/train/train_page.dart';
import 'package:rpg/view/chat/chat_page.dart';
import 'package:rpg/view/home/home_page.dart';
import 'package:rpg/view/welcome/welcome_page.dart';

const homeUrl = 'home';
const welcomeUrl = 'welcome';
const chatUrl = 'chat';
const skillUrl = 'skill';
const trainUrl = 'train';
const settingUrl = 'setting';
const battleUrl = 'battle';
const localesUrl = 'locales';

final Map<String, WidgetBuilder> routes = {
  homeUrl: (context) => const HomePage(),
  welcomeUrl: (context) => const WelcomePage(),
  chatUrl: (context) => const ChatPage(),
  skillUrl: (context) => const SkillPage(),
  trainUrl: (context) => const TrainPage(),
  settingUrl: (context) => const SettingsPage(),
  battleUrl: (context) => const BattleView(),
  localesUrl: (context) => const LocalesPage(),
};
