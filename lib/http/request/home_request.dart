import 'base_request.dart';

/// FileName home_request
///
/// @Author LinGuanYu
/// @Date 2022/12/20 09:59
///
/// @Description TODO

class HomeRequest extends BaseRequest {
  @override
  HttpMethod httpMethod() {
    return HttpMethod.GET;
  }

  @override
  bool needLogin() {
    return true;
  }

  @override
  String path() {
    return "uapi/fa/home/";
  }
}
