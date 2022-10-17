import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../http/core/lin_error.dart';
import '../http/dao/login_dao.dart';
import '../utils/string_util.dart';
import '../utils/toast_util.dart';
import '../widgets/appbar.dart';
import '../widgets/login_button.dart';
import '../widgets/login_effect.dart';
import '../widgets/login_input.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with AutomaticKeepAliveClientMixin {
  bool protect = false;
  bool loginEnable = false;

  String? userName;
  String? password;

  var images = [
    "http://192.168.0.148/group1/M00/00/0A/wKgANWDe0LGAewgnAF5GQAtUJ1Y217.jpg",
    "http://192.168.0.148/group1/M00/00/0A/wKgANWDe0IGAAYUpAF7idru_08o608.jpg",
    "http://192.168.0.148/group1/M00/00/0A/wKgANWDe0OOASGHYAGXEc3p3ETU453.jpg",
    "http://192.168.0.148/group1/M00/00/0A/wKgANWDe0IKAF2pTAGDhcNPrhy8397.jpg",
    "http://192.168.0.148/group1/M00/00/0A/wKgANWDe0LGAVmwuAFG25I8Ak20843.jpg",
    "http://192.168.0.148/group1/M00/00/0A/wKgANWDe0LKAHdfTAGBxz6Ipkxs014.jpg",
  ];

  List<Widget> Item(List<String> files) {
    return List.generate(files.length, (index) {
      return GestureDetector(
        onTap: () {
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (_) => PhotoPreview(
          //               galleryItems: [files[index]],
          //               defaultImage: index,
          //             )));
        },
        child: Container(
          width: 50,
          height: 50,
          alignment: Alignment.center,
          child: CachedNetworkImage(
            filterQuality: FilterQuality.none,
            imageUrl: files[index],
            placeholder: (context, url) => CircularProgressIndicator(),
            // errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          // child: FadeInImage.assetNetwork(placeholder: "images/logo.png", image: files[index]),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text('images'),
    //   ),
    //   body: SingleChildScrollView(
    //     child: Padding(
    //       padding: EdgeInsets.all(8),
    //       child: Container(
    //         width: double.infinity,
    //         child: ListView(
    //           shrinkWrap: true,
    //           children: Item(images),
    //         ),
    //         // child: Wrap(
    //         //   spacing: 5,
    //         //   runSpacing: 5,
    //         //   children: Item(images),
    //         // ),
    //       ),
    //     ),
    //   ),
    // );

    return Scaffold(
      appBar: appBar("登录", "注册", () {}),
      body: Container(
        child: ListView(
          children: [
            LoginEffect(protect: protect),
            LoginInput(
              title: "用户名",
              hint: "请输入用户名",
              onChanged: (text) {
                userName = text;
                checkInput();
              },
            ),
            LoginInput(
              title: "密码",
              hint: "请输入密码",
              obscureText: true,
              focusChanged: (focus) {
                setState(() {
                  protect = focus;
                });
              },
              onChanged: (text) {
                password = text;
                checkInput();
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
              child: LoginButton(
                title: '登录',
                onPressed: send,
                enable: loginEnable,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void checkInput() {
    bool enable = false;
    if (isNotEmpty(userName) && isNotEmpty(password)) {
      enable = true;
    }

    setState(() {
      loginEnable = enable;
    });
  }

  void send() async {
    var testStandard = ("FCI70 2").replaceAll(RegExp(r"\s+\b|\b\s"), "");
    testStandard = testStandard.replaceAll(RegExp("-"), "");
    print('这是来自维修任务的试压标准$testStandard');

    try {
      var res = await LoginDao.login(userName!, password!);
      print(res);
      if (res["code"] == 200) {
        showToast("登录成功");
      } else {
        showWarnToast(res['message']);
      }
    } on NeedAuth catch (e) {
      print('这是error1:${e.data}');
      showWarnToast(e.message);
    } on LinNetError catch (e) {
      print('这是error2:${e.data}');
      showWarnToast(e.message);
    } catch (e) {
      print('这是error3:${e.toString()}');
      showWarnToast(e.toString());
    }
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
