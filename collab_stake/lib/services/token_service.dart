import 'package:collab_stake/services/local_storage_service.dart';

class TokenService {
  static final TokenService _instance = TokenService._internal();
  factory TokenService() => _instance;

  TokenService._internal();

  String? _token;

  Future<void> setToken(String? token) async {
    _token = token;
    final prefs =  LocalStorageService();
    await prefs.setString('token', token ?? '');
  }

  Future<String?> getToken() async {
    if (_token != null) {
      return _token;
    } else {
      final prefs =  LocalStorageService();
      _token = await prefs.getString('token');
      return _token;
    }
  }

  Future<void> clearToken() async {
    final prefs = LocalStorageService();
    await prefs.remove('token');
    _token = null;
  }
}
