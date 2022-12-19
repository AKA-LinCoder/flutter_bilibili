import 'package:flutter/material.dart';
import 'package:flutter_bilibili/db/lin_cache.dart';
import 'package:flutter_bilibili/page/dark_mode_page.dart';
import 'package:flutter_bilibili/page/login_page.dart';
import 'package:flutter_bilibili/page/notice_page.dart';
import 'package:flutter_bilibili/page/registration_page.dart';
import 'package:flutter_bilibili/page/video_detail_page.dart';
import 'package:flutter_bilibili/provider/lin_provider.dart';
import 'package:flutter_bilibili/provider/theme_provider.dart';
import 'package:flutter_bilibili/utils/colors.dart';
import 'package:flutter_bilibili/utils/toast_util.dart';
import 'package:provider/provider.dart';

import 'http/dao/login_dao.dart';
import 'model/home_model.dart';
import 'navigator/bottom_navigator.dart';
import 'navigator/lin_navigator.dart';

void main() {
  runApp(BiliApp());
}

class BiliApp extends StatefulWidget {
  const BiliApp({Key? key}) : super(key: key);

  @override
  _BiliAppState createState() => _BiliAppState();
}

class _BiliAppState extends State<BiliApp> {
  final BiliRouteDelegate _routeDelegate = BiliRouteDelegate();
  final BiliRouteInformationParser _biliRouteInformationParser = BiliRouteInformationParser();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LinCache>(
      future: LinCache.preInit(),
      builder: (BuildContext context, AsyncSnapshot<LinCache> snapshot) {
        //定义route
        var widget = snapshot.connectionState == ConnectionState.done
            ? Router(routerDelegate: _routeDelegate,routeInformationParser: _biliRouteInformationParser,)
            : const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );

        return MultiProvider(
          providers: topProviders,
          child: Consumer<ThemeProvider>(
            builder: (BuildContext context, ThemeProvider themeProvider,
                Widget? child) {
              return MaterialApp(
                home: widget,
                theme: themeProvider.getTheme(),
                darkTheme: themeProvider.getTheme(isDarkMode: true),
                themeMode: themeProvider.getThemeMode(),
                title: 'flutter哔哩哔哩',
              );
            },
          ),
        );
      },
    );
  }
}

class BiliRouteDelegate extends RouterDelegate<BiliRoutePath> with ChangeNotifier,PopNavigatorRouterDelegateMixin<BiliRoutePath>{
  final GlobalKey<NavigatorState> navigatorKey;

  // 为 Navigator 设置一个 key，必要时可以通过navigatorKey.currentState 来获取到 navigatorState 对象
  BiliRouteDelegate() : navigatorKey = GlobalKey<NavigatorState>() {
    // 实现路由跳转逻辑
    LinNavigator.getInstance().registerRouteJump(
      RouteJumpListener(
        onJumpTo: (RouteStatus routeStatus, {Map? args}) {
          _routeStatus = routeStatus;
          if (routeStatus == RouteStatus.detail) {
            videoInfo = args!['videoInfo'];
          }
          notifyListeners();
        },
      ),
    );
  }

  RouteStatus _routeStatus = RouteStatus.home;
  List<MaterialPage> pages = [];

  /// 详情视频信息
  VideoModel? videoInfo;

  RouteStatus get routeStatus {
    if (_routeStatus != RouteStatus.registration && !hasLogin) {
      return _routeStatus = RouteStatus.login;
    } else {
      return _routeStatus;
    }
  }

  bool get hasLogin => LoginDao.getBoardingPass() != null;

  @override
  Widget build(BuildContext context) {
    var index = getPageIndex(pages, routeStatus);
    List<MaterialPage> tempPages = pages;
    if (index != -1) {
      // 要打开的页面在栈中已存在，则将该页面和它上面的所有页面进行出栈
      // tips 具体规则可以根据需要进行调整，这里要求栈中只允许有一个同样的页面的实例
      tempPages = tempPages.sublist(0, index);
    }
    var page;
    if (routeStatus == RouteStatus.home) {
      // 跳转首页时将栈中其它页面进行出栈，因为首页不可回退
      pages.clear();
      page = pageWrap(const BottomNavigator());
    } else if (routeStatus == RouteStatus.darkMode) {
      page = pageWrap(DarkModePage());
    } else if (routeStatus == RouteStatus.detail) {
      page = pageWrap(VideoDetailPage(videoModel: videoInfo!,));
    } else if (routeStatus == RouteStatus.registration) {
      page = pageWrap(RegistrationPage(onJumpToLogin: () {  },));
    } else if (routeStatus == RouteStatus.notice) {
      page = pageWrap(NoticePage());
    } else if (routeStatus == RouteStatus.login) {
      page = pageWrap(const LoginPage());
    }
    // 重新创建一个数组，否则pages因引用没有改变路由不会生效
    tempPages = [...tempPages, page];
    // 通知路由发生变化
    LinNavigator.getInstance().notify(tempPages, pages);
    pages = tempPages;

    return WillPopScope(
      // fix Android物理返回键，无法返回上一页问题@https://github.com/flutter/flutter/issues/66349
      onWillPop: () async =>
      !(await navigatorKey.currentState?.maybePop() ?? false),
      child: Navigator(
        key: navigatorKey,
        pages: pages,
        onPopPage: (route, result) {
          if (route.settings is MaterialPage) {
            // 登录页未登录返回拦截/在登陆页面点击了返回键
            if ((route.settings as MaterialPage).child is LoginPage) {
              if (!hasLogin) {
                showWarnToast("请先登录");
                return false;
              }
            }
          }
          // 执行返回操作
          if (!route.didPop(result)) {
            return false;
          }
          var tempPages = [...pages];
          pages.removeLast();
          // 通知路由发生变化
          LinNavigator.getInstance().notify(pages, tempPages);
          return true;
        },
      ),
    );
  }

  @override
  Future<void> setNewRoutePath(BiliRoutePath path) async {}
}


///主要是给web使用
class BiliRouteInformationParser extends RouteInformationParser<BiliRoutePath>{

  @override
  Future<BiliRoutePath> parseRouteInformation(RouteInformation routeInformation) async{
    // TODO: implement parseRouteInformation
    final uri = Uri.parse(routeInformation.location??'');
    if(uri.pathSegments.isEmpty){
      return BiliRoutePath.home();
    }else{
      return BiliRoutePath.detail();
    }
    return super.parseRouteInformation(routeInformation);
  }
}

///定义路由数据，path
/// 定义路由数据
class BiliRoutePath {
  final String location;

  BiliRoutePath.home() : location = '/';

  BiliRoutePath.detail() : location = '/detail';
}