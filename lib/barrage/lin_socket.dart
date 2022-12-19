import 'package:flutter/cupertino.dart';
import 'package:flutter_bilibili/http/dao/login_dao.dart';
import 'package:flutter_bilibili/utils/lin_constants.dart';
import 'package:web_socket_channel/io.dart';

import '../model/barrage_model.dart';

/// FileName lin_socket
///
/// @Author LinGuanYu
/// @Date 2022/12/19 09:11
///
/// @Description TODO socket封装

class LinSocket implements ISocket{

  static const _URL = "";

  IOWebSocketChannel? _channel;
  ValueChanged<List<BarrageModel>>? _callBack;
  ///心跳间隔时间
  int _intervalSeconds = 50;


  @override
  void close() {
    if(_channel!=null){
      _channel?.sink.close();
    }
  }

  @override
  ISocket open(String vid) {
    _channel = IOWebSocketChannel.connect(_URL+vid,headers: _headers(),pingInterval: Duration(seconds: _intervalSeconds));
    _channel?.stream.handleError((error){
      print("连接错误$error");
    }).listen((message) {
      _handleMessage(message);
    });
    return this;
  }

  @override
  ISocket send(String message) {
    _channel?.sink.add(message);
    return this;
  }

  @override
  ISocket listen(ValueChanged<List<BarrageModel>> callBack) {
    _callBack = callBack;
    return this;
  }

  _headers() {
    Map<String,dynamic> header = {
      LinConstants.authTokenK:LinConstants.authTokenV,
      LinConstants.courseFlagK:LinConstants.courseFlagV
    };
    header["token"] = "";
    return header;
  }

  ///处理返回
  void _handleMessage(message) {
    print("received:$message");
    var result = BarrageModel.fromJsonString(message);
    if(result.isNotEmpty&&_callBack!=null){
      _callBack!(result);
    }
  }
  
}


abstract class ISocket {
  ///和服务器建立连接
  ISocket open(String vid);
  ///发送弹幕
  ISocket send(String message);
  ///关闭连接
  void close();
  ///接受弹幕
  ISocket listen(ValueChanged<List<BarrageModel>> callBack);
}