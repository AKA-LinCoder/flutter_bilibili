import 'package:flutter/material.dart';
import 'package:flutter_bilibili/model/test_model.dart';
import 'package:flutter_bilibili/navigator/lin_navigator.dart';
import 'package:flutter_bilibili/page/home_tab_page.dart';
import 'package:flutter_bilibili/utils/colors.dart';
import 'package:flutter_bilibili/utils/lin_state.dart';
import 'package:flutter_bilibili/widgets/loading_container.dart';
import 'package:flutter_bilibili/widgets/navigation_bar.dart';
import 'package:underline_indicator/underline_indicator.dart';

import '../http/core/lin_error.dart';
import '../http/dao/home_dao.dart';
import '../model/home_model.dart';
import '../utils/toast_util.dart';
import '../widgets/view_uilt.dart';

/// FileName home_page
///
/// @Author LinGuanYu
/// @Date 2022/12/19 14:23
///
/// @Description TODO
///

class HomePage extends StatefulWidget {
  final ValueChanged<int>? onJumpTo;
  const HomePage({Key? key, this.onJumpTo}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends LinState<HomePage> with TickerProviderStateMixin,AutomaticKeepAliveClientMixin,WidgetsBindingObserver {
  TabController? tabController;
  /// 类别列表
  List<CategoryModel> categoryList = [];

  /// 轮播图列表
  List<BannerModel> bannerList = [];


  /// 加载状态
  bool _isLoading = true;

  /// 缓存页面
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    tabController = TabController(length:  categoryList.length, vsync: this);
    LinNavigator.getInstance().addListener((current, pre) {
      print("current:${current.page}");
      print("pre:${pre?.page}");
      if (widget == current.page || current.page is HomePage) {
        print("当前页面被打开 onResume");
      } else if (widget == pre?.page || pre?.page is HomePage) {
        print("首页 onPause");
      }
    });
    loadData();
  }

  /// 加载数据
  void loadData() async {
    try {
      HomeModel res = await HomeDao.get('推荐');

      setState(() {
        if (res.categoryList != null) {
          tabController =
              TabController(length: res.categoryList?.length ?? 0, vsync: this);
        }
        categoryList = res.categoryList ?? [];
        bannerList = res.bannerList ?? [];
        _isLoading = false;
      });
    } on NeedAuth catch (e) {
      showWarnToast(e.message);
      setState(() {
        _isLoading = false;
      });
    } on LinNetError catch (e) {
      showWarnToast(e.message);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    tabController?.dispose();
    WidgetsBinding.instance?.removeObserver(this);
    // LinNavigator.getInstance().removeListener((this.)
    // TODO: implement dispose
    super.dispose();
  }

  /// 监听应用生命周期变化
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
    // 处于这种状态的应用程序应该假设它们可能在任何时候暂停。
      case AppLifecycleState.inactive:
        break;
    // 从后台切换前台，界面可见
      case AppLifecycleState.resumed:
      // fix Android 压后台首页状态栏字体颜色变白，详情页状态栏字体变黑问题
        changeStatusBar();
        break;
    // 界面不可见，后台
      case AppLifecycleState.paused:
        break;
    // APP 结束时调用
      case AppLifecycleState.detached:
        break;
    }
  }


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      // appBar: AppBar(),
      body: LoadingContainer(
        isLoading: _isLoading,
        child: Column(
          children: [
             LinNavigationBar(
              child: _appBar(),
              height: 50,
              color: Colors.white,
              statusStyle: StatusStyle.DARK_CONTENT,
            ),
            Container(
              decoration: bottomBoxShadow(context),
              child: _tabBar(),
            ),
            Flexible(child: TabBarView(
              controller: tabController,
              ///只有第一个需要展示轮播图
              children: categoryList.map((tab) => HomeTabPage(
                categoryName: tab.name,
                bannerList: tab.name == '推荐' ? bannerList : null,
              )).toList(),
            ))
          ],
        ),
      ),
    );
  }

  /// appBar
  Widget _appBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              if (widget.onJumpTo != null) {
                widget.onJumpTo!(3);
              }
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(23),
              child: const Image(
                height: 46,
                width: 46,
                image: AssetImage('images/avatar.png'),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: const EdgeInsets.only(left: 10),
                  height: 32,
                  alignment: Alignment.centerLeft,
                  child: const Icon(Icons.search, color: Colors.grey),
                  decoration: BoxDecoration(color: Colors.grey[100]),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              // _mockCrash();
            },
            child: const Icon(
              Icons.explore_outlined,
              color: Colors.grey,
            ),
          ),
          InkWell(
            onTap: () {
              LinNavigator.getInstance().onJumpTo(RouteStatus.notice);
            },
            child: const Padding(
              padding: EdgeInsets.only(left: 12),
              child: Icon(
                Icons.mail_outline,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }


  _tabBar() {
    return TabBar(
      tabs: categoryList.map<Tab>((e) => Tab(child: Padding(
        padding: EdgeInsets.zero,
        child: Text(e.name),
      ),)).toList(),
      controller: tabController,
      isScrollable: true,
      labelColor: Colors.black,
      indicator: const UnderlineIndicator(
          strokeCap: StrokeCap.round,
          borderSide: BorderSide(color: primary, width: 3),
          insets: EdgeInsets.only(left: 15, right: 15)),
    );
  }
}
