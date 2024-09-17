import 'package:shared_preferences/shared_preferences.dart';

class CacheKey {
  static const String token = 'token';
  static const String userId = 'userId';
  static const String userRole = 'userRole';
}

class AppCache {
  final SharedPreferences sharedPreferences;

  AppCache._({required this.sharedPreferences});

  factory AppCache.create({
    required SharedPreferences sharedPreferences,
  }) =>
      AppCache._(
        sharedPreferences: sharedPreferences,
      );

  //  singleton
  static AppCache? _instance;

  //  初始函式，如果有實例就不新增
  static Future<void> init() async {
    _instance ??= AppCache.create(
      sharedPreferences: await SharedPreferences.getInstance(),
    );
  }

  static SharedPreferences get _pre => _instance!.sharedPreferences;

  static Future<bool> setToken(String token) async {
    return await _pre.setString(CacheKey.token, token);
  }

  static Future<bool> cleanToken() async {
    return await _pre.setString(CacheKey.token, '');
  }

  static String? get token => _pre.getString(CacheKey.token);

  static Future<bool> setUserId(int id) async {
    return await _pre.setInt(CacheKey.userId, id);
  }

  static int? get userId => _pre.getInt(CacheKey.userId);

  static Future<bool> setUserRole(String role) async {
    return await _pre.setString(CacheKey.userRole, role);
  }

  static String? get userRole => _pre.getString(CacheKey.userRole);
}
