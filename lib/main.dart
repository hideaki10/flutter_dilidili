import 'package:flutter/material.dart';
import 'package:flutter_dilidili/http/core/hi_net.dart';
import 'package:flutter_dilidili/model/video_model.dart';
import 'package:flutter_dilidili/page/login_page.dart';
import 'package:flutter_dilidili/page/registration_page.dart';
import 'package:flutter_dilidili/page/video_detail_page.dart';
import 'package:flutter_dilidili/requset/notice_request.dart';
import 'package:flutter_dilidili/util/color.dart';
import 'package:flutter_dilidili/util/toast.dart';

import 'db/hi_cache.dart';
import 'http/core/hi_error.dart';
import 'http/dao/login_dao.dart';
import 'navigator/hi_navigator.dart';
import 'page/home_page.dart';

void main() {
  runApp(BiliApp());
}

class BiliApp extends StatefulWidget {
  @override
  _BiliAppState createState() => _BiliAppState();
}

class _BiliAppState extends State<BiliApp> {
  final BiliRouteDelegate _routeDelegate = BiliRouteDelegate();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<HiCache>(
      future: HiCache.preInit(),
      builder: (context, snapshot) {
        dynamic homeWidget = snapshot.connectionState == ConnectionState.done
            ? Router(
                routerDelegate: _routeDelegate,
              )
            : Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
        return MaterialApp(
          home: homeWidget,
          theme: ThemeData(primarySwatch: white),
        );
      },
    );
  }
}

///
// class BiliRouteInformationParser extends RouteInformationParser<BiliRoutePath> {
//   @override
//   Future<BiliRoutePath> parseRouteInformation(
//       RouteInformation routeInformation) async {
//     final uri = Uri.parse(routeInformation.location!);
//     print(uri);
//     if (uri.pathSegments.isEmpty) {
//       return BiliRoutePath.home();
//     }
//     return BiliRoutePath.detail();
//   }
// }

///
class BiliRoutePath {
  BiliRoutePath.home() : location = '/';
  BiliRoutePath.detail() : location = '/detail';
  final String location;
}

///
class BiliRouteDelegate extends RouterDelegate<BiliRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<BiliRoutePath> {
  ///
  BiliRouteDelegate() : navigatorKey = GlobalKey<NavigatorState>() {
    HiNavigator.getNaviatorInstance
        .registerRouteJump(RouteJumpListener(onjumpTo: (routeStatus, {args}) {
      _routeStatus = routeStatus;
      if (routeStatus == RouteStatus.detail) {
        videoModel = args!['videoMo'];
      }
      notifyListeners();
    }));
  }

  @override
  final GlobalKey<NavigatorState> navigatorKey;
  List<MaterialPage<dynamic>> pages = <MaterialPage<dynamic>>[];
  RouteStatus _routeStatus = RouteStatus.home;

  ///
  VideoModel? videoModel;

  @override
  Widget build(BuildContext context) {
    dynamic index = getPageIndex(pages, routeStatus!);
    List<MaterialPage<dynamic>> tempPages = pages;
    if (index != -1) {
      tempPages = tempPages.sublist(0, index);
    }

    dynamic page;

    if (routeStatus == RouteStatus.home) {
      pages.clear();
      page = pageWrap((HomePage()));
    } else if (routeStatus == RouteStatus.detail) {
      page = pageWrap(VideoDetailPage(
        videoModel: videoModel,
      ));
    } else if (routeStatus == RouteStatus.registation) {
      page = pageWrap(RegistrationPage());
    } else if (routeStatus == RouteStatus.login) {
      page = pageWrap(LoginPage());
    }

    tempPages = [...tempPages, page];
    HiNavigator.getNaviatorInstance.notify(tempPages, pages);
    pages = tempPages;

    return WillPopScope(
        child: Navigator(
          key: navigatorKey,
          pages: pages,
          onPopPage: (Route<dynamic> route, dynamic result) {
            if (route.settings is MaterialPage) {
              if ((route.settings as MaterialPage).child is LoginPage) {
                if (!hasLogin) {
                  showWarnToast("Plase login");
                  return false;
                }
              }
            }
            if (!route.didPop(result)) {
              return false;
            }
            dynamic tempPages = [...pages];
            pages.removeLast();
            HiNavigator.getNaviatorInstance.notify(pages, tempPages);
            return true;
          },
        ),
        onWillPop: () async {
          return !await navigatorKey.currentState!.maybePop();
        });
  }

  ///
  RouteStatus? get routeStatus {
    if (_routeStatus != RouteStatus.registation && hasLogin) {
      return _routeStatus = RouteStatus.registation;
    } else if (videoModel != null) {
      return _routeStatus = RouteStatus.detail;
    } else {
      return _routeStatus;
    }
  }

  ///
  bool get hasLogin => LoginDao.getBoardingPass() != null;

  @override
  Future<void> setNewRoutePath(BiliRoutePath configuration) async {}
}
