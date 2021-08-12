import 'Infos.dart';

class Materia {
  late String nome;
  late String horario;
  late String semestre;
  late String cargaHoraria;
  late List<InfoMateria> infoMaterias;
  // final List<Notificacao> updates;
  // final tabela;
  // final valores;

  @override
  String toString() {
    return 'Materia{nome:$nome, horario: $horario, semestre: $semestre, cargaHoraria: $cargaHoraria}';
  }
}
