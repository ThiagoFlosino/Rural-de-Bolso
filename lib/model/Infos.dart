class InfoMateria {
  late String titulo;
  late List<Infos> itens = List.empty();
}

class Infos {
  DateTime data;
  String descricao;

  Infos(this.data, this.descricao);
}
