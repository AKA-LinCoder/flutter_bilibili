import 'package:flutter/material.dart';

import '../page/favorite_page.dart';
import '../page/home_page.dart';
import '../page/profile_page.dart';
import '../page/ranking_page.dart';
import '../utils/colors.dart';
import '../utils/toast_util.dart';
import 'lin_navigator.dart';

/// FileName bottom_navigator
///
/// @Author LinGuanYu
/// @Date 2022/12/19 14:19
///
/// @Description TODO

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({Key? key}) : super(key: key);

  @override
  _BottomNavigatorState createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  /// 默认色
  final _defaultColor = Colors.grey;

  /// 主题色
  final _activeColor = primary;

  /// 当前索引
  int _currentIndex = 0;

  /// 标签页面
  List<Widget> _pages = [];

  ///上次点击时间
  DateTime? _lastPressedAt;

  static int initialPage = 0;
  final PageController _controller = PageController(initialPage: initialPage);

  bool _hasBuild = false;

  /// 跳转页面
  void _onJumpTo(int index, {pageChange = false}) {
    if (!pageChange) {
      // 让PageView展示对应tab
      _controller.jumpToPage(index);
    } else {
      LinNavigator.getInstance().onBottomTabChange(index, _pages[index]);
    }
    setState(() {
      //控制选中第一个tab
      _currentIndex = index;
    });
  }

  /// 退出 app
  Future<bool> exitApp() async {
    if (_lastPressedAt == null ||
        DateTime.now().difference(_lastPressedAt!) > const Duration(seconds: 2)) {
      showToast('再按一次退出应用');
      // 两次点击间隔超过2秒则重新计时
      _lastPressedAt = DateTime.now();
      return Future.value(false);
    }
    return Future.value(true);
  }

  /// 底部 Item
  BottomNavigationBarItem _bottomItem(String label, IconData icon, int index) {
    return BottomNavigationBarItem(
      label: label,
      icon: Icon(icon, color: _defaultColor),
      activeIcon: Icon(icon, color: _activeColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    _pages = [
      HomePage(onJumpTo: (index) => _onJumpTo(index, pageChange: false)),
      RankingPage(),
      FavoritePage(),
      ProfilePage()
    ];

    if (!_hasBuild) {
      //页面第一次打开时通知打开的是那个tab
      LinNavigator.getInstance()
          .onBottomTabChange(initialPage, _pages[initialPage]);
      _hasBuild = true;
    }

    return Scaffold(
      body: WillPopScope(
        onWillPop: exitApp,
        child: PageView(
          controller: _controller,
          children: _pages,
          onPageChanged: (index) => _onJumpTo(index, pageChange: true),
          physics: const NeverScrollableScrollPhysics(),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => _onJumpTo(index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: _activeColor,
        items: [
          _bottomItem('首页', Icons.home, 0),
          _bottomItem('排行', Icons.local_fire_department, 1),
          _bottomItem('收藏', Icons.favorite, 2),
          _bottomItem('我的', Icons.live_tv, 3),
        ],
      ),
    );
  }
}