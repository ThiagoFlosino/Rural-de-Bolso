enum TipoNotificaco { Coordenacao, Materia }

class Notificacao {
  final DateTime data;
  final String titulo;
  final String descricao;
  bool lido = false;
  final TipoNotificaco tipo;

  Notificacao({
    required this.data,
    required this.titulo,
    required this.descricao,
    required this.tipo,
  });
}
