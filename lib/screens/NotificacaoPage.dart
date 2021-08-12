import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rural_de_bolso/model/Notificacao.dart';

class NotificacaoPage extends StatefulWidget {
  final List<Notificacao> notificacoes;

  const NotificacaoPage({Key? key, required this.notificacoes})
      : super(key: key);
  @override
  _NotificacaoPageState createState() => _NotificacaoPageState();
}

class _NotificacaoPageState extends State<NotificacaoPage> {
  @override
  Widget build(BuildContext context) {
    // final List<Notificacao> notificacoes =
    //     ModalRoute.of(context)?.settings.arguments as List<Notificacao>;
    return Scaffold(
      body: Center(
        child: ListView.builder(
            itemCount: widget.notificacoes.length,
            itemBuilder: (context, index) {
              return Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.notifications_none),
                      title: Text(widget.notificacoes[index].titulo),
                      subtitle: Text(widget.notificacoes[index].descricao),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.check,
                            color: widget.notificacoes[index].lido
                                ? Colors.green
                                : Colors.grey,
                          ),
                          tooltip: 'Marcar como',
                          onPressed: () {
                            setState(() {
                              widget.notificacoes[index].lido = true;
                            });
                          },
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                  ],
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.notificacoes.forEach((element) {
            element.lido = true;
          });
          setState(() {});
        },
        child: const Icon(Icons.done_all),
        backgroundColor: Colors.green,
      ),
    );
  }
}
