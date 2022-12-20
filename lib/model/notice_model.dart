import 'dart:convert';

import '../utils/model_util.dart';
import 'home_model.dart';

/// FileName notice_model
///
/// @Author LinGuanYu
/// @Date 2022/12/20 09:51
///
/// @Description TODO

class NoticeModel {
  NoticeModel({
    required this.total,
    required this.list,
  });

  factory NoticeModel.fromJson(Map<String, dynamic> jsonRes) {
    final List<BannerModel>? list =
    jsonRes['list'] is List ? <BannerModel>[] : null;
    if (list != null) {
      for (final dynamic item in jsonRes['list']!) {
        if (item != null) {
          list.add(BannerModel.fromJson(asT<Map<String, dynamic>>(item)!));
        }
      }
    }
    return NoticeModel(
      total: asT<int>(jsonRes['total'])!,
      list: list!,
    );
  }

  int total;
  List<BannerModel> list;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'total': total,
    'list': list,
  };

  NoticeModel clone() => NoticeModel.fromJson(
      asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}