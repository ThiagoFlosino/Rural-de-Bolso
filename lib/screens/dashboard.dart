import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:rural_de_bolso/scrapping/LandingPage.dart';
import 'package:rural_de_bolso/screens/ListMateriasScreen.dart';
import 'package:rural_de_bolso/screens/NotificacaoPage.dart';
import 'package:rural_de_bolso/store/AuthStore.dart';
import 'package:rural_de_bolso/store/DashboardStore.dart';
import 'package:rural_de_bolso/store/SharePreferencesHelper.dart';
import 'package:rural_de_bolso/store/alunoStore.dart';
import 'package:rural_de_bolso/utils/app_router.dart';

import 'home.dart';

class Dashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DashboardState();
  }
}

class DashboardState extends State<Dashboard> {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  DashboardStore dashboardStore = new DashboardStore();
  void _onItemTapped(int index) {
    dashboardStore.setIndex(index);
  }

  AlunoStore alunoInfos = new AlunoStore();
  late AnimationController controller;

  _loadData() async {
    bool isLogged = await SharedPreferencesHelper.instance.isLogged();
    if (isLogged == true) {
      await LandingPage.instance.extraiInformacaoesLanding().then((value) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        alunoInfos.setFromAlunoModel(value);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // ModalRoute.of(context)?.settings.arguments as Aluno;
    Widget getPage(int index) {
      switch (index) {
        case 0:
          return HomeScreen(alunoInfos: alunoInfos);
        case 1:
          return ListMateriasScreen(materias: alunoInfos.materias);
        default:
          return NotificacaoPage(notificacoes: alunoInfos.notificacoes);
      }
    }

    return Scaffold(
        appBar: AppBar(title: Text("Rural de bolso"), actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'logout',
            onPressed: () {
              AuthStore authStore = new AuthStore();
              authStore.logout();
              Navigator.of(context).pushReplacementNamed(AppRouter.LOGIN);
            },
          ),
        ]),
        bottomNavigationBar: BottomNav(),
        drawer: MenuLateral(),
        body: FutureBuilder(
            future: _loadData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Observer(builder: (_) => getPage(dashboardStore.index));
              } else {
                return Center(
                    child: Container(
                  width: 100,
                  height: 100,
                  child: CircularProgressIndicator(
                      strokeWidth: 5,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.green)),
                ));
              }
            }));
  }

  Drawer MenuLateral() {
    return Drawer(
      child: SafeArea(
        child: Container(
          child: Column(
            children: [
              Container(
                color: Colors.green,
                width: double.infinity,
                height: 60,
                padding: EdgeInsets.all(20),
                child: Text(
                  'Rural de Bolso',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget BottomNav() {
    return Observer(builder: (_) {
      return BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Matérias',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notificações',
          ),
        ],
        currentIndex: dashboardStore.index,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      );
    });
  }
}
