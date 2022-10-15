import '../request/base_request.dart';
import 'lin_adapter.dart';

///测试适配器，mock数据

class MockAdapter extends LinNetAdapter{

  @override
  // Future<LinResponse<T>> send<T>(BaseRequest request) {
  //   // TODO: implement send
  //
  //   // return LinResponse(data: {'code':0,"message":'success'},statusCode: 200);
  //   // return Future<LinResponse>.delayed(Duration(milliseconds: 1000),(){
  //   //   return LinResponse(data: {'code':0,"message":'success'},statusCode: 200);
  //   // });
  //
  // }

  // Future<LinResponse<dynamic>> send<T>(BaseRequest request) {
  //   return Future<LinResponse<dynamic>>.delayed(const Duration(milliseconds: 1000), () {
  //     return LinResponse(
  //         data: {"code":0, "message": 'success'}, statusCode: 403);
  //   });
  // }
  Future<LinNetResponse<T>> send<T>(BaseRequest request) {
    return Future<LinNetResponse<T>>.delayed(const Duration(milliseconds: 1000), () {
      return LinNetResponse(
          data: {"code":0, "message": 'success'}, statusCode: 200);
    });
  }

}