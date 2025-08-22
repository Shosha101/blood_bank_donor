import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SharedPrefKeys {
  static const String userToken = 'user_token';
  static const String userId = 'userId';
  static const String phoneNumber = 'phoneNumber';
  static const String authCookie = 'authCookie';
  static const String selectedIndex = 'selectedIndex';
  static const String currentRoute = 'currentRoute';
}

class SharedPrefHelper {
  static final FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  static Future<SharedPreferences> _getPrefs() async => await SharedPreferences.getInstance();

  static Future<void> setSecuredString(String key, String value) async {
    try {
      if (key.isEmpty) {
        print('Error: Attempted to set secure string with empty key. Stack trace: ${StackTrace.current}');
        return;
      }
      if (kIsWeb) {
        final prefs = await _getPrefs();
        await prefs.setString(key, value);
        print('Stored in SharedPreferences: key=$key, value=$value');
      } else {
        await _secureStorage.write(key: key, value: value);
        print('Stored in secure storage: key=$key, value=$value');
      }
    } catch (e) {
      print('Error saving to storage: $e');
      rethrow;
    }
  }

  static Future<String?> getSecuredString(String key) async {
    try {
      if (key.isEmpty) {
        print('Error: Attempted to get secure string with empty key. Stack trace: ${StackTrace.current}');
        return null;
      }
      if (kIsWeb) {
        final prefs = await _getPrefs();
        final value = prefs.getString(key);
        print('Retrieved from SharedPreferences: key=$key, value=$value');
        return value;
      } else {
        final value = await _secureStorage.read(key: key);
        print('Retrieved from secure storage: key=$key, value=$value');
        return value;
      }
    } catch (e) {
      print('Error reading from storage: $e');
      return null;
    }
  }

  static Future<void> setSecuredInt(String key, int value) async {
    try {
      if (key.isEmpty) {
        print('Error: Attempted to set secure int with empty key. Stack trace: ${StackTrace.current}');
        return;
      }
      if (kIsWeb) {
        final prefs = await _getPrefs();
        await prefs.setInt(key, value);
        print('Stored in SharedPreferences: key=$key, value=$value');
      } else {
        await _secureStorage.write(key: key, value: value.toString());
        print('Stored in secure storage: key=$key, value=$value');
      }
    } catch (e) {
      print('Error saving to storage: $e');
      rethrow;
    }
  }

  static Future<int?> getSecuredInt(String key) async {
    try {
      if (key.isEmpty) {
        print('Error: Attempted to get secure int with empty key. Stack trace: ${StackTrace.current}');
        return null;
      }
      if (kIsWeb) {
        final prefs = await _getPrefs();
        final value = prefs.getInt(key);
        print('Retrieved from SharedPreferences: key=$key, value=$value');
        return value;
      } else {
        final value = await _secureStorage.read(key: key);
        final intValue = int.tryParse(value ?? '');
        print('Retrieved from secure storage: key=$key, value=$intValue');
        return intValue;
      }
    } catch (e) {
      print('Error reading from storage: $e');
      return null;
    }
  }

  static Future<void> clearAllSecuredData() async {
    try {
      if (kIsWeb) {
        final prefs = await _getPrefs();
        await prefs.clear();
        print('Cleared all SharedPreferences');
      } else {
        await _secureStorage.deleteAll();
        print('Cleared all secure storage');
      }
    } catch (e) {
      print('Error clearing storage: $e');
      rethrow;
    }
  }
}