import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SharedPrefKeys {
  static const String userToken = 'user_token';
  static const String donorId = 'donor_id';
}

class SharedPrefHelper {
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  static Future<void> setSecuredString(String key, String value) async {
    if (key.isEmpty) {
      debugPrint('FlutterSecureStorage: Error - key cannot be empty');
      throw ArgumentError('Storage key cannot be empty');
    }
    debugPrint('FlutterSecureStorage: setSecuredString with key: $key and value: $value');
    await _secureStorage.write(key: key, value: value);
  }

  static Future<String?> getSecuredString(String key) async {
    if (key.isEmpty) {
      debugPrint('FlutterSecureStorage: Error - key cannot be empty');
      throw ArgumentError('Storage key cannot be empty');
    }
    debugPrint('FlutterSecureStorage: getSecuredString with key: $key');
    return await _secureStorage.read(key: key);
  }

  static Future<void> clearAllSecuredData() async {
    debugPrint('FlutterSecureStorage: all data has been cleared');
    await _secureStorage.deleteAll();
  }
}