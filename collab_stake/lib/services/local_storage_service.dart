import 'package:shared_preferences/shared_preferences.dart';
class LocalStorageService {
  static final LocalStorageService _instance = LocalStorageService._internal();

  factory LocalStorageService() {
    return _instance;
  }

  LocalStorageService._internal();

  SharedPreferences? _prefs;

  Future<SharedPreferences> get prefs async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  Future<void> setString(String key, String value) async {
    final prefs = await this.prefs;
    await prefs.setString(key, value);
  }

  Future<String?> getString(String key) async {
    final prefs = await this.prefs;
    return prefs.getString(key);
  }

  Future<bool?> remove(String key) async {
    final prefs = await this.prefs;
    return prefs.remove(key);
  }

  Future<bool?> clear() async{
    final prefs = await this.prefs;
    return prefs.clear();
  }

  Future<Set<String>> getKeys() async{
    final prefs = await this.prefs;
    return prefs.getKeys();

  }

}