import 'package:shared_preferences/shared_preferences.dart';

///缓存管理类
class LinCache{
  SharedPreferences? prefs;
  LinCache._(){
    init();
  }
  static LinCache? _instance;


  LinCache._pre(SharedPreferences pre){
    prefs = pre;
  }

  static Future<LinCache> preInit() async{
    if(_instance==null){
      var  prefs = await SharedPreferences.getInstance();
      _instance = LinCache._pre(prefs);
    }
    return _instance!;
  }

  static LinCache getInstance(){
    _instance ??= LinCache._();
    return _instance!;
  }

  void init() async{
    prefs ??= await SharedPreferences.getInstance();
  }


  setString(String key,String value){
    prefs?.setString(key, value);
  }

  setDouble(String key,double value){
    prefs?.setDouble(key, value);
  }

  setInt(String key,int value){
    prefs?.setInt(key, value);
  }

  setBool(String key,bool value){
    prefs?.setBool(key, value);
  }

  setStringList(String key,List<String> value){
    prefs?.setStringList(key, value);
  }

  dynamic get<T>(String key){
    return prefs?.get(key);
  }


}