import 'package:dio/dio.dart';
import 'package:rural_de_bolso/utils/HttpConnection.dart';
import 'package:rural_de_bolso/utils/UserStorage.dart';
import 'package:rural_de_bolso/utils/appController.dart';

class ServiceLogin {
  static Future<bool> doLogin(user, pass) async {
    UserStorage.setUsername(user);
    UserStorage.setPassword(pass);
    await HttpConnection.dio
        .get("https://sigaa.ufrrj.br/sigaa/verTelaLogin.do");
    var cookie = await HttpConnection.cookieJar
        .loadForRequest(Uri.parse("https://sigaa.ufrrj.br/"));
    var _jsessionId = cookie.toString().split(';')[0].split('=')[1];

    Response response = await HttpConnection.dio.get(
        'https://sigaa.ufrrj.br/sigaa/logar.do;jsessionid=$_jsessionId?dispatch=logOn&user.login=$user&user.senha=$pass');
    // print("Status: " + response.statusCode.toString() + " " + response.statusMessage);
    // print("Headers: " + response.headers.toString());
    // print("Data: " + response.data);

    var url;
    while (response.statusCode == 302) {
      if (response.headers.toString().contains("location:")) {
        var loc = response.headers['location'].toString().split(':');
        loc[0] = "https";
        loc[1] = loc[1].substring(0, loc[1].length - 1);
        url = loc.join(':');
        print(url.toString());
      }
      response = await HttpConnection.dio.get(url);
      // print("Status: " + response.statusCode.toString() + " " + response.statusMessage);
      // print("Headers: " + response.headers.toString());
      // print("Data: " + response.data);
    }
    // Handle login error
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
}
