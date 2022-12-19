import 'package:flutter/material.dart';
import 'package:flutter_bilibili/db/lin_cache.dart';
import 'package:flutter_bilibili/page/login_page.dart';
import 'package:flutter_bilibili/page/registration_page.dart';
import 'package:flutter_bilibili/utils/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    LinCache.preInit();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: white,
      ),
      // home: RegistrationPage(
      //   onJumpToLogin: () {
      //
      //   },
      // ),
      home: const LoginPage(),
    );
  }
}
