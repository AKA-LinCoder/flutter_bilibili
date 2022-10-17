
import '../../db/lin_cache.dart';
import '../core/lin_net.dart';
import '../request/base_request.dart';
import '../request/login_request.dart';
import '../request/registeration_request.dart';

///dao数据访问对象，主要用于数据交互
class LoginDao{

  static const TOKEN = "token";

  static login(String username,String password){
    return _send(username,password);
  }

  static registration(String username,String password,String imoocId,String orderId){
    return _send(username,password,imoocId: imoocId,orderId: orderId);
  }


  static _send(String username,String password,{String? imoocId,String? orderId})async{
    BaseRequest request;
    if(imoocId!=null&&orderId!=null){
      request = RegistrationRequest();
    }else{
      request = LoginRequest();
    }
    request.add("account", username)
        .add("password", password);
    var res = await LinNet.getInstance().fire(request);
    print('这是返回$res');
    if(res['code']==200&&res['data']!=null){
      LinCache.getInstance().setString(TOKEN, res['data']['token']);
    }else{

    }
    return res;
  }

  static getToken(){
    return LinCache.getInstance().get(TOKEN);
  }

}
