import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rpg/helper/app_theme.dart';
import 'package:rpg/helper/screen_size.dart';
import 'package:rpg/provider/abilities.dart';
import 'package:rpg/router/routes.dart';
import 'package:rpg/view/home_page.dart';
import 'package:rpg/view/welcome/welcome_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.blue,
          colorScheme: const ColorScheme.light().copyWith(
            background: AppTheme.background,
          )),
      builder: (context, child) => Scaffold(
        body: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
              FocusManager.instance.primaryFocus?.unfocus();
            }
          },
          child: child,
        ),
      ),
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: routes[settings.name]!, settings: settings);
      },
      home: ref.watch(abilitiesProvider).when(
            data: (value) => value.userName != null ? const HomePage() : const WelcomePage(),
            error: (_, __) => const Scaffold(),
            loading: () => const Scaffold(),
          ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale.fromSubtags(languageCode: 'zh', countryCode: 'TW'),
        Locale('en', 'US'),
      ],
    );
  }
}
