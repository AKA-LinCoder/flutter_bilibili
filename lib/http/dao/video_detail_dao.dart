
import 'package:flutter_bilibili/http/request/video_detail_request.dart';
import 'package:flutter_bilibili/model/video_detail_model.dart';

import '../core/lin_net.dart';

/// 视频详情页
class VideoDetailDao {
  // https://api.devio.org/uapi/fa/detail/BV19C4y1s7Ka
  static get(String vid) async {
    VideoDetailRequest request = VideoDetailRequest();
    request.pathParams = vid;
    var result = await LinNet.getInstance().fire(request);
    return VideoDetailModel.fromJson(result['data']);
  }
}
