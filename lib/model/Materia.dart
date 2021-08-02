class Materia {
  final String nome;
  final String horario;
  final String semestre;
  final String cargaHoraria;
  // final List<String> materias;
  // final List<Notificacao> updates;
  // final tabela;
  // final valores;

  Materia(
      {required this.nome,
      required this.horario,
      required this.semestre,
      required this.cargaHoraria});

  @override
  String toString() {
    return 'Materia{nome:$nome, horario: $horario, semestre: $semestre, cargaHoraria: $cargaHoraria}';
  }
}
