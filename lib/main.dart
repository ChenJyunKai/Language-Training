import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rpg/helper/app_theme.dart';
import 'package:rpg/helper/screen_size.dart';
import 'package:rpg/router/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final hasData = prefs.getString('ability') != null;

  runApp(
    ProviderScope(
      child: MyApp(hasData: hasData),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.hasData});

  final bool hasData;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
        colorScheme: const ColorScheme.light().copyWith(
          background: AppTheme.background,
        )
      ),
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
      initialRoute: widget.hasData ? 'home' : 'welcome',
    );
  }
}
