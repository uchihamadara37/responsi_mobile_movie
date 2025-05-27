import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  static const String _userIdKey = 'userId'; // Menyimpan ID user dari API
  static const String _usernameKey = 'username'; // Opsional, untuk tampilan cepat

  // Simpan ID user (dari API)
  static Future<void> saveUserId(int userId) async { // Ubah ke String jika ID API adalah String
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_userIdKey, userId);
  }

  // Dapatkan ID user
  static Future<int?> getUserId() async { // Ubah ke String jika ID API adalah String
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_userIdKey);
  }

  // Simpan username (opsional)
  static Future<void> saveUsername(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_usernameKey, username);
  }

  // Dapatkan username (opsional)
  static Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_usernameKey);
  }


  static Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userIdKey);
    await prefs.remove(_usernameKey);
    // Hapus item lain jika ada
  }
}