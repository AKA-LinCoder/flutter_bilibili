/// FileName test_model
///
/// @Author LinGuanYu
/// @Date 2022/12/19 15:03
///
/// @Description TODO

import 'dart:convert';

// GroupSelect groupSelectFromJson(String? str) => GroupSelect.fromJson(json.decode(str));
//
// String? groupSelectToJson(GroupSelect data) => json.encode(data.toJson());

class GroupSelect {
  GroupSelect({
    this.totalCount,
    this.recommendlist,
    this.selectTagsList,
    this.brandList,
  });

  int? totalCount;
  List<Recommendlist>? recommendlist;
  List<SelectTagsList>? selectTagsList;
  BrandList? brandList;

  factory GroupSelect.fromJson(Map<String?, dynamic> json) => GroupSelect(
    totalCount: json["total_count"],
    recommendlist: List<Recommendlist>.from(json["recommendlist"].map((x) => Recommendlist.fromJson(x))),
    selectTagsList: List<SelectTagsList>.from(json["select_tags_list"].map((x) => SelectTagsList.fromJson(x))),
    brandList: BrandList.fromJson(json["brand_list"]),
  );

  Map<String?, dynamic> toJson() => {
    "total_count": totalCount,
    "recommendlist": recommendlist == null
        ? []
        : List<dynamic>.from(recommendlist!.map((x) => x)),
    "select_tags_list": selectTagsList == null
        ? []
        : List<dynamic>.from(selectTagsList!.map((x) => x)),
    "brand_list": brandList?.toJson(),
  };
}

class BrandList {
  BrandList({
    this.totalCount,
    this.bannerList,
  });

  int? totalCount;
  List<BannerList>? bannerList;

  factory BrandList.fromJson(Map<String?, dynamic> json) => BrandList(
    totalCount: json["total_count"],
    bannerList: List<BannerList>.from(json["banner_list"].map((x) => BannerList.fromJson(x))),
  );

  Map<String?, dynamic> toJson() => {
    "total_count": totalCount,
    "banner_list": bannerList == null
        ? []
        : List<dynamic>.from(bannerList!.map((x) => x)),
  };
}

class BannerList {
  BannerList({
    this.attributeId,
    this.companyId,
    this.shopId,
    this.attributeType,
    this.attributeName,
    this.attributeMemo,
    this.attributeSort,
    this.distributorId,
    this.isShow,
    this.isImage,
    this.imageUrl,
    this.created,
    this.updated,
    this.attributeCode,
  });

  String? attributeId;
  String? companyId;
  String? shopId;
  String? attributeType;
  String? attributeName;
  String? attributeMemo;
  String? attributeSort;
  String? distributorId;
  String? isShow;
  String? isImage;
  String? imageUrl;
  int? created;
  int? updated;
  dynamic attributeCode;

  factory BannerList.fromJson(Map<String?, dynamic> json) => BannerList(
    attributeId: json["attribute_id"],
    companyId: json["company_id"],
    shopId: json["shop_id"],
    attributeType: json["attribute_type"],
    attributeName: json["attribute_name"],
    attributeMemo: json["attribute_memo"],
    attributeSort: json["attribute_sort"],
    distributorId: json["distributor_id"],
    isShow: json["is_show"],
    isImage: json["is_image"],
    imageUrl: json["image_url"],
    created: json["created"],
    updated: json["updated"],
    attributeCode: json["attribute_code"],
  );

  Map<String?, dynamic> toJson() => {
    "attribute_id": attributeId,
    "company_id": companyId,
    "shop_id": shopId,
    "attribute_type": attributeType,
    "attribute_name": attributeName,
    "attribute_memo": attributeMemo,
    "attribute_sort": attributeSort,
    "distributor_id": distributorId,
    "is_show": isShow,
    "is_image": isImage,
    "image_url": imageUrl,
    "created": created,
    "updated": updated,
    "attribute_code": attributeCode,
  };
}

class Recommendlist {
  Recommendlist({
    this.recommendlistItemId,
    this.itemType,
    this.recommendlistConsumeType,
    this.isShowSpecimg,
    this.store,
    this.barcode,
    this.sales,
    this.approveStatus,
    this.rebate,
    this.rebateConf,
    this.costPrice,
    this.isPoint,
    this.point,
    this.itemSource,
    this.goodsId,
    this.brandId,
    this.recommendlistItemName,
    this.itemUnit,
    this.recommendlistItemBn,
    this.brief,
    this.price,
    this.marketPrice,
    this.specialType,
    this.goodsFunction,
    this.goodsSeries,
    this.volume,
    this.goodsColor,
    this.goodsBrand,
    this.itemAddressProvince,
    this.itemAddressCity,
    this.regionsId,
    this.brandLogo,
    this.sort,
    this.templatesId,
    this.isDefault,
    this.nospec,
    this.defaultItemId,
    this.pics,
    this.distributorId,
    this.recommendlistCompanyId,
    this.enableAgreement,
    this.dateType,
    this.itemCategory,
    this.rebateType,
    this.weight,
    this.beginDate,
    this.endDate,
    this.fixedTerm,
    this.taxRate,
    this.created,
    this.updated,
    this.videoType,
    this.videos,
    this.videoPicUrl,
    this.auditStatus,
    this.auditReason,
    this.isGift,
    this.isPackage,
    this.profitType,
    this.profitFee,
    this.isProfit,
    this.crossborderTaxRate,
    this.origincountryId,
    this.taxstrategyId,
    this.taxationNum,
    this.type,
    this.itemEnName,
    this.isPackageItems,
    this.tdkContent,
    this.itemId,
    this.consumeType,
    this.itemName,
    this.itemBn,
    this.companyId,
    this.itemMainCatId,
  });

