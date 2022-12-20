import 'package:flutter/material.dart';

import '../model/home_model.dart';
import '../widgets/lin_banner.dart';

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


  /// 轮播图
  _banner(List<BannerModel> bannerList) {
    return LinBanner(
      bannerList,
      padding: EdgeInsets.only(left: 5, right: 5),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          if (widget.bannerList != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: _banner(widget.bannerList!),
            ),
          Text(widget.categoryName),
        ],
      ),
    );
  }
}
