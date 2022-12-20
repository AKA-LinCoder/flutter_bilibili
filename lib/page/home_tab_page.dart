import 'package:flutter/material.dart';
import 'package:flutter_nested/flutter_nested.dart';

import '../http/dao/home_dao.dart';
import '../model/home_model.dart';
import '../utils/lin_base_tab_state.dart';
import '../widgets/lin_banner.dart';
import '../widgets/video_card.dart';

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

class _HomeTabPageState
    extends LinBaseTabState<HomeModel, VideoModel, HomeTabPage> {
  /// 轮播图
  _banner(List<BannerModel> bannerList) {
    return LinBanner(
      bannerList,
      padding: EdgeInsets.only(left: 5, right: 5),
    );
  }

  @override
  get contentChild => HiNestedScrollView(
    controller: scrollController,
    itemCount: dataList.length,
    padding: EdgeInsets.only(top: 10, left: 10, right: 10),
    headers: [
      if (widget.bannerList != null)
        Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: _banner(widget.bannerList!),
        ),
    ],
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, childAspectRatio: 0.82),
    itemBuilder: (BuildContext context, int index) {
      return VideoCard(videoInfo: dataList[index]);
    },
  );

  @override
  Future<HomeModel> getData(int pageIndex) async {
    HomeModel result =
    await HomeDao.get(widget.categoryName, pageIndex: pageIndex);
    return result;
  }

  @override
  List<VideoModel> parseList(HomeModel result) {
    return result.videoList;
  }
}
