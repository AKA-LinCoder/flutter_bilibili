import 'package:flutter/material.dart';

/// FileName home_tab_page
///
/// @Author LinGuanYu
/// @Date 2022/12/20 09:17
///
/// @Description TODO

class HomeTabPage extends StatefulWidget {
  String name;
  HomeTabPage({Key? key,required this.name}) : super(key: key);

  @override
  State<HomeTabPage> createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(widget.name),
    );
  }
}
