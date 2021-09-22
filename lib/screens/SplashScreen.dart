import 'dart:async';
import 'dart:developer';
import 'package:rural_de_bolso/screens/Login.dart';
import 'package:rural_de_bolso/screens/dashboard.dart';
import 'package:rural_de_bolso/store/AuthStore.dart';
import 'package:rural_de_bolso/store/SharePreferencesHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AuthStore authStore = AuthStore();
  resetNewLaunch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    log('entrou aqui');
    if (prefs.containsKey(UserPref.USERNAME.toString()) &&
        prefs.containsKey(UserPref.PASSWORD.toString())) {
      log('Preenchido');
      authStore.setUsername(
          prefs.getString(UserPref.USERNAME.toString()).toString());
      authStore.setPassword(
          prefs.getString(UserPref.PASSWORD.toString()).toString());
      await authStore.login();
    }
  }

  @override
  void initState() {
    super.initState();
    resetNewLaunch();
    Timer(
        Duration(seconds: 5),
        () => Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return authStore.isLogged ? Dashboard() : Login();
            })));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: Colors.blue,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Splash Screen',
                      style: new TextStyle(color: Colors.white, fontSize: 40)),
                ],
              ),
            )));
  }
}
