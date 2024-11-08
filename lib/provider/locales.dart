import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final localesProvider = StateNotifierProvider<LocalesNotifier, Locale>((ref) => LocalesNotifier());

class LocalesNotifier extends StateNotifier<Locale> {
  LocalesNotifier() : super(const Locale('zh', 'TW'));

  void init() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? languageCode = sp.getString('language_code');
    String? countryCode = sp.getString('country_code');
    if (languageCode != null) {
      state = Locale(languageCode, countryCode);
    }
  }

  void changeLocale(Locale locale) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setString('language_code', locale.languageCode);
    await sp.setString('country_code', locale.countryCode ?? '');
    state = locale;
  }
}
