import 'package:flutter/material.dart';
import 'package:rpg/view/home_page.dart';

class RoutePage extends RouteSettings {
  final Function? builder;

  final String? path;

  Widget get widget => builder!();

  const RoutePage({
    required String name,
    Object? arguments,
    this.builder,
    this.path,
  }) : super(name: name, arguments: arguments);

  RoutePage.widget(Widget widget, int i) : this(name: 'widget$i', builder: () => widget);
}

RoutePage getRoutePage({required String name}) {
  switch (name) {
    case '/':
      return RoutePage(name: "welcome", path: name, builder: () => const HomePage());
    default:
      return RoutePage(name: 'unknown', path: '/404', builder: () => const Scaffold());
  }
}
