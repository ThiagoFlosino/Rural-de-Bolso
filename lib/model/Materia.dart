import 'Infos.dart';

class Materia {
  String? nome;
  String? horario;
  String? semestre;
  String? cargaHoraria;
  List<InfoMateria>? infoMaterias;
  // final List<Notificacao> updates;
  // final tabela;
  // final valores;

  @override
  String toString() {
    return 'Materia{nome:$nome, horario: $horario, semestre: $semestre, cargaHoraria: $cargaHoraria}';
  }
}
