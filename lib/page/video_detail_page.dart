import 'package:flutter/material.dart';
import 'package:flutter_bilibili/model/home_model.dart';

import '../model/video_detail_model.dart';

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
      appBar: AppBar(),
      body: Text("视频详情页"),
    );
  }
}
