import 'package:flutter/material.dart';
import 'package:flutter_dilidili/page/home_page.dart';
import 'package:flutter_dilidili/page/login_page.dart';
import 'package:flutter_dilidili/page/registration_page.dart';
import 'package:flutter_dilidili/page/video_detail_page.dart';

typedef RouterChangeListner(
    RouteStatusInfo RouteStatusInfo, RouteStatusInfo preInfo);

///
MaterialPage<dynamic> pageWrap(Widget child) {
  return MaterialPage<dynamic>(
    key: ValueKey<int>(child.hashCode),
    child: child,
  );
}

///
int? getPageIndex(List<MaterialPage> pages, RouteStatus routeStatus) {
  for (int? i = 0; i! < pages.length; i++) {
    final page = pages[i];
    if (getStatus(page) == routeStatus) {
      return i;
    } else {
      return -1;
    }
  }
}

///
enum RouteStatus {
  login,
  registation,
  home,
  detail,
  unknown,
}

///
RouteStatus? getStatus(MaterialPage page) {
  if (page.child is LoginPage) {
  } else if (page.child is RegistrationPage) {
    return RouteStatus.registation;
  } else if (page.child is HomePage) {
    return RouteStatus.home;
  } else if (page.child is VideoDetailPage) {
    return RouteStatus.detail;
  } else {
    return RouteStatus.unknown;
  }
}

///
class RouteStatusInfo {
  ///
  RouteStatusInfo(this.routeStatus, this.page);
  final RouteStatus? routeStatus;
  final Widget page;
}

///
class HiNavigator extends _RouteJumpListener {
  List<RouterChangeListner> _listener = [];
  RouteJumpListener? _routeJumpListener;
  RouteStatusInfo? _current;

  HiNavigator._();
  static HiNavigator? _instance;

  ///
  static HiNavigator get getNaviatorInstance => _instance ??= HiNavigator._();

  void addListener(RouterChangeListner listener) {
    if (!_listener.contains(listener)) {
      _listener.add(listener);
    }
  }

  void removeListener(RouterChangeListner listener) {
    _listener.remove(listener);
  }

  //
  void registerRouteJump(RouteJumpListener routeJumpListener) {
    _routeJumpListener = routeJumpListener;
  }

  @override
  void onJumpTo(RouteStatus routeStatus, {Map? args}) {
    _routeJumpListener!.onjumpTo!(routeStatus, args: args);
  }

  void notify(List<MaterialPage> currentPages, List<MaterialPage> prePages) {
    if (currentPages == prePages) return;
    dynamic current =
        RouteStatusInfo(getStatus(currentPages.last), currentPages.last.child);

    _notify(current);
  }

  void _notify(RouteStatusInfo current) {
    print(current);
    print(_current);
    _listener.forEach((listener) {
      listener(current, _current!);
    });
    _current = current;
  }
}

///
abstract class _RouteJumpListener {
  void onJumpTo(RouteStatus routeStatus, {Map? args});
}

///
typedef OnjumpTo = void Function(RouteStatus routeStatus, {Map? args});

///
class RouteJumpListener {
  ///
  RouteJumpListener({this.onjumpTo});

  ///
  final OnjumpTo? onjumpTo;
}