  String? recommendlistItemId;
  String? itemType;
  String? recommendlistConsumeType;
  bool? isShowSpecimg;
  int? store;
  String? barcode;
  int? sales;
  String? approveStatus;
  int? rebate;
  List<dynamic>? rebateConf;
  int? costPrice;
  dynamic isPoint;
  int? point;
  String? itemSource;
  String? goodsId;
  int? brandId;
  String? recommendlistItemName;
  String? itemUnit;
  String? recommendlistItemBn;
  String? brief;
  int? price;
  int? marketPrice;
  String? specialType;
  dynamic goodsFunction;
  dynamic goodsSeries;
  dynamic volume;
  dynamic goodsColor;
  dynamic goodsBrand;
  String? itemAddressProvince;
  String? itemAddressCity;
  String? regionsId;
  dynamic brandLogo;
  int? sort;
  int? templatesId;
  bool? isDefault;
  bool? nospec;
  String? defaultItemId;
  List<String>? pics;
  int? distributorId;
  String? recommendlistCompanyId;
  bool? enableAgreement;
  String? dateType;
  String? itemCategory;
  String? rebateType;
  int? weight;
  int? beginDate;
  int? endDate;
  int? fixedTerm;
  int? taxRate;
  int? created;
  int? updated;
  String? videoType;
  String? videos;
  dynamic videoPicUrl;
  String? auditStatus;
  dynamic auditReason;
  bool? isGift;
  bool? isPackage;
  int? profitType;
  int? profitFee;
  bool? isProfit;
  String? crossborderTaxRate;
  String? origincountryId;
  String? taxstrategyId;
  int? taxationNum;
  int? type;
  String? itemEnName;
  bool? isPackageItems;
  String? tdkContent;
  String? itemId;
  String? consumeType;
  String? itemName;
  String? itemBn;
  String? companyId;
  String? itemMainCatId;

  factory Recommendlist.fromJson(Map<String?, dynamic> json) => Recommendlist(
    recommendlistItemId: json["item_id"],
    itemType: json["item_type"],
    recommendlistConsumeType: json["consume_type"],
    isShowSpecimg: json["is_show_specimg"],
    store: json["store"],
    barcode: json["barcode"],
    sales: json["sales"],
    approveStatus: json["approve_status"],
    rebate: json["rebate"],
    rebateConf: List<dynamic>.from(json["rebate_conf"].map((x) => x)),
    costPrice: json["cost_price"],
    isPoint: json["is_point"],
    point: json["point"],
    itemSource: json["item_source"],
    goodsId: json["goods_id"],
    brandId: json["brand_id"],
    recommendlistItemName: json["item_name"],
    itemUnit: json["item_unit"],
    recommendlistItemBn: json["item_bn"],
    brief: json["brief"],
    price: json["price"],
    marketPrice: json["market_price"],
    specialType: json["special_type"],
    goodsFunction: json["goods_function"],
    goodsSeries: json["goods_series"],
    volume: json["volume"],
    goodsColor: json["goods_color"],
    goodsBrand: json["goods_brand"],
    itemAddressProvince: json["item_address_province"],
    itemAddressCity: json["item_address_city"],
    regionsId: json["regions_id"],
    brandLogo: json["brand_logo"],
    sort: json["sort"],
    templatesId: json["templates_id"],
    isDefault: json["is_default"],
    nospec: json["nospec"],
    defaultItemId: json["default_item_id"],
    pics: List<String>.from(json["pics"].map((x) => x)),
    distributorId: json["distributor_id"],
    recommendlistCompanyId: json["company_id"],
    enableAgreement: json["enable_agreement"],
    dateType: json["date_type"],
    itemCategory: json["item_category"],
    rebateType: json["rebate_type"],
    weight: json["weight"],
    beginDate: json["begin_date"],
    endDate: json["end_date"],
    fixedTerm: json["fixed_term"],
    taxRate: json["tax_rate"],
    created: json["created"],
    updated: json["updated"],
    videoType: json["video_type"],
    videos: json["videos"],
    videoPicUrl: json["video_pic_url"],
    auditStatus: json["audit_status"],
    auditReason: json["audit_reason"],
    isGift: json["is_gift"],
    isPackage: json["is_package"],
    profitType: json["profit_type"],
    profitFee: json["profit_fee"],
    isProfit: json["is_profit"],
    crossborderTaxRate: json["crossborder_tax_rate"],
    origincountryId: json["origincountry_id"],
    taxstrategyId: json["taxstrategy_id"],
    taxationNum: json["taxation_num"],
    type: json["type"],
    itemEnName: json["item_en_name"],
    isPackageItems: json["is_package_items"],
    tdkContent: json["tdk_content"],
    itemId: json["itemId"],
    consumeType: json["consumeType"],
    itemName: json["itemName"],
    itemBn: json["itemBn"],
    companyId: json["companyId"],
    itemMainCatId: json["item_main_cat_id"],
  );

