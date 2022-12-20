import 'package:flutter/material.dart';

import '../model/home_model.dart';

/// FileName home_tab_page
///
/// @Author LinGuanYu
/// @Date 2022/12/20 09:17
///
/// @Description TODO

class HomeTabPage extends StatefulWidget {
  /// 类别
  final String categoryName;

  /// 轮播图列表
  final List<BannerModel>? bannerList;

  const HomeTabPage({Key? key, required this.categoryName, this.bannerList})
      : super(key: key);

  @override
  State<HomeTabPage> createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(widget.categoryName),
    );
  }
}
