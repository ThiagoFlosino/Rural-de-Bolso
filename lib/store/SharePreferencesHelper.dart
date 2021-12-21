import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';

class SharedPreferencesHelper {
  static SharedPreferencesHelper instance = new SharedPreferencesHelper();

  static var key = utf8.encode('g"C3bP6H"_AZfSa`');
  Future<bool> setUserName(String username) async {
    final pref = await SharedPreferences.getInstance();
    return pref.setString(UserPref.USERNAME.toString(), username);
  }

  Future<bool> setPassword(String password) async {
    final pref = await SharedPreferences.getInstance();
    return pref.setString(UserPref.PASSWORD.toString(), password);
  }

  Future<bool> setIsLogged(bool boolean) async {
    final pref = await SharedPreferences.getInstance();
    return pref.setBool(UserPref.ISLOGGED.toString(), boolean);
  }

  Future<bool> isLogged() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getBool(UserPref.ISLOGGED.toString()) ?? false;
  }

  Future<void> logout() async {
    final pref = await SharedPreferences.getInstance();
    pref.remove(UserPref.USERNAME.toString());
    pref.remove(UserPref.PASSWORD.toString());
    pref.remove(UserPref.ISLOGGED.toString());
  }
}

enum UserPref { USERNAME, PASSWORD, ISLOGGED }
