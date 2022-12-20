import 'package:flutter/material.dart';
import 'package:flutter_bilibili/model/test_model.dart';
import 'package:flutter_bilibili/navigator/lin_navigator.dart';
import 'package:flutter_bilibili/page/home_tab_page.dart';
import 'package:flutter_bilibili/utils/colors.dart';
import 'package:underline_indicator/underline_indicator.dart';

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

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController tabController;
  var tabs = ["推荐", "热门", "追番", "影视", "搞笑", "日常", "综合", "手机游戏", "配音"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: tabs.length, vsync: this);
    LinNavigator.getInstance().addListener((current, pre) {
      print("current:${current.page}");
      print("pre:${pre?.page}");
      if (widget == current.page || current.page is HomePage) {
        print("当前页面被打开 onResume");
      } else if (widget == pre?.page || pre?.page is HomePage) {
        print("首页 onPause");
      }
    });
  }

  @override
  void dispose() {
    // LinNavigator.getInstance().removeListener((this.)
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.only(top: 50),
            child: _tabBar(),
          ),
          Flexible(child: TabBarView(
            controller: tabController,
            children: tabs.map((e) => HomeTabPage(name: e)).toList(),
          ))
        ],
      ),
    );
  }

  _tabBar() {
    return TabBar(
      tabs: tabs.map<Tab>((e) => Tab(child: Padding(
        padding: EdgeInsets.zero,
        child: Text(e),
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
