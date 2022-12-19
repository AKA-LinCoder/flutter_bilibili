import 'package:flutter/material.dart';

/// FileName profile_page
///
/// @Author LinGuanYu
/// @Date 2022/12/19 14:39
///
/// @Description TODO
class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text("我的"),
    );
  }
}
