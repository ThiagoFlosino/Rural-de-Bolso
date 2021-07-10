import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:rural_de_bolso/model/Aluno.dart';
import 'package:rural_de_bolso/scrapping/LandingPage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

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
        automaticallyImplyLeading: false,
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
              final Aluno? _aluno = snapshot.data;
              return SingleChildScrollView(child: _infos(_aluno!));
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
          Row(
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
                  Text(_aluno.nome,
                      style: TextStyle(fontSize: 16),
                      overflow: TextOverflow.ellipsis),
                  Text(_aluno.departamento, style: TextStyle(fontSize: 12)),
                  Text('Período atual: ' + _aluno.semestre,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12)),
                ],
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: new LinearPercentIndicator(
              width: MediaQuery.of(context).size.width - 50,
              animation: true,
              lineHeight: 15,
              animationDuration: 1000,
              percent: _aluno.valores['percentual'],
              center: Text((_aluno.valores['percentual'] * 100).toString() +
                  '% Integralizado'),
              linearStrokeCap: LinearStrokeCap.roundAll,
              progressColor: Colors.greenAccent,
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
          Container(
            height: 200,
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                // padding: const EdgeInsets.all(20.0),
                itemCount: 3, // Pegando só o Top3
                itemBuilder: (context, index) {
                  return Card(
                      child: ListTile(
                          title: Text(DateFormat("dd/MM/yyyy")
                                  .format(_aluno.updates[index].data) +
                              ' - ' +
                              _aluno.updates[index].materia),
                          subtitle: Text(_aluno.updates[index].descricao)));
                }),
          ),
          ElevatedButton(
            onPressed: () async {},
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 120,
          child: Card(
            shape:
                BeveledRectangleBorder(borderRadius: BorderRadius.circular(5)),
            color: Colors.green,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    'Obrigatórias',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                      '${3360 - int.parse(widget.aluno.valores['obrigatoria'])}',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                  Divider(
                    color: Colors.white,
                  ),
                  Text('3360',
                      style: TextStyle(fontSize: 20, color: Colors.white))
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          width: 120,
          child: Card(
            shape:
                BeveledRectangleBorder(borderRadius: BorderRadius.circular(5)),
            color: Colors.green,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    'complementar',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                      '${200 - int.parse(widget.aluno.valores['complementar'])}',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                  Divider(
                    color: Colors.white,
                  ),
                  Text('200',
                      style: TextStyle(fontSize: 20, color: Colors.white))
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          width: 120,
          child: Card(
            shape:
                BeveledRectangleBorder(borderRadius: BorderRadius.circular(5)),
            color: Colors.green,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    'optativa',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text('${120 - int.parse(widget.aluno.valores['optativa'])}',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                  Divider(
                    color: Colors.white,
                  ),
                  Text('120',
                      style: TextStyle(fontSize: 20, color: Colors.white))
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
