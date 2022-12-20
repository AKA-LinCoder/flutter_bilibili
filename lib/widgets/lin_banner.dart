import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';

import '../model/home_model.dart';
import '../navigator/lin_navigator.dart';

/// FileName lin_banner
///
/// @Author LinGuanYu
/// @Date 2022/12/20 10:49
///
/// @Description TODO 轮播图

/// 轮播图
class LinBanner extends StatelessWidget {
  final List<BannerModel> bannerList;
  final double bannerHeight;
  final EdgeInsetsGeometry? padding;

  const LinBanner(this.bannerList,
      {Key? key, this.bannerHeight = 160, this.padding})
      : super(key: key);

  /// banner 点击跳转
  void handleBannerClick(BannerModel banner) {
    if (banner.type == 'video') {
      print(banner.toString());
      LinNavigator.getInstance().onJumpTo(RouteStatus.detail,
          args: {'videoInfo': VideoModel(vid: banner.url)});
    } else {
      LinNavigator.getInstance().openH5(banner.url);
    }
  }

  /// banner 图片
  Widget _image(BannerModel banner) {
    return InkWell(
      onTap: () {
        print(banner.title);
        handleBannerClick(banner);
      },
      child: Container(
        padding: padding,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          child: Image.network(
            banner.cover ?? '',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _banner() {
    double right = 10 + (padding?.horizontal ?? 0) / 2;
    return Swiper(
      itemCount: bannerList.length,
      autoplay: true,
      itemBuilder: (BuildContext context, int index) =>
          _image(bannerList[index]),
      pagination: SwiperPagination(
        alignment: Alignment.bottomRight,
        margin: EdgeInsets.only(right: right, bottom: 10),
        builder: const DotSwiperPaginationBuilder(
            color: Colors.white60, size: 6, activeSize: 6),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: bannerHeight,
      child: _banner(),
    );
  }
}
