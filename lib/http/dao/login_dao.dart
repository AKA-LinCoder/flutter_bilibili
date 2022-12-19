
import '../../db/lin_cache.dart';
import '../core/lin_net.dart';
import '../request/base_request.dart';
import '../request/login_request.dart';
import '../request/registeration_request.dart';

///dao数据访问对象，主要用于数据交互
class LoginDao {
  /// 登录令牌
  static const BOARDING_PASS = 'boarding-pass';

  /// 登录
  static login(String userName, String password) {
    return _send(userName, password);
  }

  /// 注册
  static registration(
      String userName, String password, String imoocId, String orderId) {
    return _send(userName, password, imoocId: imoocId, orderId: orderId);
  }

  /// 发送
  static _send(String userName, String password,
      {String? imoocId, String? orderId}) async {
    BaseRequest request;
    if (imoocId != null && orderId != null) {
      request = RegistrationRequest();
      request.add('imoocId', imoocId).add('orderId', orderId);
    } else {
      request = LoginRequest();
    }
    request.add('userName', userName).add('password', password);

    var result = await LinNet.getInstance().fire(request);
    if (result['code'] == 0 && result['data'] != null) {
      // 保存登录令牌
      LinCache.getInstance().setString(BOARDING_PASS, result['data']);
    }
    return result;
  }

  /// 获取登录令牌
  static String? getBoardingPass() {
    print("获取到的本地数据${LinCache.getInstance().get(BOARDING_PASS)}");
    return LinCache.getInstance().get(BOARDING_PASS);
  }
}
// class LoginDao{
//
//   static const TOKEN = "token";
//
//   static login(String username,String password){
//     return _send(username,password);
//   }
//
//   static registration(String username,String password,String imoocId,String orderId){
//     return _send(username,password,imoocId: imoocId,orderId: orderId);
//   }
//
//
//   static _send(String username,String password,{String? imoocId,String? orderId})async{
//     BaseRequest request;
//     if(imoocId!=null&&orderId!=null){
//       request = RegistrationRequest();
//     }else{
//       request = LoginRequest();
//     }
//     request.add("account", username)
//         .add("password", password)
//         .add("imoocId", imoocId).add("orderId", orderId);
//     var res = await LinNet.getInstance().fire(request);
//     print('这是返回$res');
//     if(res['code']==200&&res['data']!=null){
//       LinCache.getInstance().setString(TOKEN, res['data']['token']);
//     }else{
//
//     }
//     return res;
//   }
//
//   static getToken(){
//     return LinCache.getInstance().get(TOKEN);
//   }
//
// }
