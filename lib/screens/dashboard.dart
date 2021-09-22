import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:rural_de_bolso/model/Aluno.dart';
import 'package:rural_de_bolso/model/Infos.dart';
import 'package:rural_de_bolso/scrapping/LandingPage.dart';
import 'package:rural_de_bolso/screens/ListMateriasScreen.dart';
import 'package:rural_de_bolso/screens/MateriaScreen.dart';
import 'package:rural_de_bolso/screens/NotificacaoPage.dart';
import 'package:rural_de_bolso/store/SharePreferencesHelper.dart';
import 'package:rural_de_bolso/utils/UserStorage.dart';
import 'package:rural_de_bolso/utils/app_router.dart';
import 'package:intl/intl.dart';

class Dashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DashboardState();
  }
}

class DashboardState extends State<Dashboard> {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  late Aluno alunoInfos;
  late AnimationController controller;

  _loadData() async {
    bool isLogged = await SharedPreferencesHelper.instance.isLogged();
    if (isLogged == true) {
      LandingPage.instance.extraiInformacaoesLanding().then((value) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        setState(() {
          alunoInfos = value;
        });
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
          return NotificacaoPage(notificacoes: alunoInfos.updates);
      }
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("Rural de bolso"),
        ),
        bottomNavigationBar: BottomNav(),
        drawer: MenuLateral(),
        body: FutureBuilder(
            future: _loadData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return getPage(_selectedIndex);
              } else {
                return CircularPercentIndicator(radius: 20);
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

  BottomNavigationBar BottomNav() {
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
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.amber[800],
      onTap: _onItemTapped,
    );
  }
}

class HomeScreen extends StatefulWidget {
  final Aluno alunoInfos;
  const HomeScreen({Key? key, required this.alunoInfos}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 120,
            color: Theme.of(context).primaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(widget.alunoInfos.img),
                        radius: 50,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Wrap(
                      children: [
                        Icon(Icons.person_outline,
                            color: Theme.of(context).accentColor),
                        SizedBox(width: 4),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Text(
                            widget.alunoInfos.nome,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.domain_outlined,
                            color: Theme.of(context).accentColor),
                        SizedBox(width: 4),
                        Text(widget.alunoInfos.departamento,
                            style: TextStyle(fontSize: 12)),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.school_outlined,
                            color: Theme.of(context).accentColor),
                        SizedBox(width: 4),
                        Text('Período atual: ' + widget.alunoInfos.semestre,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: new LinearPercentIndicator(
              width: MediaQuery.of(context).size.width - 50,
              animation: true,
              lineHeight: 15,
              animationDuration: 1000,
              percent: widget.alunoInfos.valores['percentual'],
              center: Text(
                (widget.alunoInfos.valores['percentual'] * 100).toString() +
                    '% Integralizado',
                style: TextStyle(color: Colors.white),
              ),
              linearStrokeCap: LinearStrokeCap.roundAll,
              progressColor: Theme.of(context).primaryColor,
            ),
          ),
          horarios(aluno: widget.alunoInfos)
        ],
      ),
    );
  }
}

class horarios extends StatefulWidget {
  final aluno;
  const horarios({Key? key, this.aluno}) : super(key: key);

  @override
  _horariosState createState() => _horariosState();
}

class _horariosState extends State<horarios> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width: 110,
          child: CircularPercentIndicator(
            radius: 110.0,
            lineWidth: 10.0,
            animation: true,
            percent: ((3360 - int.parse(widget.aluno.valores['obrigatoria'])) /
                3360),
            center: Container(
              padding: EdgeInsets.fromLTRB(10, 25, 10, 5),
              child: Column(
                children: [
                  Text(
                    'Obrigatórias',
                    style: TextStyle(color: Colors.black, fontSize: 11),
                  ),
                  Text(
                      '${3360 - int.parse(widget.aluno.valores['obrigatoria'])}',
                      style: TextStyle(fontSize: 20, color: Colors.black)),
                  Divider(
                    color: Colors.black,
                    height: 10,
                  ),
                  Text('3360',
                      style: TextStyle(fontSize: 20, color: Colors.black))
                ],
              ),
            ),
            backgroundColor: Colors.grey,
            circularStrokeCap: CircularStrokeCap.round,
            progressColor: Colors.redAccent,
          ),
        ),
        Container(
          width: 110,
          child: CircularPercentIndicator(
            radius: 110.0,
            lineWidth: 10.0,
            animation: true,
            percent:
                ((200 - int.parse(widget.aluno.valores['complementar'])) <= 0
                    ? 0
                    : ((200 - int.parse(widget.aluno.valores['complementar'])) /
                        200)),
            center: Container(
              padding: EdgeInsets.fromLTRB(10, 25, 10, 5),
              child: Column(
                children: [
                  Container(
                    // width: 85,
                    child: Text(
                      'Complementar',
                      style: TextStyle(color: Colors.black, fontSize: 11),
                    ),
                  ),
                  Text(
                      '${200 - int.parse(widget.aluno.valores['complementar'])}',
                      style: TextStyle(fontSize: 20, color: Colors.black)),
                  Divider(
                    color: Colors.black,
                    height: 10,
                  ),
                  Text('200',
                      style: TextStyle(fontSize: 20, color: Colors.black))
                ],
              ),
            ),
            backgroundColor: Colors.grey,
            circularStrokeCap: CircularStrokeCap.round,
            progressColor: Colors.blueAccent,
          ),
        ),
        Container(
          width: 110,
          child: CircularPercentIndicator(
            radius: 110.0,
            lineWidth: 10.0,
            animation: true,
            percent: ((120 - int.parse(widget.aluno.valores['optativa'])) <= 0
                ? 0
                : ((120 - int.parse(widget.aluno.valores['optativa'])) / 120)),
            center: Container(
              padding: EdgeInsets.fromLTRB(10, 25, 10, 5),
              child: Column(
                children: [
                  Text(
                    'Optativa',
                    style: TextStyle(color: Colors.black, fontSize: 11),
                  ),
                  Text('${120 - int.parse(widget.aluno.valores['optativa'])}',
                      style: TextStyle(fontSize: 20, color: Colors.black)),
                  Divider(
                    color: Colors.black,
                    height: 10,
                  ),
                  Text('120',
                      style: TextStyle(fontSize: 20, color: Colors.black))
                ],
              ),
            ),
            backgroundColor: Colors.grey,
            circularStrokeCap: CircularStrokeCap.round,
            progressColor: Colors.yellowAccent,
          ),
        ),
      ],
    );
  }
}
