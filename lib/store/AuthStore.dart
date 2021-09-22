import 'package:mobx/mobx.dart';
import 'package:rural_de_bolso/scrapping/ServiceLogin.dart';
import 'package:rural_de_bolso/store/SharePreferencesHelper.dart';
part 'AuthStore.g.dart';

class AuthStore = _AuthStoreBase with _$AuthStore;

abstract class _AuthStoreBase with Store {
  @observable
  String username = "";
  @observable
  String password = "";
  @observable
  bool isLogged = false;
  @observable
  bool loading = false;

  @action
  void setUsername(String _username) => username = _username;

  @action
  void setPassword(String _password) => password = _password;

  @action
  void setIsLogged(bool _isLogged) => isLogged = _isLogged;

  @computed
  bool get isValid => username.isNotEmpty && password.isNotEmpty;

  @action
  Future<void> login() async {
    // TODO: Adicionar log nessa funcao
    loading = true;
    if (isValid) {
      print("Logando...");
      isLogged = await ServiceLogin.doLogin(username, password);
      setIsLogged(isLogged);
      if (isLogged) {
        SharedPreferencesHelper.instance.setIsLogged(isLogged);
      } else {
        print("Erro ao logar");
      }
    }
    loading = false;
  }
}
