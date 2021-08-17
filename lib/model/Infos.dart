class InfoMateria {
  late String titulo;
  late List<Infos> itens = List.empty();
  bool isExpanded;

  InfoMateria({this.isExpanded = false});
}

class Infos {
  DateTime data;
  String descricao;

  Infos(this.data, this.descricao);
}
