import 'package:shared_preferences/shared_preferences.dart';

abstract class SharePreferenceService {
  late final SharedPreferences prefs;
  Future<bool> setData(String key, List<String> data);
  Future<List<String>> getData(String key);
  Future init();
}

class SharedPreferenceImpl extends SharePreferenceService {
  @override
  Future<bool> setData(String key, List<String> data) async {
    return await prefs.setStringList(key, data);
  }

  @override
  Future<List<String>> getData(String key) async {
    return prefs.getStringList(key) ?? [];
  }

  @override
  Future init() async {
    prefs = await SharedPreferences.getInstance();
  }
}
