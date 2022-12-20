
import 'package:flutter_bilibili/http/request/profile_request.dart';
import 'package:flutter_bilibili/model/profile_model.dart';

import '../core/lin_net.dart';

class ProfileDao {
  //https://api.devio.org/uapi/fa/profile
  static get() async {
    ProfileRequest request = ProfileRequest();
    var result = await LinNet.getInstance().fire(request);
    return ProfileModel.fromJson(result['data']);
  }
}
