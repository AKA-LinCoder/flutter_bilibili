import 'dart:convert';

/// FileName barrage_model
///
/// @Author LinGuanYu
/// @Date 2022/12/19 09:54
///
/// @Description TODO

class BarrageModel {
  BarrageModel({
    this.content,
    this.vid,
    this.priority,
    this.type,

  });

  ///UID
  String? content;
  ///学员姓名
  String? vid;
  ///学生单位
  String? priority;
  ///身份证号
  String? type;


  factory BarrageModel.fromJson(Map<String, dynamic> json) => BarrageModel(
    content: json["content"],
    vid: json["vid"],
    type: json["type"],
    priority: json["priority"],
  );


  static List<BarrageModel> fromJsonString(json){
    List<BarrageModel> list = [];
    if(json is! String|| !json.startsWith('[')){
      print("格式错误");
      return [];
    }

    var jsonArray = jsonDecode(json);
    jsonArray.forEach((v){
      list.add(BarrageModel.fromJson(v));
    });

    return list;
  }


  Map<String, dynamic> toJson() => {
    "content": content,
    "vid": vid,
    "type": type,
    "priority": priority,
  };
}