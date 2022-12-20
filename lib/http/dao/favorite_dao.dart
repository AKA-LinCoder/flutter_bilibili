
import 'package:flutter_bilibili/http/request/base_request.dart';
import 'package:flutter_bilibili/http/request/cancel_favorite_request.dart';
import 'package:flutter_bilibili/http/request/favorite_list_request.dart';
import 'package:flutter_bilibili/http/request/favorite_request.dart';
import 'package:flutter_bilibili/model/ranking_model.dart';

import '../core/lin_net.dart';

class FavoriteDao {
  static favorite(String vid, bool favorite) async {
    BaseRequest request =
    favorite ? FavoriteRequest() : CancelFavoriteRequest();
    request.pathParams = vid;
    var result = await LinNet.getInstance().fire(request);
    return result;
  }

  static favoriteList({int pageIndex = 1, int pageSize = 10}) async {
    FavoriteListRequest request = FavoriteListRequest();
    request.add('pageIndex', pageIndex)
        .add('pageSize', pageSize);
    var result = await LinNet.getInstance().fire(request);
    return RankingModel.fromJson(result['data']);
  }
}
