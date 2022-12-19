import 'package:flutter/material.dart';

/// FileName ranking_page
///
/// @Author LinGuanYu
/// @Date 2022/12/19 14:39
///
/// @Description TODO

class RankingPage extends StatefulWidget {
  RankingPage({Key? key}) : super(key: key);

  @override
  State<RankingPage> createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text("视频详情页"),
    );
  }
}
