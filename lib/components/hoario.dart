import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

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
            percent: ((3360 - widget.aluno.horasObrigatorias) / 3360),
            center: Container(
              padding: EdgeInsets.fromLTRB(10, 25, 10, 5),
              child: Column(
                children: [
                  Text(
                    'Obrigatórias',
                    style: TextStyle(color: Colors.black, fontSize: 11),
                  ),
                  Text('${3360 - widget.aluno.horasObrigatorias}',
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
            percent: ((200 - widget.aluno.horasComplementares) <= 0
                ? 0
                : ((200 - widget.aluno.horasComplementares) / 200)),
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
                  Text('${200 - widget.aluno.horasComplementares}',
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
            percent: ((120 - widget.aluno.horasOptativas) <= 0
                ? 0
                : ((120 - widget.aluno.horasOptativas) / 120)),
            center: Container(
              padding: EdgeInsets.fromLTRB(10, 25, 10, 5),
              child: Column(
                children: [
                  Text(
                    'Optativa',
                    style: TextStyle(color: Colors.black, fontSize: 11),
                  ),
                  Text('${120 - widget.aluno.horasOptativas}',
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
