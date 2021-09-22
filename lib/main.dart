import 'package:flutter/material.dart';
import 'package:rural_de_bolso/screens/Login.dart';
import 'package:rural_de_bolso/screens/MateriaScreen.dart';
import 'package:rural_de_bolso/screens/NotificacaoPage.dart';
import 'package:rural_de_bolso/screens/SplashScreen.dart';
import 'package:rural_de_bolso/screens/dashboard.dart';
import 'package:rural_de_bolso/utils/HttpConnection.dart';
import 'package:rural_de_bolso/utils/app_router.dart';

void main() {
  runApp(RuralDeBolso());
}

class RuralDeBolso extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HttpConnection.Configure();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RuralDeBolso',
      theme: ThemeData(
          primarySwatch: Colors.green, accentColor: Colors.greenAccent),
      initialRoute: "SPLASH",
//          appController.instance.isLogged ? AppRouter.HOME : AppRouter.LOGIN,
      routes: {
        AppRouter.LOGIN: (context) => Login(),
        AppRouter.HOME: (context) => Dashboard(),
        AppRouter.MATERIAS: (context) => MateriaScreen(),
        "SPLASH": (context) => SplashScreen()
      },
    );
  }
}

// class Splash extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(child: Image.asset("assets/images/logo.png")),
//     );
//   }
// }
