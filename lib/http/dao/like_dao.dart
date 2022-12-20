
import 'package:flutter_bilibili/http/request/base_request.dart';
import 'package:flutter_bilibili/http/request/cancel_like_request.dart';
import 'package:flutter_bilibili/http/request/like_request.dart';

import '../core/lin_net.dart';

class LikeDao {
  static like(String vid, bool like) async {
    BaseRequest request = like ? LikeRequest() : CancelLikeRequest();
    request.pathParams = vid;
    var result = await LinNet.getInstance().fire(request);
    return result;
  }
}
