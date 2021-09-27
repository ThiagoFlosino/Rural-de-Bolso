import 'package:mobx/mobx.dart';
import 'package:rural_de_bolso/model/Aluno.dart';
import 'package:rural_de_bolso/model/Materia.dart';
import 'package:rural_de_bolso/model/Notificacao.dart';

part 'alunoStore.g.dart';

class AlunoStore = _AlunoStore with _$AlunoStore;

abstract class _AlunoStore with Store {
  @observable
  String nome = '';
  @observable
  String departamento = '';
  @observable
  String semestre = '';
  @observable
  String img = '';
  @observable
  ObservableList<Materia> materias = new ObservableList<Materia>();
  @observable
  ObservableList<Notificacao> notificacoes = new ObservableList<Notificacao>();
  // tabela;
  @observable
  var horasObrigatorias = 0.0;
  @observable
  var horasComplementares = 0.0;
  @observable
  var horasOptativas = 0.0;

  @observable
  var percentualIntegralizado = 0.0;

  @action
  setNome(value) {
    nome = value;
  }

  @action
  setDepartamento(value) {
    departamento = value;
  }

  @action
  setSemestre(value) {
    semestre = value;
  }

  @action
  setImg(value) {
    img = value;
  }

  @action
  setFromAlunoModel(Aluno aluno) {
    nome = aluno.nome;
    departamento = aluno.departamento;
    semestre = aluno.semestre;
    img = aluno.img;
    materias.clear();
    materias.addAll(aluno.materias);
    horasObrigatorias = double.parse(aluno.valores['obrigatoria']);
    horasOptativas = double.parse(aluno.valores['optativa']);
    horasComplementares = double.parse(aluno.valores['complementar']);
    percentualIntegralizado = aluno.valores['percentual'];
    notificacoes.clear();
    notificacoes.addAll(aluno.updates);
  }
}
