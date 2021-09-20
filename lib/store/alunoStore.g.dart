// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alunoStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AlunoStore on _AlunoStore, Store {
  final _$nomeAtom = Atom(name: '_AlunoStore.nome');

  @override
  String get nome {
    _$nomeAtom.reportRead();
    return super.nome;
  }

  @override
  set nome(String value) {
    _$nomeAtom.reportWrite(value, super.nome, () {
      super.nome = value;
    });
  }

  final _$departamentoAtom = Atom(name: '_AlunoStore.departamento');

  @override
  String get departamento {
    _$departamentoAtom.reportRead();
    return super.departamento;
  }

  @override
  set departamento(String value) {
    _$departamentoAtom.reportWrite(value, super.departamento, () {
      super.departamento = value;
    });
  }

  final _$semestreAtom = Atom(name: '_AlunoStore.semestre');

  @override
  String get semestre {
    _$semestreAtom.reportRead();
    return super.semestre;
  }

  @override
  set semestre(String value) {
    _$semestreAtom.reportWrite(value, super.semestre, () {
      super.semestre = value;
    });
  }

  final _$imgAtom = Atom(name: '_AlunoStore.img');

  @override
  String get img {
    _$imgAtom.reportRead();
    return super.img;
  }

  @override
  set img(String value) {
    _$imgAtom.reportWrite(value, super.img, () {
      super.img = value;
    });
  }

  final _$materiasAtom = Atom(name: '_AlunoStore.materias');

  @override
  ObservableList<Materia> get materias {
    _$materiasAtom.reportRead();
    return super.materias;
  }

  @override
  set materias(ObservableList<Materia> value) {
    _$materiasAtom.reportWrite(value, super.materias, () {
      super.materias = value;
    });
  }

  final _$notificacoesAtom = Atom(name: '_AlunoStore.notificacoes');

  @override
  ObservableList<Notificacao> get notificacoes {
    _$notificacoesAtom.reportRead();
    return super.notificacoes;
  }

  @override
  set notificacoes(ObservableList<Notificacao> value) {
    _$notificacoesAtom.reportWrite(value, super.notificacoes, () {
      super.notificacoes = value;
    });
  }

  final _$infosAtom = Atom(name: '_AlunoStore.infos');

  @override
  Object get infos {
    _$infosAtom.reportRead();
    return super.infos;
  }

  @override
  set infos(Object value) {
    _$infosAtom.reportWrite(value, super.infos, () {
      super.infos = value;
    });
  }

  final _$_AlunoStoreActionController = ActionController(name: '_AlunoStore');

  @override
  dynamic setNome(dynamic value) {
    final _$actionInfo =
        _$_AlunoStoreActionController.startAction(name: '_AlunoStore.setNome');
    try {
      return super.setNome(value);
    } finally {
      _$_AlunoStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setDepartamento(dynamic value) {
    final _$actionInfo = _$_AlunoStoreActionController.startAction(
        name: '_AlunoStore.setDepartamento');
    try {
      return super.setDepartamento(value);
    } finally {
      _$_AlunoStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSemestre(dynamic value) {
    final _$actionInfo = _$_AlunoStoreActionController.startAction(
        name: '_AlunoStore.setSemestre');
    try {
      return super.setSemestre(value);
    } finally {
      _$_AlunoStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setImg(dynamic value) {
    final _$actionInfo =
        _$_AlunoStoreActionController.startAction(name: '_AlunoStore.setImg');
    try {
      return super.setImg(value);
    } finally {
      _$_AlunoStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
nome: ${nome},
departamento: ${departamento},
semestre: ${semestre},
img: ${img},
materias: ${materias},
notificacoes: ${notificacoes},
infos: ${infos}
    ''';
  }
}
