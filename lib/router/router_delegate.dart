import 'package:rpg/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class AppRouterDelegate extends RouterDelegate<RoutePage>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<RoutePage> {
  final List<Page> _pages = [];
  var random = 0;

  AppRouterDelegate() : navigatorKey = GlobalKey();

  @override
  final GlobalKey<NavigatorState> navigatorKey;

  //覆寫:建構完Navigator寫回紀錄
  @override
  RoutePage get currentConfiguration {
    return _pages.last.arguments as RoutePage;
  }

  //設定收到新路由設定時如何操作pages
  @override
  Future<void> setNewRoutePath(RoutePage configuration) {
    final shouldAddPage =
        _pages.isEmpty || (_pages.last.arguments as RoutePage).name != configuration.name;

    if (shouldAddPage) {
      replace(configuration);
    }

    return SynchronousFuture(null);
  }

  replace(RoutePage configuration) {
    _pages.clear();
    _addPage(configuration);
  }

  //靜態方法:2ways
  static AppRouterDelegate of(BuildContext context) {
    RouterDelegate routerDelegate = Router.of(context).routerDelegate;
    return routerDelegate as AppRouterDelegate;
  }

  //加入畫面
  void push(Widget widget) {
    _addPage(RoutePage.widget(widget, random));
    random++;
  }

  void _addPage(RoutePage configuration) {
    _pages.add(
      MaterialPage(
        child: configuration.widget,
        key: ValueKey(configuration.name),
        name: configuration.name,
        arguments: configuration,
      ),
    );
    notifyListeners();
  }

  //推入當前畫面PopPush
  void pushNamed(String name) {
    RoutePage configuration = getRoutePage(name: name);
    replace(configuration);
  }

  //重構Navigator
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onPopPage: _onPopPage,
      pages: List.of(_pages),
    );
  }

  bool _onPopPage(Route<dynamic> route, result) {
    final didPop = route.didPop(result);

    if (!didPop) {
      return false;
    }

    if (_pages.length > 1) {
      _pages.removeLast();
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }
}

class AppRouterParser extends RouteInformationParser<RoutePage> {
  @override
  Future<RoutePage> parseRouteInformation(RouteInformation routeInformation) {
    RoutePage configuration = getRoutePage(name: routeInformation.location ?? '/');

    return SynchronousFuture(configuration);
  }

  @override
  RouteInformation restoreRouteInformation(RoutePage configuration) {
    return RouteInformation(location: configuration.path ?? '/');
  }
}
