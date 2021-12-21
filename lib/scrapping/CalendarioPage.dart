import 'package:dio/dio.dart';
import 'package:rural_de_bolso/utils/HttpConnection.dart';
import 'package:html/parser.dart'; // Contains HTML parsers to generate a Document object
// Contains DOM related classes for extracting data from elements

class CalendarioPage {
  static CalendarioPage instance = new CalendarioPage();

  // extraiInformacaoesLanding() async {
  //   Response response = await HttpConnection.dio
  //       .get('https://sigaa.ufrrj.br/sigaa/portais/discente/discente.jsf');
  //   // ,
  //   //     data: {
  //   //       "menu:form_menu_discente": "menu:form_menu_discente",
  //   //       "id": "38743",
  //   //       "jscook_action":
  //   //           "menu_form_menu_discente_j_id_jsp_1051466817_98_menu:A]#{calendario.iniciarBusca}",
  //   //       "javax.faces.ViewState": "j_id13"
  //   //     },
  //   //     options: Options(contentType: Headers.formUrlEncodedContentType));

  //   var document = parse(response.data);
  //   print(document.querySelectorAll(
  //       'table.ThemeOfficeSubMenuTable >tbody >tr.ThemeOfficeMenuItem:nth-child(25)'));
  //   // if (HttpConnection.webScraper.loadFromString(response.data)) {
  //   // var elements = HttpConnection.webScraper.document.querySelector('tr.ThemeOfficeMenuItem:nth-child(25) > td:nth-child(2)');
  //   //   var elements = HttpConnection.webScraper.getElement('#menu-dropdown', []);
  //   //   elements.forEach((element) {
  //   //     var teste = element['title'];
  //   //     teste = teste.split('_cmSplit');
  //   //     teste.forEach((t) {
  //   //       if (t.contains('Calend')) {
  //   //         log(t);
  //   //       }
  //   //     });
  //   //     // if (element['title'].contais('Calendário Acadêmico')) {
  //   //     //   print(element);
  //   //     // }
  //   //   });
  //   // }
  // }
}
