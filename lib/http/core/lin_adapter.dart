import 'dart:convert';

import 'package:flutter_bilibili/http/request/base_request.dart';
///网络请求抽象类
abstract class LinNetAdapter{
  Future<LinNetResponse<T>> send<T>(BaseRequest request);
}



///统一网络层返回格式
class LinNetResponse<T>{
  LinNetResponse({this.data, this.request, this.statusCode, this.statusMessage, this.extra});
  T? data;
  BaseRequest? request;
  int? statusCode;
  String? statusMessage;
  dynamic extra;


  @override
  String toString() {
    // TODO: implement toString
    if(data is Map){
      return json.encode(data);
    }
    return data.toString();
  }

}