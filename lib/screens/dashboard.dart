import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:rural_de_bolso/model/Aluno.dart';
import 'package:rural_de_bolso/scrapping/LandingPage.dart';
import 'package:intl/intl.dart';
import 'package:rural_de_bolso/utils/app_router.dart';

class Dashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DashboardState();
  }
}

class DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rural de bolso"),
        // automaticallyImplyLeading: false,
      ),
      drawer: Drawer(
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
      ),
      body: FutureBuilder<Aluno>(
        initialData: null,
        future: LandingPage.instance.extraiInformacaoesLanding(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              final Aluno _aluno = snapshot.data as Aluno;
              return SingleChildScrollView(child: _infos(_aluno));
          }
          return Text('Unknown Error');
        },
      ),
    );
  }
}

class _infos extends StatelessWidget {
  final Aluno _aluno;

  const _infos(this._aluno);

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 120,
            color: Theme.of(context).primaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(_aluno.img),
                  radius: 50,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.person_outline,
                            color: Theme.of(context).accentColor),
                        SizedBox(width: 4),
                        Text(_aluno.nome,
                            style: TextStyle(fontSize: 16),
                            overflow: TextOverflow.ellipsis),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.domain_outlined,
                            color: Theme.of(context).accentColor),
                        SizedBox(width: 4),
                        Text(_aluno.departamento,
                            style: TextStyle(fontSize: 12)),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.school_outlined,
                            color: Theme.of(context).accentColor),
                        SizedBox(width: 4),
                        Text('Período atual: ' + _aluno.semestre,
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
              percent: _aluno.valores['percentual'],
              center: Text(
                (_aluno.valores['percentual'] * 100).toString() +
                    '% Integralizado',
                style: TextStyle(color: Colors.white),
              ),
              linearStrokeCap: LinearStrokeCap.roundAll,
              progressColor: Theme.of(context).primaryColor,
            ),
          ),
          horarios(aluno: _aluno),
          Container(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                // padding: const EdgeInsets.all(20.0),
                itemCount: _aluno.materias.length,
                itemBuilder: (context, index) {
                  return Card(child: Text(_aluno.materias[index]));
                }),
          ),
          // Container(
          //   height: 200,
          //   child: ListView.builder(
          //       scrollDirection: Axis.vertical,
          //       shrinkWrap: true,
          //       // padding: const EdgeInsets.all(20.0),
          //       itemCount: 3, // Pegando só o Top3
          //       itemBuilder: (context, index) {
          //         return Card(
          //             child: ListTile(
          //                 title: Text(DateFormat("dd/MM/yyyy")
          //                         .format(_aluno.updates[index].data) +
          //                     ' - ' +
          //                     _aluno.updates[index].titulo),
          //                 subtitle: Text(_aluno.updates[index].descricao)));
          //       }),
          // ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(AppRouter.NOTIFICAOES, arguments: _aluno.updates);
            },
            child: Text('Sair', style: TextStyle(fontSize: 20)),
          ),
        ],
      ),
    ));
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
    print(int.parse(widget.aluno.valores['obrigatoria']) / 3360);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width: 120,
          child: CircularPercentIndicator(
            radius: 120.0,
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
                    style: TextStyle(color: Colors.black),
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
          width: 120,
          child: CircularPercentIndicator(
            radius: 120.0,
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
                  Text(
                    'Complementar',
                    style: TextStyle(color: Colors.black),
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
          width: 120,
          child: CircularPercentIndicator(
            radius: 120.0,
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
                    style: TextStyle(color: Colors.black),
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
