import 'dart:convert';

class Conversor {
  static Conversor instance = new Conversor();

  parseJSFCLJS(javaScriptCode, document) {
    if (!javaScriptCode.contains('getElementById')) return;

    RegExp exp = RegExp(r"j_id_jsp\w*");
    var formQuery = exp.stringMatch(javaScriptCode).toString();

    var listForm = document.querySelectorAll('#$formQuery');
    if (listForm == null) {
      return false;
    }
    var formEl = listForm[0];

    var formAction = formEl.attributes['action'];
    if (formAction == null || formAction == '') return;

    var action = 'https://sigaa.ufrrj.br$formAction';
    var postValues = {};

    var inputs = formEl.querySelectorAll("input:not([type='submit'])");
    for (final element in inputs) {
      var name = element.attributes['name'];
      var value = "${element.attributes['value']}";
      if (name != null && name != '') {
        postValues[name] = value;
      }
    }

    var replace = javaScriptCode
        .replaceAll(RegExp(r'([\S\s]*?){'), '')
        .replaceAll(RegExp(r'},([\S\s]*?)false'), '');
    var postValuesString = '{$replace}';
    var json = jsonDecode(postValuesString.replaceAll("'", "\""));
    var retorno = {};
    retorno['action'] = action;
    json.keys.forEach((element) {
      postValues[element] = json[element];
    });
    retorno['form'] = postValues;

    return retorno;
  }
}
