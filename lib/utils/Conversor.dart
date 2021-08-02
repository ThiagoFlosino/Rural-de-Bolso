import 'dart:convert';
import 'dart:developer';

class Conversor {
  static Conversor instance = new Conversor();

  parseJSFCLJS(javaScriptCode, document) {
    if (!javaScriptCode.contains('getElementById')) return;

    // var formQuery = javaScriptCode.replaceAll(
    //     RegExp(r"/if([\S\s]*?)getElementById\('|'([\S\s]*?)false/gm"), '');
    RegExp exp = RegExp(r"j_id_jsp\w*");
    var formQuery = exp.stringMatch(javaScriptCode).toString();

    var listForm = document.querySelectorAll('#${formQuery}');
    if (listForm == null) {
      return false;
    }
    var formEl = listForm[0];

    var formAction = formEl.attributes['action'];
    if (formAction == null || formAction == '') return;
    // throw new Error('SIGAA: Form without action.');

    var action = 'https://sigaa.ufrrj.br${formAction}';
    var postValues = {};

    var inputs = formEl.querySelectorAll("input:not([type='submit'])");
    for (final element in inputs) {
      var name = element.attributes['name'];
      var value = "${element.attributes['value']}";
      if (name != null && name != '') {
        postValues[name] = value;
      }
    }

// TODO: CORRIGIR ESSE REGEX
    var replace = javaScriptCode
        .replaceAll(RegExp(r'([\S\s]*?){'), '')
        .replaceAll(RegExp(r'},([\S\s]*?)false'), '');
    // .replaceAll(RegExp(r'\"'), '\"')
    // .replaceAll(RegExp(r"\'"), '"');
    var postValuesString = '{${replace}}';
    // log(action);
    // log(postValuesString);
    var json = jsonDecode(postValuesString.replaceAll("'", "\""));
    var retorno = {};
    retorno['action'] = action;
    json.keys.forEach((element) {
      postValues[element] = json[element];
    });
    retorno['form'] = postValues;

    // log(retorno.toString());

    return retorno;
  }
}
