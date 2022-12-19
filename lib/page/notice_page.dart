import 'package:flutter/material.dart';

/// FileName notice_page
///
/// @Author LinGuanYu
/// @Date 2022/12/19 14:44
///
/// @Description TODO

class NoticePage extends StatefulWidget {
  NoticePage({Key? key}) : super(key: key);

  @override
  State<NoticePage> createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text("视频详情页"),
    );
  }
}