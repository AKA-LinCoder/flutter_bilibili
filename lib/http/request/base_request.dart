enum HttpMethod {GET,POST,DELETE}
///基础请求
abstract class BaseRequest{
  ///path参数
  var pathParams;
  var useHttps = false;
  ///域名
  String authority(){
    return "api.devio.org";
  }
  ///请求方式
  HttpMethod httpMethod();
  ///后缀
  String path();
  ///生成具体URL
  String url(){
    Uri uri;
    var pathStr = path();
    //拼接path参数
    if(pathParams!=null){
      if(path().endsWith("/")){
        pathStr = "${path()}$pathParams";
      }else{
        pathStr = "${path()}/$pathParams";
      }
    }
    //http和https的切换
    if(useHttps){
      uri = Uri.https(authority(), pathStr,params);
    }else{
      uri = Uri.http(authority(), pathStr,params);
    }
    return uri.toString();
  }

  bool needLogin();
  Map<String,String>params = {};

  ///添加参数
  BaseRequest add(String k ,Object v){
    params[k] = v.toString();
    return this;
  }
  Map<String,dynamic>header = {};
  ///添加header
  BaseRequest addHeader(String k ,Object v){
    params[k] = v.toString();
    return this;
  }

}