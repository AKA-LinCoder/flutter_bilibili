import 'package:flutter_bilibili/http/core/lin_adapter.dart';
import 'package:flutter_bilibili/http/core/lin_error.dart';
import 'package:flutter_bilibili/http/request/base_request.dart';

import 'dio_adapter.dart';
import 'lin_interceptor.dart';

///1.支持网络库插拔设计，且不干扰业务层
///2.基于配置请求请求，简洁易用
///3.Adapter设计，扩展性强
///4.统一异常和返回处理
class LinNet {
  LinNet._();

  LinErrorInterceptor? _linErrorInterceptor;
  static LinNet? _instance;

  static LinNet getInstance() {
    _instance ??= LinNet._();
    return _instance!;
  }

  Future fire(BaseRequest request) async {
    LinNetResponse? response;
    var error;
    try {
      response = await send(request);
    } on LinNetError catch (e) {
      error = e;
      response = e.data;
      printLog(e.message);
    } catch (e) {
      //其它异常
      error = e;
      printLog(e);
    }
    if (response == null) {
      printLog(error);
    }
    var result = response?.data;
    printLog(result);
    var status = response?.statusCode;
    LinNetError hiError;
    switch (status) {
      case 200:
        return result;
        break;
      case 401:
        hiError = NeedLogin();
        break;
      case 403:
        hiError = NeedAuth(result.toString(), data: result);
        break;
      default:
        hiError = LinNetError(status??-1, result.toString(), data: result);
        break;
    }
    //交给拦截器处理错误
    if (_linErrorInterceptor != null) {
      _linErrorInterceptor!(hiError);
    }
    throw hiError;
  }

  Future<LinNetResponse<dynamic>> send<T>(BaseRequest request) async {
    ///使用Dio发送请求
    LinNetAdapter adapter = DioAdapter();
    return adapter.send(request);
  }

  void setErrorInterceptor(LinErrorInterceptor interceptor) {
    _linErrorInterceptor = interceptor;
  }

  void printLog(log) {
    print('lin_net:' + log.toString());
  }
}