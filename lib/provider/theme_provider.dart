import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../db/lin_cache.dart';
import '../utils/colors.dart';
import '../utils/lin_constants.dart';

/// FileName theme_provider
///
/// @Author LinGuanYu
/// @Date 2022/12/19 14:49
///
/// @Description TODO

extension ThemeModeExtension on ThemeMode {
  String get value => <String>['System', 'Light', 'Dark'][index];
}

class ThemeProvider extends ChangeNotifier {
  ThemeMode? _themeMode;
  var _platformBrightness =
      SchedulerBinding.instance?.window.platformBrightness;

  /// 系统Dark Mode发生变化
  void darModeChange() {
    if (_platformBrightness !=
        SchedulerBinding.instance?.window.platformBrightness) {
      _platformBrightness =
          SchedulerBinding.instance?.window.platformBrightness;
      notifyListeners();
    }
  }

  /// 判断是否是Dark Mode
  bool isDark() {
    if (_themeMode == ThemeMode.system) {
      //获取系统的Dark Mode
      return SchedulerBinding.instance?.window.platformBrightness ==
          Brightness.dark;
    }
    return _themeMode == ThemeMode.dark;
  }

  /// 获取主题模式
  ThemeMode getThemeMode() {
    String? theme = LinCache.getInstance().get(LinConstants.theme);
    switch (theme) {
      case 'Dark':
        _themeMode = ThemeMode.dark;
        break;
      case 'System':
        _themeMode = ThemeMode.system;
        break;
      default:
        _themeMode = ThemeMode.light;
        break;
    }
    return _themeMode!;
  }

  /// 设置主题
  void setTheme(ThemeMode themeMode) {
    LinCache.getInstance().setString(LinConstants.theme, themeMode.value);
    notifyListeners();
  }

  /// 获取主题
  ThemeData getTheme({bool isDarkMode = false}) {
    var themeData = ThemeData(
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      errorColor: isDarkMode ? LinColor.dark_red : LinColor.red,
      primaryColor: isDarkMode ? LinColor.dark_bg : white,
      accentColor: isDarkMode ? primary[50] : white,
      // Tab指示器的颜色
      indicatorColor: isDarkMode ? primary[50] : white,
      // 页面背景色
      scaffoldBackgroundColor: isDarkMode ? LinColor.dark_bg : white,
    );
    return themeData;
  }
}