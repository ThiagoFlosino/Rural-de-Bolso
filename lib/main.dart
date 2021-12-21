import 'package:flutter/material.dart';
import 'package:rural_de_bolso/screens/Login.dart';
import 'package:rural_de_bolso/screens/MateriaScreen.dart';
import 'package:rural_de_bolso/screens/SplashScreen.dart';
import 'package:rural_de_bolso/screens/dashboard.dart';
import 'package:rural_de_bolso/store/AuthStore.dart';
import 'package:rural_de_bolso/store/SharePreferencesHelper.dart';
import 'package:rural_de_bolso/utils/HttpConnection.dart';
import 'package:rural_de_bolso/utils/UserStorage.dart';
import 'package:rural_de_bolso/utils/app_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

// void main() {
//   runApp(RuralDeBolso());
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpConnection.Configure();
  CircularProgressIndicator(
      strokeWidth: 5, valueColor: AlwaysStoppedAnimation<Color>(Colors.green));
  await resetNewLaunch();
  runApp(RuralDeBolso());
}

class RuralDeBolso extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var logado = false;
    logado = UserStorage.logado;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RuralDeBolso',
      theme: ThemeData(
          primarySwatch: Colors.green, accentColor: Colors.greenAccent),
      initialRoute: logado ? AppRouter.HOME : AppRouter.LOGIN,
      routes: {
        AppRouter.LOGIN: (context) => Login(),
        AppRouter.HOME: (context) => Dashboard(),
        AppRouter.MATERIAS: (context) => MateriaScreen(),
        "SPLASH": (context) => SplashScreen()
      },
    );
  }

  buildShowDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}

AuthStore authStore = AuthStore();
resetNewLaunch() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey(UserPref.USERNAME.toString()) &&
      prefs.containsKey(UserPref.PASSWORD.toString())) {
    authStore
        .setUsername(prefs.getString(UserPref.USERNAME.toString()).toString());
    authStore
        .setPassword(prefs.getString(UserPref.PASSWORD.toString()).toString());
    await authStore.login();
  }
}
