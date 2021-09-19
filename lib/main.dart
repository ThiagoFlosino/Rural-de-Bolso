import 'package:flutter/material.dart';
import 'package:rural_de_bolso/screens/Login.dart';
import 'package:rural_de_bolso/screens/MateriaScreen.dart';
import 'package:rural_de_bolso/screens/dashboard.dart';
import 'package:rural_de_bolso/utils/HttpConnection.dart';
import 'package:rural_de_bolso/utils/app_router.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

void main() async {
  runApp(RuralDeBolso());
  // await AndroidAlarmManager.initialize();
  // await AndroidAlarmManager.periodic(
  //     const Duration(minutes: 1), 0, atualizaDados());
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
      initialRoute: AppRouter.LOGIN,
      // initialRoute: appController.instance.isLogged ? AppRouter.HOME : AppRouter.LOGIN,
      routes: {
        AppRouter.LOGIN: (context) => Login(),
        AppRouter.HOME: (context) => Dashboard(),
        AppRouter.MATERIAS: (context) => MateriaScreen()
      },
    );
  }
}

// atualizaDados() {
//   LandingPage.instance.extraiInformacaoesLanding().then((value) => {
//         ScaffoldMessenger.of(context).hideCurrentSnackBar(),
//         Navigator.of(context)
//             .pushReplacementNamed(AppRouter.HOME, arguments: value),
//             print("executou")
//       });
// }
// class Splash extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(child: Image.asset("assets/images/logo.png")),
//     );
//   }
// }
