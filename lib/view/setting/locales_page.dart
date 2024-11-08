import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rpg/provider/locales.dart';
import 'package:rpg/utils/app_localizations.dart';

class LocalesPage extends ConsumerStatefulWidget {
  const LocalesPage({Key? key}) : super(key: key);

  @override
  ConsumerState<LocalesPage> createState() => _LocalesPageState();
}

class _LocalesPageState extends ConsumerState<LocalesPage> {
  late AppLocalizations _str;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _str = L10n.of(context)!;
  }

  Widget buildTile(String title, Locale locale) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black26),
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(
            offset: Offset(1, 1),
            blurRadius: 1,
            color: Colors.grey,
          )
        ],
      ),
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        leading: ref.watch(localesProvider) == locale ? const Icon(Icons.check) : const SizedBox(),
        title: Text(title, style: const TextStyle(fontSize: 18)),
        onTap: () => ref.read(localesProvider.notifier).changeLocale(locale),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_str.change_language),
        backgroundColor: Colors.green[100],
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.black,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 12),
          child: Column(
            children: <Widget>[
              buildTile('English', const Locale('en')),
              buildTile('繁體中文',  const Locale('zh','TW')),
              buildTile('簡體中文',  const Locale('zh')),
              buildTile('日本語', const Locale('ja')),
            ],
          ),
        ),
      ),
    );
  }
}
