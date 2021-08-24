import 'package:flutter/material.dart';
import 'package:rural_de_bolso/model/Infos.dart';
import 'package:rural_de_bolso/model/Materia.dart';
import 'package:intl/intl.dart';

class MateriaScreen extends StatefulWidget {
  const MateriaScreen({Key? key}) : super(key: key);

  @override
  _MateriaScreenState createState() => _MateriaScreenState();
}

class _MateriaScreenState extends State<MateriaScreen> {
  @override
  Widget build(BuildContext context) {
    final Materia materia =
        ModalRoute.of(context)!.settings.arguments as Materia;
    return Scaffold(
      appBar: AppBar(
        title: Text('Materia'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 120,
              color: Theme.of(context).primaryColor,
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text('${materia.nome}',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                  SizedBox(height: 10),
                  Row(children: [
                    Text('Horário: ',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                    Text('${materia.horario}',
                        style: TextStyle(fontSize: 16, color: Colors.black))
                  ]),
                  Row(
                    children: [
                      Text('Semestre: ',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      Text('${materia.semestre}'),
                      SizedBox(width: 10),
                      Text('Carga Horária: ',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      Text('${materia.cargaHoraria}')
                    ],
                  ),
                ],
              ),
            ),
            ExpansionPanelList(
              expansionCallback: (int index, bool isExpanded) {
                setState(() {
                  materia.infoMaterias?[index].isExpanded = !isExpanded;
                });
              },
              children:
                  materia.infoMaterias!.map<ExpansionPanel>((InfoMateria item) {
                return ExpansionPanel(
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      title: Text(item.titulo),
                    );
                  },
                  body: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: item.itens.length,
                    itemBuilder: (context, indexSub) {
                      return Card(
                        child: ListTile(
                          leading: FlutterLogo(),
                          title: Text(item.itens[indexSub].descricao),
                          subtitle: Text((item.itens[indexSub].data != null
                              ? item.itens[indexSub].data!.toString()
                              : '-')),
                        ),
                      );
                    },
                  ),
                  isExpanded: item.isExpanded,
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}
