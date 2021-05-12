import 'package:shared_preferences/shared_preferences.dart';

class HiCache {
  HiCache._() {
    init();
  }

  SharedPreferences? preferences;
  static HiCache? _instance;

  HiCache._pre(SharedPreferences prefs) {
    this.preferences = prefs;
  }

  //预初始化
  static Future<HiCache> preInit() async {
    if (_instance == null) {
      var prefs = await SharedPreferences.getInstance();
      _instance = HiCache._pre(prefs);
    }
    return _instance!;
  }

  static HiCache get getHicache => _instance ??= HiCache._();

  void init() async {
    preferences ??= await SharedPreferences.getInstance();
  }

  setString(String key, String value) {
    preferences?.setString(key, value);
  }

  setDouble(String key, double value) {
    preferences?.setDouble(key, value);
  }

  setInt(String key, int value) {
    preferences?.setInt(key, value);
  }

  setBool(String key, bool value) {
    preferences?.setBool(key, value);
  }

  setStringlit(String key, List<String> value) {
    preferences?.setStringList(key, value);
  }

  dynamic get<T>(String key) {
    return preferences?.get(key);
  }
}
