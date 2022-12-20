import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_bilibili/model/home_model.dart';

import '../model/video_detail_model.dart';
import '../widgets/navigation_bar.dart';

/// FileName video_detail_page
///
/// @Author LinGuanYu
/// @Date 2022/12/19 14:27
///
/// @Description TODO

class VideoDetailPage extends StatefulWidget {
  final VideoModel videoModel;
   VideoDetailPage({Key? key,required this.videoModel}) : super(key: key);

  @override
  State<VideoDetailPage> createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MediaQuery.removePadding(context: context, child:  LinNavigationBar(
        color: Colors.black,
        statusStyle: StatusStyle.LIGHT_CONTENT,
        height: Platform.isAndroid ? 0 : 46,
      ),),
    );
  }
}

// class VideoDetailPage extends StatefulWidget {
//   final VideoModel videoInfo;
//
//   const VideoDetailPage(this.videoInfo, {Key? key}) : super(key: key);
//
//   @override
//   _VideoDetailPageState createState() => _VideoDetailPageState();
// }
//
// class _VideoDetailPageState extends State<VideoDetailPage>
//     with TickerProviderStateMixin {
//   /// 控制器
//   TabController? _controller;
//
//   /// 视频信息
//   VideoModel? videoInfo;
//
//   /// 标签列表
//   List<String> tabs = ['简介', '评论'];
//
//   /// 详情信息
//   VideoDetailModel? detailInfo;
//
//   /// 视频列表
//   List<VideoModel> videoList = [];
//
//   /// 弹幕 key
//   var _barrageKey = GlobalKey<LinBarrageState>();
//
//   /// 输入框显示
//   bool _inoutShowing = false;
//
//   /// 主题
//   ThemeProvider? _themeProvider;
//
//   @override
//   initState() {
//     super.initState();
//     _themeProvider = context.read<ThemeProvider>();
//     videoInfo = widget.videoInfo;
//     // 黑色状态栏，仅Android
//     changeStatusBar(
//       color: Colors.black,
//       statusStyle: StatusStyle.LIGHT_CONTENT,
//     );
//     _controller = TabController(
//       length: tabs.length,
//       vsync: this,
//     );
//     _loadDetail();
//   }
//
//   @override
//   void dispose() {
//     _controller?.dispose();
//     super.dispose();
//   }
//
//   /// 获取数据
//   void _loadDetail() async {
//     try {
//       VideoDetailModel result = await VideoDetailDao.get(videoInfo!.vid);
//       setState(() {
//         detailInfo = result;
//         // 更新旧的数据
//         videoInfo = result.videoInfo;
//         videoList = result.videoList;
//       });
//     } on NeedAuth catch (e) {
//       showWarnToast(e.message);
//     } on LinNetError catch (e) {
//       showWarnToast(e.message);
//     }
//   }
//
//   /// 喜欢
//   _onLike() async {
//     try {
//       await LikeDao.like(videoInfo!.vid, !detailInfo!.isLike);
//       detailInfo!.isLike = !detailInfo!.isLike;
//       if (detailInfo!.isLike) {
//         videoInfo!.like = videoInfo!.like ?? 0 + 1;
//       } else {
//         videoInfo!.like = videoInfo!.like ?? 0 - 1;
//       }
//       setState(() {
//         videoInfo = videoInfo;
//         detailInfo = detailInfo;
//       });
//     } on NeedAuth catch (e) {
//       showWarnToast(e.message);
//     } on LinNetError catch (e) {
//       showWarnToast(e.message);
//     }
//   }
//
//   /// 不喜欢
//   _onUnLike() async {}
//
//   /// 收藏
//   _onFavorite() async {
//     try {
//       await FavoriteDao.favorite(videoInfo!.vid, !detailInfo!.isFavorite);
//       detailInfo!.isFavorite = !detailInfo!.isFavorite;
//       if (detailInfo!.isFavorite) {
//         videoInfo!.favorite = videoInfo!.favorite ?? 0 + 1;
//       } else {
//         videoInfo!.favorite = videoInfo!.favorite ?? 0 - 1;
//       }
//       setState(() {
//         videoInfo = videoInfo;
//         detailInfo = detailInfo;
//       });
//     } on NeedAuth catch (e) {
//       showWarnToast(e.message);
//     } on LinNetError catch (e) {
//       showWarnToast(e.message);
//     }
//   }
//
//   /// 播放器
//   Widget _buildVideoView() {
//     return VideoView(
//       videoInfo!.url!,
//       cover: videoInfo!.cover!,
//       overlayUI: videoAppBar(),
//       barrageUI: LinBarrage(
//         headers: LinConstants.headers(),
//         key: _barrageKey,
//         vid: videoInfo!.vid,
//         autoPlay: true,
//       ),
//     );
//   }
//
//   /// 底部
//   Widget _buildTabNavigation() {
//     return Material(
//       elevation: 5,
//       shadowColor:
//       _themeProvider!.isDark() ? LinColor.dark_bg : Colors.grey[100],
//       child: Container(
//         alignment: Alignment.centerLeft,
//         padding: EdgeInsets.only(left: 20),
//         height: 39,
//         color: _themeProvider!.isDark() ? LinColor.dark_bg : Colors.white,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [_tabBar(), _buildBarrageBtn()],
//         ),
//       ),
//     );
//   }
//
//   /// 选项卡
//   Widget _tabBar() {
//     return LinTab(
//       tabs.map<Tab>((name) {
//         return Tab(
//           text: name,
//         );
//       }).toList(),
//       controller: _controller,
//     );
//   }
//
//   Widget _buildBarrageBtn() {
//     return BarrageSwitch(
//         inoutShowing: _inoutShowing,
//         onShowInput: () {
//           setState(() {
//             _inoutShowing = true;
//           });
//           LinOverlay.show(context, child: BarrageInput(
//             onTabClose: () {
//               setState(() {
//                 _inoutShowing = false;
//               });
//             },
//           )).then((value) {
//             print('---input:$value');
//             _barrageKey.currentState!.send(value);
//           });
//         },
//         onBarrageSwitch: (open) {
//           if (open) {
//             _barrageKey.currentState!.play();
//           } else {
//             _barrageKey.currentState!.pause();
//           }
//         });
//   }
//
//   /// 底部详情
//   Widget _buildDetailList() {
//     return ListView(
//       padding: EdgeInsets.all(0),
//       children: [
//         ...buildContents(),
//         ..._buildVideoList(),
//       ],
//     );
//   }
//
//   List<Widget> buildContents() {
//     return [
//       VideoHeader(owner: videoInfo!.owner),
//       ExpandableContent(videoInfo: videoInfo!),
//       VideoToolBar(
//         videoInfo: videoInfo!,
//         detailInfo: detailInfo,
//         onLike: _onLike,
//         onUnLike: _onUnLike,
//         onFavorite: _onFavorite,
//       ),
//     ];
//   }
//
//   List<Widget> _buildVideoList() {
//     return videoList
//         .map<VideoLargeCard>((VideoModel videoInfo) => VideoLargeCard(videoInfo: videoInfo))
//         .toList();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: MediaQuery.removePadding(
//         removeTop: Platform.isIOS,
//         context: context,
//         child: videoInfo!.url != null
//             ? Column(
//           children: [
//             /// iOS 黑色状态栏
//             LinNavigationBar(
//               color: Colors.black,
//               statusStyle: StatusStyle.LIGHT_CONTENT,
//               height: Platform.isAndroid ? 0 : 46,
//             ),
//             _buildVideoView(),
//             _buildTabNavigation(),
//             Flexible(
//               child: TabBarView(
//                 controller: _controller,
//                 children: [
//                   _buildDetailList(),
//                   Container(
//                     child: Text('敬请期待...'),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         )
//             : Container(),
//       ),
//     );
//   }
// }