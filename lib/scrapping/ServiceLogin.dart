import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rural_de_bolso/utils/HttpConnection.dart';
import 'package:rural_de_bolso/utils/UserStorage.dart';
import 'package:rural_de_bolso/utils/appController.dart';
import 'package:html/parser.dart' show parse;

class ServiceLogin {
  static Future<bool> doLogin(user, pass) async {
    // TODO: Adicionar log nessa funcao
    UserStorage.setUsername(user);
    UserStorage.setPassword(pass);
    await HttpConnection.dio
        .get("https://sigaa.ufrrj.br/sigaa/verTelaLogin.do");
    var cookie = await HttpConnection.cookieJar
        .loadForRequest(Uri.parse("https://sigaa.ufrrj.br/"));
    var _jsessionId = cookie.toString().split(';')[0].split('=')[1];

    Response response = await HttpConnection.dio.get(
        'https://sigaa.ufrrj.br/sigaa/logar.do;jsessionid=$_jsessionId?dispatch=logOn&user.login=$user&user.senha=$pass');
    var url;
    while (response.statusCode == 302) {
      url = extraiHtml(response);
      while (url.toString().contains('telaAvisoLogon.jsf')) {
        await trataTelaAviso(url).then((value) => url = value);
      }
      response = await HttpConnection.dio.get(url);
    }
    if (response.data.toString().contains('rio e/ou senha inv')) {
      print("ERRO AO LOGAR");
      UserStorage.setLoggedIn(false);
      appController.instance.setIsLogged(false);
      return false;
    }
    UserStorage.setLoggedIn(true);
    appController.instance.setIsLogged(true);
    return true;
  }

  static Future<String> trataTelaAviso(url) async {
    Response response = await HttpConnection.dio.get(url);
    var post = {};
    if (response.data != null) {
      var document = parse(response.data);
      var forms = document.querySelectorAll('form[id*="j_id"]');
      var form = forms[0];
      form.attributes.forEach((key, value) {
        if (key == 'action') {
          post['action'] = 'https://sigaa.ufrrj.br${value}';
        }
      });

      var postData = {};
      form.children.forEach((element) {
        if (element.localName == 'input') {
          var name;
          var valor;
          element.attributes.forEach((key, value) {
            if (key == 'name') {
              name = value;
            }
            if (key == 'value') {
              valor = value;
            }
          });
          postData[name] = valor;
        }
        if (element.localName == 'div') {
          element.children.forEach((e) {
            if (e.localName == 'input') {
              var name;
              var valor;
              e.attributes.forEach((key, value) {
                if (key == 'name') {
                  name = value;
                }
                if (key == 'value') {
                  valor = value;
                }
              });
              postData[name] = valor;
            }
          });
        }
      });
      post['form'] = postData;
    }
    log(post.toString());
    Response respPost =
        await HttpConnection.dio.post(post['action'], data: post['form']);
    return extraiHtml(respPost);
  }

  static extraiHtml(response) {
    var url;
    if (response.headers.toString().contains("location:")) {
      var loc = response.headers['location'].toString().split(':');
      loc[0] = "https";
      loc[1] = loc[1].substring(0, loc[1].length - 1);
      url = loc.join(':');
    }
    return url;
  }
}
