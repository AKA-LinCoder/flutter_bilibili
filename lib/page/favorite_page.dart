import 'package:flutter/material.dart';

/// FileName favorite_page
///
/// @Author LinGuanYu
/// @Date 2022/12/19 14:39
///
/// @Description TODO

class FavoritePage extends StatefulWidget {
  FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text("视频详情页"),
    );
  }
}
