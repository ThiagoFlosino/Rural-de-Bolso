class InfoMateria {
  late String titulo;
  late List<Infos> itens = List.empty();
  bool isExpanded;

  InfoMateria({this.isExpanded = false});
}

class Infos {
  String data;
  String descricao;

  Infos(this.data, this.descricao);
}
