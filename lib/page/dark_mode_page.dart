import 'package:flutter/material.dart';

/// FileName dark_mode_page
///
/// @Author LinGuanYu
/// @Date 2022/12/19 14:44
///
/// @Description TODO

class DarkModePage extends StatefulWidget {
  DarkModePage({Key? key}) : super(key: key);

  @override
  State<DarkModePage> createState() => _DarkModePageState();
}

class _DarkModePageState extends State<DarkModePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text("视频详情页"),
    );
  }
}