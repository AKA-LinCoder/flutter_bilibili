
import 'package:flutter_bilibili/http/request/notice_request.dart';
import 'package:flutter_bilibili/model/notice_model.dart';

import '../core/lin_net.dart';

/// 通知列表
class NoticeDao {
  // https://api.devio.org/uapi/fa/notice?pageIndex=1&pageSize=10
  static noticeList({int pageIndex = 1, int pageSize = 10}) async {
    NoticeRequest request = NoticeRequest();
    request.add('pageIndex', pageIndex).add('pageSize', pageSize);
    var result = await LinNet.getInstance().fire(request);
    return NoticeModel.fromJson(result['data']);
  }
}
