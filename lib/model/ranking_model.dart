/// FileName ranking_model
///
/// @Author LinGuanYu
/// @Date 2022/12/20 09:52
///
/// @Description TODO

import 'dart:convert';


import '../utils/model_util.dart';
import 'home_model.dart';

class RankingModel {
  RankingModel({
    required this.total,
    required this.list,
  });

  factory RankingModel.fromJson(Map<String, dynamic> jsonRes) {
    final List<VideoModel>? list =
    jsonRes['list'] is List ? <VideoModel>[] : null;
    if (list != null) {
      for (final dynamic item in jsonRes['list']!) {
        if (item != null) {
          list.add(VideoModel.fromJson(asT<Map<String, dynamic>>(item)!));
        }
      }
    }
    return RankingModel(
      total: asT<int>(jsonRes['total'])!,
      list: list!,
    );
  }

  int total;
  List<VideoModel> list;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'total': total,
    'list': list,
  };

  RankingModel clone() => RankingModel.fromJson(
      asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}