import 'package:flutter_bilibili/http/core/lin_adapter.dart';
import 'package:flutter_bilibili/http/core/lin_error.dart';
import 'package:flutter_bilibili/http/request/base_request.dart';

class LinNet{
  LinNet._();
  static LinNet? _instance;
  static LinNet getInstance(){
    _instance ??= LinNet._();
    return _instance!;
  }

  Future fire(BaseRequest request) async{
    LinNetResponse? resonse;
    var error;
    try{
      resonse = await send(request);
    } on LinNetError catch(e){
      error = e;
      resonse = e.data;
      printLog(e);
    } catch (e){
      //其他异常
      error = e;
      printLog(e);
    }
    if(resonse==null){
      printLog(error);
    }
    var result = resonse?.data;


    return result;
  }

  Future<dynamic> send<T>(BaseRequest request)async{
    request.addHeader("token", "123");
    return Future.value({"code":200,"data":{}});
  }

  void printLog(log){
    print('log:${log.toString()}');
  }
}