import 'package:rural_de_bolso/model/Materia.dart';
import 'package:rural_de_bolso/model/Notificacao.dart';

class Aluno {
  final String nome;
  final String departamento;
  final String semestre;
  final String img;
  final List<Materia> materias;
  final List<Notificacao> updates;
  final tabela;
  final valores;

  Aluno(
      {required this.nome,
      required this.departamento,
      required this.semestre,
      required this.img,
      required this.materias,
      required this.updates,
      this.tabela,
      this.valores});

  @override
  String toString() {
    return 'Aluno{nome:$nome, departamento: $departamento, semestre: $semestre, img: $img, percentual: $valores}';
  }
}
