import 'package:mobx/mobx.dart';
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
  Object infos = {};

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

  // @action
  // setSemestre(value) {
  //   semestre = value;
  // }
}
