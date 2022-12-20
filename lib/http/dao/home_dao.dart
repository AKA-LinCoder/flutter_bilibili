import '../../model/home_model.dart';
import '../core/lin_net.dart';
import '../request/home_request.dart';

/// FileName home_dao
///
/// @Author LinGuanYu
/// @Date 2022/12/20 09:58
///
/// @Description TODO

class HomeDao {
  // https://api.devio.org/uapi/fa/home/推荐?pageIndex=1&pageSize=10
  static Future<HomeModel> get(String categoryName,
      {int pageIndex = 1, int pageSize = 10}) async {
    HomeRequest request = HomeRequest();
    request.pathParams = categoryName;
    request.add('pageIndex', pageIndex).add('pageSize', pageSize);
    var result = await LinNet.getInstance().fire(request);
    return HomeModel.fromJson(result['data']);
  }
}
