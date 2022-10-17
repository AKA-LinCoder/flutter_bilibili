import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../utils/string_util.dart';
import '../widgets/appbar.dart';
import '../widgets/login_button.dart';
import '../widgets/login_effect.dart';
import '../widgets/login_input.dart';

class RegistrationPage extends StatefulWidget {
  final VoidCallback onJumpToLogin;
  const RegistrationPage({Key? key, required this.onJumpToLogin})
      : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool protect = false;
  bool loginEnable = false;

  String? userName;
  String? password;
  String? rePassword;
  String? phone;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("注册", "登录", widget.onJumpToLogin),
      body: Container(
        child: ListView(
          ///自适应键盘弹起，防止遮挡
          children: [
            LoginEffect(protect: protect),
            LoginInput(
              title: "用户名",
              hint: "请输入用户名",
              onChanged: (text) {
                userName = text;
                checkInput();
                if (kDebugMode) {
                  print(text);
                }
              },
            ),
            LoginInput(
              title: "密码",
              hint: "请输入密码",
              lineStretch: true,
              obscureText: true,
              focusChanged: (focus) {
                setState(() {
                  protect = focus;
                });
              },
              onChanged: (text) {
                password = text;
                checkInput();
                if (kDebugMode) {
                  print(text);
                }
              },
            ),
            LoginInput(
              title: "确认密码",
              hint: "请确认密码",
              lineStretch: true,
              obscureText: true,
              focusChanged: (focus) {
                setState(() {
                  protect = focus;
                });
              },
              onChanged: (text) {
                rePassword = text;
                checkInput();
                if (kDebugMode) {
                  print(text);
                }
              },
            ),
            LoginInput(
              title: "电话",
              hint: "请输入电话",
              lineStretch: true,
              obscureText: true,
              keyboardType: TextInputType.number,
              focusChanged: (focus) {
                setState(() {
                  protect = focus;
                });
              },
              onChanged: (text) {
                phone = text;
                checkInput();
                if (kDebugMode) {
                  print(text);
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
              child: LoginButton(
                title: '注册',
                enable: loginEnable,
                onPressed: () {
                  if (loginEnable) {
                    checkParams();
                  } else {
                    print('请填写数据');
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void checkInput() {
    bool enable = false;
    if (isNotEmpty(userName) &&
        isNotEmpty(password) &&
        isNotEmpty(rePassword) &&
        isNotEmpty(phone)) {
      enable = true;
    }

    setState(() {
      loginEnable = enable;
    });
  }

  _loginButton() {
    return InkWell(
      onTap: () {
        if (loginEnable) {
          checkParams();
        } else {
          print('请填写数据');
        }
      },
      child: const Text('注册'),
    );
  }

  void send() async {}

  void checkParams() {
    String? tips;
    if (password != rePassword) {
      tips = "两次密码不一致";
    }
    print(tips);
    if (tips != null) {
      return;
    }
    send();
  }
}
