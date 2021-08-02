import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rural_de_bolso/model/Notificacao.dart';

class NotificacaoPage extends StatefulWidget {
  @override
  _NotificacaoPageState createState() => _NotificacaoPageState();
}

class _NotificacaoPageState extends State<NotificacaoPage> {
  @override
  Widget build(BuildContext context) {
    final List<Notificacao> notificacoes =
        ModalRoute.of(context)?.settings.arguments as List<Notificacao>;
    return Scaffold(
      appBar: AppBar(
        title: Text('Notificações'),
      ),
      body: Center(
        child: ListView.builder(
            itemCount: notificacoes.length,
            itemBuilder: (context, index) {
              return Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.notifications_none),
                      title: Text(notificacoes[index].titulo),
                      subtitle: Text(notificacoes[index].descricao),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.check,
                            color: notificacoes[index].lido
                                ? Colors.green
                                : Colors.grey,
                          ),
                          tooltip: 'Marcar como',
                          onPressed: () {
                            setState(() {
                              notificacoes[index].lido = true;
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
          notificacoes.forEach((element) {
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
