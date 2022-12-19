import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../http/core/lin_error.dart';
import '../http/dao/login_dao.dart';
import '../navigator/lin_navigator.dart';
import '../utils/string_util.dart';
import '../utils/toast_util.dart';
import '../widgets/appbar.dart';
import '../widgets/login_button.dart';
import '../widgets/login_effect.dart';
import '../widgets/login_input.dart';

/// 登录页
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  /// 是否保护
  bool protect = false;

  /// 按钮是否可点击
  bool loginEnable = false;

  /// 用户名
  String? userName;

  /// 密码
  String? password;

  /// 设置登录按钮
  void checkInput() {
    bool enable;
    if (isNotEmpty(userName) && isNotEmpty(password)) {
      enable = true;
    } else {
      enable = false;
    }
    setState(() {
      loginEnable = enable;
    });
  }

  /// 登录
  void send() async {
    try {
      ///username:18404969231
      ///password:wkl123456
      var result = await LoginDao.login(userName!, password!);
      if (result['code'] == 0) {
        showToast('登录成功');
        ///跳转到首页
        LinNavigator.getInstance().onJumpTo(RouteStatus.home);
      } else {
        showWarnToast(result['msg']);
      }
    } on NeedAuth catch (e) {
      showWarnToast(e.message);
    } on LinNetError catch (e) {
      showWarnToast(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('密码登录', '注册', () {
        LinNavigator.getInstance().onJumpTo(RouteStatus.registration);
      }, key: const Key('registration')),
      body: Container(
        child: ListView(
          children: [
            LoginEffect(protect: protect),
            LoginInput(
              title: '用户名',
              hint: '请输入用户',
              onChanged: (text) {
                userName = text;
                checkInput();
              },
            ),
            LoginInput(
              title: '密码',
              obscureText: true,
              onChanged: (text) {
                password = text;
                checkInput();
              },
              focusChanged: (focus) {
                setState(() {
                  protect = focus;
                });
              }, hint: '请输入密码',
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: LoginButton(
                enable: loginEnable,
                onPressed: send, title: '登录',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