  Map<String?, dynamic> toJson() => {
    "item_id": recommendlistItemId,
    "item_type": itemType,
    "consume_type": recommendlistConsumeType,
    "is_show_specimg": isShowSpecimg,
    "store": store,
    "barcode": barcode,
    "sales": sales,
    "approve_status": approveStatus,
    "rebate": rebate,
    "cost_price": costPrice,
    "is_point": isPoint,
    "point": point,
    "item_source": itemSource,
    "goods_id": goodsId,
    "brand_id": brandId,
    "item_name": recommendlistItemName,
    "item_unit": itemUnit,
    "item_bn": recommendlistItemBn,
    "brief": brief,
    "price": price,
    "market_price": marketPrice,
    "special_type": specialType,
    "goods_function": goodsFunction,
    "goods_series": goodsSeries,
    "volume": volume,
    "goods_color": goodsColor,
    "goods_brand": goodsBrand,
    "item_address_province": itemAddressProvince,
    "item_address_city": itemAddressCity,
    "regions_id": regionsId,
    "brand_logo": brandLogo,
    "sort": sort,
    "templates_id": templatesId,
    "is_default": isDefault,
    "nospec": nospec,
    "default_item_id": defaultItemId,
    "distributor_id": distributorId,
    "company_id": recommendlistCompanyId,
    "enable_agreement": enableAgreement,
    "date_type": dateType,
    "item_category": itemCategory,
    "rebate_type": rebateType,
    "weight": weight,
    "begin_date": beginDate,
    "end_date": endDate,
    "fixed_term": fixedTerm,
    "tax_rate": taxRate,
    "created": created,
    "updated": updated,
    "video_type": videoType,
    "videos": videos,
    "video_pic_url": videoPicUrl,
    "audit_status": auditStatus,
    "audit_reason": auditReason,
    "is_gift": isGift,
    "is_package": isPackage,
    "profit_type": profitType,
    "profit_fee": profitFee,
    "is_profit": isProfit,
    "crossborder_tax_rate": crossborderTaxRate,
    "origincountry_id": origincountryId,
    "taxstrategy_id": taxstrategyId,
    "taxation_num": taxationNum,
    "type": type,
    "item_en_name": itemEnName,
    "is_package_items": isPackageItems,
    "tdk_content": tdkContent,
    "itemId": itemId,
    "consumeType": consumeType,
    "itemName": itemName,
    "itemBn": itemBn,
    "companyId": companyId,
    "item_main_cat_id": itemMainCatId,
  };
}

class SelectTagsList {
  SelectTagsList({
    this.tagId,
    this.companyId,
    this.distributorId,
    this.tagName,
    this.tagColor,
    this.fontColor,
    this.description,
    this.tagIcon,
    this.frontShow,
    this.created,
    this.updated,
  });

  String? tagId;
  String? companyId;
  String? distributorId;
  String? tagName;
  String? tagColor;
  String? fontColor;
  String? description;
  dynamic tagIcon;
  int? frontShow;
  int? created;
  int? updated;

  factory SelectTagsList.fromJson(Map<String?, dynamic> json) => SelectTagsList(
    tagId: json["tag_id"],
    companyId: json["company_id"],
    distributorId: json["distributor_id"],
    tagName: json["tag_name"],
    tagColor: json["tag_color"],
    fontColor: json["font_color"],
    description: json["description"],
    tagIcon: json["tag_icon"],
    frontShow: json["front_show"],
    created: json["created"],
    updated: json["updated"],
  );

  Map<String?, dynamic> toJson() => {
    "tag_id": tagId,
    "company_id": companyId,
    "distributor_id": distributorId,
    "tag_name": tagName,
    "tag_color": tagColor,
    "font_color": fontColor,
    "description": description,
    "tag_icon": tagIcon,
    "front_show": frontShow,
    "created": created,
    "updated": updated,
  };
}
