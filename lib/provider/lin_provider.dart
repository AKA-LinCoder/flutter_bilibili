/// FileName lin_provider
///
/// @Author LinGuanYu
/// @Date 2022/12/19 14:48
///
/// @Description TODO

import 'package:flutter_bilibili/provider/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> topProviders = [
  ChangeNotifierProvider(create: (_) => ThemeProvider())
];