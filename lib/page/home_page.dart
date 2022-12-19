import 'package:flutter/material.dart';
import 'package:flutter_bilibili/model/test_model.dart';
import 'package:flutter_bilibili/navigator/lin_navigator.dart';
/// FileName home_page
///
/// @Author LinGuanYu
/// @Date 2022/12/19 14:23
///
/// @Description TODO
///

class HomePage extends StatefulWidget {
  final ValueChanged<int>? onJumpTo;
  const HomePage({Key? key, this.onJumpTo}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var testModel = {
    "total_count": 268,
    "recommendlist": [
      {
        "item_id": "26",
        "item_type": "normal",
        "consume_type": "every",
        "is_show_specimg": false,
        "store": 10003,
        "barcode": "",
        "sales": 3,
        "approve_status": "onsale",
        "rebate": 0,
        "rebate_conf": [],
        "cost_price": 0,
        "is_point": null,
        "point": 0,
        "item_source": "mall",
        "goods_id": "26",
        "brand_id": 1,
        "item_name": "测试商品",
        "item_unit": "",
        "item_bn": "S606DA26486183",
        "brief": "",
        "price": 100,
        "market_price": 0,
        "special_type": "normal",
        "goods_function": null,
        "goods_series": null,
        "volume": null,
        "goods_color": null,
        "goods_brand": null,
        "item_address_province": "",
        "item_address_city": "",
        "regions_id": "110000,110100,110101",
        "brand_logo": null,
        "sort": 0,
        "templates_id": 2,
        "is_default": true,
        "nospec": false,
        "default_item_id": "26",
        "pics": [
          "https://robotime-espier-vue.oss-cn-shanghai.aliyuncs.com/image/3/2021/04/07/e15a2f99e6f875bd27bef406a0c14a51D3jsMqq1sqOVE8rbtyBrJFjp8SXc6i2B",
          "https://robotime-espier-vue.oss-cn-shanghai.aliyuncs.com/image/3/2021/04/07/d44e873ced60e66de97110d65814261c1FEN14GoJcrkXhaJb48RzVqpY9IA7BCv"
        ],
        "distributor_id": 0,
        "company_id": "3",
        "enable_agreement": false,
        "date_type": "",
        "item_category": "7",
        "rebate_type": "default",
        "weight": 0,
        "begin_date": 0,
        "end_date": 0,
        "fixed_term": 0,
        "tax_rate": 0,
        "created": 1617797732,
        "updated": 1653377463,
        "video_type": "local",
        "videos": "",
        "video_pic_url": null,
        "audit_status": "approved",
        "audit_reason": null,
        "is_gift": false,
        "is_package": false,
        "profit_type": 0,
        "profit_fee": 0,
        "is_profit": false,
        "crossborder_tax_rate": "",
        "origincountry_id": "0",
        "taxstrategy_id": "0",
        "taxation_num": 1,
        "type": 0,
        "item_en_name": "",
        "is_package_items": false,
        "tdk_content": "{\"title\":\"\",\"mate_description\":\"\",\"mate_keywords\":\"\"}",
        "itemId": "26",
        "consumeType": "every",
        "itemName": "测试商品",
        "itemBn": "S606DA26486183",
        "companyId": "3",
        "item_main_cat_id": "7",
        "distributor_info": []
      }
    ],
    "select_tags_list": [
      {
        "tag_id": "6",
        "company_id": "3",
        "distributor_id": "0",
        "tag_name": "可爱潮玩盲盒，治愈你的不开心",
        "tag_color": "#ff1939",
        "font_color": "rgba(255, 69, 0, 1)",
        "description": "治愈你的不开心",
        "tag_icon": null,
        "front_show": 1,
        "created": 1618302376,
        "updated": 1635917729
      }
    ],
    "brand_list": {
      "total_count": 4,
      "banner_list": [
        {
          "attribute_id": "1",
          "company_id": "3",
          "shop_id": "0",
          "attribute_type": "brand",
          "attribute_name": "若来rolife",
          "attribute_memo": "",
          "attribute_sort": "1",
          "distributor_id": "0",
          "is_show": "true",
          "is_image": "true",
          "image_url": "http://mmbiz.qpic.cn/mmbiz_jpg/fPdEK0eoFbC3ymKNl6GIR48V4GtaibIuYdqvHz6zoCThiaT6oDiaVhZZUhffmibINLSic1stqA9cDFDMH3oViaTNM9Iw/0?wx_fmt=jpeg",
          "created": 1615274036,
          "updated": 1615274100,
          "attribute_code": null
        }
      ]
    }
  };


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LinNavigator.getInstance().addListener((current, pre){
      print("current:${current.page}");
      print("pre:${pre?.page}");
      if(widget == current.page||current.page is HomePage){
        print("当前页面被打开 onResume");
      }else if(widget == pre?.page||pre?.page is HomePage){
        print("首页 onPause");
      }

    });
  }

  @override
  void dispose() {
    // LinNavigator.getInstance().removeListener((this.)
    // TODO: implement dispose
    super.dispose();

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          ElevatedButton(onPressed: (){
            try{
              GroupSelect group = GroupSelect.fromJson(testModel);
              print("没问题");
              print(group.brandList?.bannerList?.length);
            }catch (e){
              print(e.toString());
            }



          }, child: Text("转化"))
        ],
      ),
    );
  }
}
