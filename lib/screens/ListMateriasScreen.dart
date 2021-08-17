import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rural_de_bolso/model/Materia.dart';
import 'package:rural_de_bolso/model/Notificacao.dart';
import 'package:rural_de_bolso/utils/app_router.dart';

class ListMateriasScreen extends StatefulWidget {
  final List<Materia> materias;

  const ListMateriasScreen({Key? key, required this.materias})
      : super(key: key);
  @override
  _ListMateriasScreenState createState() => _ListMateriasScreenState();
}

class _ListMateriasScreenState extends State<ListMateriasScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
          itemCount: widget.materias.length,
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () => Navigator.of(context).pushNamed(AppRouter.MATERIAS,
                    arguments: widget.materias[index]),
                child: Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.class__outlined),
                        title: Text(widget.materias[index].nome != null
                            ? widget.materias[index].nome.toString()
                            : '-'),
                        subtitle: Text(widget.materias[index].horario != null
                            ? widget.materias[index].horario.toString()
                            : 'NÃO EXTRAÍDO'),
                      )
                    ],
                  ),
                ));
          }),
    );
  }
}
