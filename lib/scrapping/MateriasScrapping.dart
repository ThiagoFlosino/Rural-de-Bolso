import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rural_de_bolso/utils/Conversor.dart';
import 'package:rural_de_bolso/utils/HttpConnection.dart';
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';
import 'package:intl/intl.dart';

class MateriasPage {
  static MateriasPage instance = new MateriasPage();
  static String horarioTabelaRegex = r'\d{2}\w\d{2}/gi';

  void extraiInformacaoesMaterias() async {
    Response response = await HttpConnection.dio
        .get('https://sigaa.ufrrj.br/sigaa/portais/discente/turmas.jsf');
    if (HttpConnection.webScraper.loadFromString(response.data)) {
      extraiPeriodoAtual(parse(response.data));
    }
  }

  extraiPeriodoAtual(document) async {
    var lista = {
      "periodo": "",
      "materias": List,
    };
    var periodo = 0;
    var tabelaMaterias = document.querySelectorAll("tr");
    if (tabelaMaterias.length == 0) {
      return;
    }

    var materias = [];
    for (final linha in tabelaMaterias) {
      if (linha.className.contains("destaque")) {
        if (periodo == 0) {
          var txt = '';
          linha.children.forEach((celula) => {
                txt = celula.innerHtml
                    .trim()
                    .replaceAll("\t", "")
                    .replaceAll("\n", "")
              });
          periodo++;
          lista['periodo'] = txt;
        } else {
          lista['materias'] = materias;
          break;
        }
      } else if (!linha.className.contains("destaque") && periodo != 0) {
        var materia = {};
        for (var i = 0; i < linha.children.length; i++) {
          var node = linha.children[i];
          var txt =
              node.innerHtml.trim().replaceAll("\t", "").replaceAll("\n", "");
          if (txt == null || txt == '') {
          } else if (txt.contains("h") && !txt.contains("function")) {
            materia['horas'] = txt;
          } else if ((txt.contains("(") == true ||
                  txt.contains(RegExp(horarioTabelaRegex)) == true) &&
              !txt.contains("function")) {
            materia['horario'] = txt;
          } else if (txt.contains("-") && !txt.contains("function")) {
            materia['nome'] = txt;
          } else if (txt.contains('href') && !txt.contains('script')) {
            var link = node.children[0];
            var textoLink = link.attributes['onclick'];
            var limpo = textoLink
                .replaceAll(
                    'var a=function(){return prevenirDuploClique();};var b=function(){',
                    '')
                .replaceAll('};return (a()==false) ? false : b();', '');
            var post = Conversor.instance.parseJSFCLJS(limpo, document);
            Response respPost = await HttpConnection.dio
                .post(post['action'], data: post['form']);
            if (HttpConnection.webScraper.loadFromString(respPost.data)) {
              var atividade = ExtrairBody();
              var menuLaterial = await ExtraiMenuLateralMateria();
              materia['menuLateral'] = menuLaterial;
            }
          }
        }
        materias.add(materia);
      }
    }
    // log(lista.toString());
    return lista;
  }

  void ExtrairBody() {
    var Aulas = HttpConnection.webScraper.getElement('.titulo', ['id']);
    var retornoAulas = [];
    var tituloAula;
    Aulas.forEach((element) {
      tituloAula = element['title']
          .trim()
          .replaceAll(RegExp(r'\t'), '')
          .replaceAll(RegExp(r'\n'), '');
      var id = element['attributes']['id']
          .toString()
          .replaceAll('formAva:', '')
          .replaceAll(RegExp(r':\d+:titulo'), '');
      var conteudos =
          HttpConnection.webScraper.getElement('.conteudotopico', ['id']);
      conteudos.forEach((element) {
        if (element['attributes']['id'].toString().contains(id)) {
          // print(element['title'].toString().replaceAll(from, replace));
        }
      });
    });
    return tituloAula;
  }

  Future<List> ExtraiMenuLateralMateria() async {
    var listaMenuLateral = [];
    var menuLaterialHeader =
        HttpConnection.webScraper.getElement('.headerBloco', ['id']);
    menuLaterialHeader.forEach((element) {
      var id = element['attributes']['id'].toString().replaceAll('_header', '');
      var subMenu = {'titulo': element['title'].trim(), 'itens': []};
      var data = HttpConnection.webScraper.getElement('#${id} li .data', []);
      var descricao =
          HttpConnection.webScraper.getElement('#${id} li .descricao', []);
      int i = 0;
      while (i < data.length) {
        subMenu['itens'].add({
          'data': new DateFormat('dd/MM/yyyy').parse(
              data[i]['title'].replaceAll(RegExp(r'\d{2}h'), '').trim() +
                  '/' +
                  DateTime.now().year.toString()),
          'descricao': descricao[i]['title'].trim()
        });
        i++;
      }
      listaMenuLateral.add(subMenu);
    });
    return listaMenuLateral;
  }
}
