import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:rural_de_bolso/components/hoario.dart';
import 'package:rural_de_bolso/store/alunoStore.dart';

class HomeScreen extends StatefulWidget {
  final AlunoStore alunoInfos;
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
              // percent: widget.alunoInfos.valores['percentual'],
              percent: widget.alunoInfos.percentualIntegralizado,
              center: Text(
                (widget.alunoInfos.percentualIntegralizado * 100).toString() +
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
