///需要登陆
class NeedLogin extends LinNetError{
  NeedLogin({int code = 401,String message = '请先登陆'}):super(code,message,data: null);
}

///需要授权
class NeedAuth extends LinNetError{
  NeedAuth(String message,{int code = 403,dynamic data}):super(code,message,data: data);
}

///网络异常统一格式类
class LinNetError implements Exception{
  final int code;
  final String message;
  final dynamic data;
  LinNetError(this.code,this.message,{this.data});
}