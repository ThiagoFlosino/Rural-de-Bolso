import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';
import 'package:crypto/crypto.dart';

class SharedPreferencesHelper {
  static var key = utf8.encode('g"C3bP6H"_AZfSa`');
  Future<bool> setUserName(String username) async {
    final pref = await SharedPreferences.getInstance();
    return pref.setString(UserPref.USERNAME.toString(), username);
  }

  Future<bool> setPassword(String password) async {
    final pref = await SharedPreferences.getInstance();
    return pref.setString(UserPref.PASSWORD.toString(), password);
  }
}

enum UserPref { USERNAME, PASSWORD }
