/// FileName lin_base_tab_state
///
/// @Author LinGuanYu
/// @Date 2022/12/20 14:41
///
/// @Description TODO

import 'package:flutter/material.dart';
import 'package:flutter_bilibili/utils/lin_state.dart';

import 'package:flutter_bilibili/utils/toast_util.dart';

import '../http/core/lin_error.dart';
import 'colors.dart';

/// 通用底层带分页和刷新的页面框架
/// M为Dao返回数据模型，L为列表数据模型，T为具体widget
abstract class LinBaseTabState<M, L, T extends StatefulWidget> extends LinState<T>
    with AutomaticKeepAliveClientMixin {
  /// 列表
  List<L> dataList = [];

  /// 第一页
  int pageIndex = 1;

  /// 加载状态
  bool loading = false;

  /// 控制器
  ScrollController scrollController = ScrollController();

  get contentChild;

  /// 页面缓存
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      var dis = scrollController.position.maxScrollExtent -
          scrollController.position.pixels;
      if (dis < 300 &&
          !loading &&
          // fix 当列表高度不满屏幕高度时不执行加载更多
          scrollController.position.maxScrollExtent != 0) {
        loadData(loadMore: true);
      }
    });
    loadData();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  /// 获取对应页码的数据
  Future<M> getData(int pageIndex);

  /// 从MO中解析出list数据
  List<L> parseList(M result);

  /// 加载数据
  Future<void> loadData({loadMore = false}) async {
    if (loading) return;
    loading = true;
    if (!loadMore) pageIndex = 1;
    var currentIndex = pageIndex + (loadMore ? 1 : 0);
    try {
      var result = await getData(currentIndex);
      setState(() {
        if (loadMore) {
          // 合成一个新数组
          dataList = [...dataList, ...parseList(result)];
          if (parseList(result).length != 0) {
            pageIndex++;
          }
        } else {
          dataList = parseList(result);
        }
      });
      Future.delayed(Duration(milliseconds: 1000), () {
        loading = false;
      });
    } on NeedAuth catch (e) {
      loading = false;
      showWarnToast(e.message);
    } on LinNetError catch (e) {
      loading = false;
      showWarnToast(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: loadData,
      color: primary,
      child: MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: contentChild,
      ),
    );
  }
}
