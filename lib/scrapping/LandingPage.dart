import 'package:dio/dio.dart';
import 'package:rural_de_bolso/model/Aluno.dart';
import 'package:rural_de_bolso/model/Notificacao.dart';
import 'package:rural_de_bolso/utils/HttpConnection.dart';
import 'package:rural_de_bolso/utils/UserStorage.dart';

import 'MateriasScrapping.dart';

class LandingPage {
  static LandingPage instance = new LandingPage();

  Future<Aluno> extraiInformacaoesLanding() async {
    Response response = await HttpConnection.dio
        .get('https://sigaa.ufrrj.br/sigaa/portais/discente/discente.jsf');

    // CalendarioPage.instance.extraiInformacaoesLanding();
    Aluno aluno = Aluno(
        nome: '',
        departamento: '',
        semestre: '',
        img: '',
        materias: [],
        updates: []);
    if (HttpConnection.webScraper.loadFromString(response.data)) {
      var infoAluno = extraiInfosAluno();
      // var materias = extraiMaterias();
      var updates = extraiUpdates();
      var valores = extraiTabelaDadosAluno();
      var materiasDetalhes =
          await MateriasPage.instance.extraiInformacaoesMaterias();

      aluno = Aluno(
          nome: infoAluno['name'],
          departamento: infoAluno['dept'],
          semestre: infoAluno['sem'],
          img: infoAluno['img'],
          materias: materiasDetalhes,
          updates: updates,
          tabela: null,
          valores: valores);
    }
    UserStorage.setAluno(aluno);
    return aluno;
  }

  extraiUpdates() {
    List<Notificacao> updates = [];
    var elements = HttpConnection.webScraper.getElement('.rotator > table', []);
    elements.forEach((element) {
      if (element['title'] != null && element['title'] != '') {
        List partesNoticia = [];
        var texto = element['title'];
        var temp = texto.split(RegExp(r'\n'));
        temp.removeWhere((value) => value == '');
        temp.forEach((element) {
          var t = element.trim().replaceAll(RegExp(r'\t'), '');
          if (t != '') {
            if (t.contains(RegExp(r'(\d{2}\/){2}\d{4}'))) {
              t = t.replaceAll(RegExp(r'[^(\d{2}\/){2}\d{4}]'), '');
              var t2 = t.split('/');
              var dia, mes, ano;
              dia = t2[0];
              mes = t2[1];
              ano = t2[2];
              t = DateTime.parse('$ano-$mes-$dia');
            }
            partesNoticia.add(t);
          }
        });
        updates.add(new Notificacao(
            data: partesNoticia[0],
            titulo: partesNoticia[1].toString(),
            descricao: partesNoticia[2].toString(),
            tipo: TipoNotificaco.Materia));
      }
      ;
    });
    updates.sort((b, a) => a.data.compareTo(b.data));
    return updates;
  }

  extraiMaterias() {
    List<Map<String, dynamic>> elements;
    List<String> materia = [];
    elements = HttpConnection.webScraper
        .getElement('#main-docente #turmas-portal .descricao', []);
    elements.forEach((element) {
      if (element['title'] != null && element['title'] != '') {
        var texto = element['title'];
        materia.add(texto.trim());
      }
    });
    return materia;
  }

  extraiInfosAluno() {
    List<Map<String, dynamic>> elements;
    var name, dept, sem, img;

    // 'div#container > div#cabecalho > div#painel-usuario > div#info-usuario > p.usuario',
    elements = HttpConnection.webScraper.getElement('.nome > small > b', []);
    name = elements[0]['title'].toString().trim();
    elements = HttpConnection.webScraper.getElement(
        'div#container > div#cabecalho > div#painel-usuario > div#info-usuario > p.periodo-atual > strong',
        []);
    sem = elements[0]['title'].toString().trim();
    elements = HttpConnection.webScraper.getElement(
        'div#container > div#cabecalho > div#painel-usuario > div#info-usuario > p.unidade',
        []);
    dept = elements[0]['title'].toString().split('(')[0].trim();
    elements = HttpConnection.webScraper
        .getElement('.foto > img:nth-child(1)', ['src']);
    //'https://sigaa.ufrrj.br'
    img = elements[0]['attributes']['src'];
    return {'name': name, 'dept': dept, 'sem': sem, 'img': img};
  }

  extraiTabelaDadosAluno() {
    List<Map<String, dynamic>> elements;
    elements = HttpConnection.webScraper.getElement(
        '#perfil-docente > div > table > tbody> tr > td > table > tbody > tr > td',
        []);
    var valores = {};
    elements.forEach((element) {
      if (element['title'].contains('%')) {
        var percent = element['title']
            .trim()
            .replaceAll(RegExp(r'\t'), '')
            .replaceAll(RegExp(r'\n'), '')
            .replaceAll(RegExp(r'[^(\d{2})]'), '');
        valores['percentual'] =
            percent != '' ? double.parse(percent) / 100 : 0.0;
        // infos['integralizado'] = percent;
      }
    });

    elements = HttpConnection.webScraper.getElement(
        '#perfil-docente > div > table > tbody > tr > td> table > tbody > tr',
        []);
    elements.forEach((element) {
      var temp = element['title']
          .trim()
          .replaceAll(RegExp(r'\t'), '')
          .replaceAll(RegExp(r'\n'), '');
      if (temp.toLowerCase().contains('pendente')) {
        if (temp.toLowerCase().contains('optativa')) {
          print(temp.replaceAll(RegExp(r'[^(\d*)]'), ''));
          valores['optativa'] = temp.replaceAll(RegExp(r'[^(\d*)]'), '');
        }
        if (temp.toLowerCase().contains('obrigatória')) {
          print(temp.replaceAll(RegExp(r'[^(\d*)]'), ''));
          valores['obrigatoria'] = temp.replaceAll(RegExp(r'[^(\d*)]'), '');
        }
        if (temp.toLowerCase().contains('complementar')) {
          print(temp.replaceAll(RegExp(r'[^(\d*)]'), ''));
          valores['complementar'] = temp.replaceAll(RegExp(r'[^(\d*)]'), '');
        }
      }
    });
    print(valores);
    return valores;
    // return infos;
    // elements = HttpConnection.webScraper.getElement(
    //     '#perfil-docente #agenda-docente > table >  tbody > tr > td ', []);
    // elements.forEach((element) {
    //   if (element['title'] != null && element['title'] != '') {
    //     var texto = element['title'];
    //     texto = texto
    //         .trim()
    //         .replaceAll(RegExp(r'\t'), '')
    //         .replaceAll(RegExp(r'\n'), '');
    // print(texto);
    // if (texto.toLowerCase().contains("matrícula")) {
    //   retorno['matricula'] = texto[1].trim();
    // }
    // if (texto.toLowerCase().contains("curso")) {
    //   retorno['curso'] = texto[1].trim();
    // }
    // if (texto.toLowerCase().contains("nivel")) {
    //   retorno['nivel'] = texto[1].trim();
    // }
    // if (texto.toLowerCase().contains("status")) {
    //   retorno['status'] = texto[1].trim();
    // }
    // if (texto.toLowerCase().contains("email")) {
    //   retorno['email'] = texto[1].trim();
    // }
    // if (texto.toLowerCase().contains("entrada")) {
    //   retorno['dataEntrada'] = texto[1].trim();
    // }
    // if (texto.toLowerCase().contains("ingresso")) {
    //   retorno['tipoIngresso'] = texto[1].trim();
    // }
    // if (texto.toLowerCase().contains("ingresso")) {
    //   retorno['tipoIngresso'] = texto[1].trim();
    // }
  }
}
