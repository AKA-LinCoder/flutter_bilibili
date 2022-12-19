

import 'base_request.dart';

class LoginRequest extends BaseRequest{
  // @override
  // HttpMethod httpMethod() {
  //   // TODO: implement httpMethod
  //   return HttpMethod.POST;
  // }
  //
  // @override
  // // TODO: implement useHttps
  // bool get useHttps => true;
  //
  // @override
  // bool needLogin() {
  //   // TODO: implement needLogin
  //   return false;
  // }
  //
  // @override
  // String path() {
  //   // TODO: implement path
  //   return "author/login";
  // }

  @override
  HttpMethod httpMethod() {
    return HttpMethod.POST;
  }

  @override
  bool needLogin() {
    return false;
  }

  @override
  String path() {
    return '/uapi/user/login';
  }


}