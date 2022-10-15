import 'package:dio/dio.dart';
import 'package:flutter_bilibili/http/core/lin_adapter.dart';
import 'package:flutter_bilibili/http/core/lin_error.dart';
import 'package:flutter_bilibili/http/request/base_request.dart';

class DioAdapter extends LinNetAdapter{
  @override
  Future<LinNetResponse<T>> send<T>(BaseRequest request) async {
    var response, options = Options(headers: request.header);
    var error;
    try {
      if (request.httpMethod() == HttpMethod.GET) {
        response = await Dio().get(request.url(), options: options);
      } else if (request.httpMethod() == HttpMethod.POST) {
        response = await Dio()
            .post(request.url(), data: request.params, options: options);
      } else if (request.httpMethod() == HttpMethod.DELETE) {
        response = await Dio()
            .delete(request.url(), data: request.params, options: options);
      }
    } on DioError catch (e) {
      error = e;
      response = e.response;
    }
    if (error != null) {
      ///抛出LinNetError
      throw LinNetError(response?.statusCode ?? -1, error.toString(),
          data: buildRes(response, request));
    }
    return buildRes(response,request);
  }

  ///构建LinNetResponse
  LinNetResponse buildRes(Response response, BaseRequest request) {
    return LinNetResponse<T>(
        data: response.data,
        request: request,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
        extra: response);
  }
  
}