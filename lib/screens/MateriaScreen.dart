import 'package:flutter/material.dart';
import 'package:rural_de_bolso/model/Materia.dart';

class MateriaScreen extends StatefulWidget {
  const MateriaScreen({Key? key}) : super(key: key);

  @override
  _MateriaScreenState createState() => _MateriaScreenState();
}

class _MateriaScreenState extends State<MateriaScreen> {
  @override
  Widget build(BuildContext context) {
    final Materia materia =
        ModalRoute.of(context)?.settings.arguments as Materia;
    return Scaffold(
        appBar: AppBar(
          title: Text('Materia'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('${materia.nome}'),
            Row(
              children: [
                Text('Horário: ${materia.horario}'),
                Text('Carga Horária: ${materia.cargaHoraria}'),
              ],
            ),
            Text('Semestre: ${materia.semestre}'),
          ],
        ));
  }
}
