import 'package:dio/dio.dart';
import 'package:rural_de_bolso/model/Infos.dart';
import 'package:rural_de_bolso/model/Materia.dart';
import 'package:rural_de_bolso/utils/Conversor.dart';
import 'package:rural_de_bolso/utils/HttpConnection.dart';
import 'package:html/parser.dart' show parse;
import 'package:intl/intl.dart';

class MateriasPage {
  static MateriasPage instance = new MateriasPage();
  static String horarioTabelaRegex = r'\d{2}\w\d{2}/gi';

  Future<List<Materia>> extraiInformacaoesMaterias() async {
    Response response = await HttpConnection.dio
        .get('https://sigaa.ufrrj.br/sigaa/portais/discente/turmas.jsf');
    if (HttpConnection.webScraper.loadFromString(response.data)) {
      return extraiPeriodoAtual(parse(response.data));
    }
    return [];
  }

  Future<List<Materia>> extraiPeriodoAtual(document) async {
    List<Materia> lista = [];
    var periodo = 0;
    var tabelaMaterias = document.querySelectorAll("tr");
    if (tabelaMaterias.length == 0) {
      return [];
    }

    var periodoTitulo = '';
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
          periodoTitulo = txt;
        } else {
          break;
        }
      } else if (!linha.className.contains("destaque") && periodo != 0) {
        Materia materia = Materia();
        materia.semestre = periodoTitulo;
        for (var i = 0; i < linha.children.length; i++) {
          var node = linha.children[i];
          var txt =
              node.innerHtml.trim().replaceAll("\t", "").replaceAll("\n", "");
          if (txt == null || txt == '') {
          } else if (txt.contains("h") && !txt.contains("function")) {
            materia.cargaHoraria = txt;
          } else if ((txt.contains("(") == true ||
                  txt.contains(RegExp(horarioTabelaRegex)) == true) &&
              !txt.contains("function")) {
            materia.horario = txt;
          } else if (txt.contains("-") && !txt.contains("function")) {
            materia.nome = txt;
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
              // var atividade = ExtrairBody();
              List<InfoMateria> menuLaterial = await ExtraiMenuLateralMateria();
              materia.infoMaterias = [];
              materia.infoMaterias = menuLaterial;
            }
          }
        }
        lista.add(materia);
      }
    }
    return lista;
  }

  void ExtrairBody() {
    var Aulas = HttpConnection.webScraper.getElement('.titulo', ['id']);
    // var retornoAulas = [];
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

  Future<List<InfoMateria>> ExtraiMenuLateralMateria() async {
    List<InfoMateria> listaMenuLateral = [];
    var menuLaterialHeader =
        HttpConnection.webScraper.getElement('.headerBloco', ['id']);
    menuLaterialHeader.forEach((element) {
      InfoMateria infoMateria = InfoMateria();
      infoMateria.titulo = element['title'].trim();
      infoMateria.itens = List.empty();
      var id = element['attributes']['id'].toString().replaceAll('_header', '');
      var data = HttpConnection.webScraper.getElement('#${id} li .data', []);
      var descricao =
          HttpConnection.webScraper.getElement('#${id} li .descricao', []);
      int i = 0;
      List<Infos> listInfos = [];
      while (i < data.length) {
        DateTime dataInfo = new DateFormat('dd/MM/yyyy').parse(
            data[i]['title'].replaceAll(RegExp(r'\d{2}h'), '').trim() +
                '/' +
                DateTime.now().year.toString());
        Infos info = Infos(dataInfo, descricao[i]['title'].trim());
        listInfos.add(info);
        i++;
      }
      infoMateria.itens = listInfos;
      listaMenuLateral.add(infoMateria);
    });
    return listaMenuLateral;
  }
}
