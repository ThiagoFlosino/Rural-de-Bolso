import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:rural_de_bolso/scrapping/LandingPage.dart';
import 'package:rural_de_bolso/store/AuthStore.dart';
import 'package:rural_de_bolso/utils/app_router.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  AuthStore authStore = AuthStore();

  @override
  void didChangeDependencies() {
    // TODO: Adicionar log nessa funcao
    super.didChangeDependencies();
    reaction((_) => authStore.isLogged, (isLogged) {
      if (isLogged == true) {
        Navigator.of(context).pushReplacementNamed(AppRouter.HOME);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Image.asset(
            'assets/images/bg.jpg',
            fit: BoxFit.cover,
          )),
      SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Credenciais do SIGAA:',
                    style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.7),
                          offset: Offset(2, 2),
                          blurRadius: 5,
                        )
                      ],
                    )),
                SizedBox(height: 10),
                SizedBox(
                  width: 600,
                  child: TextField(
                    onChanged: authStore.setUsername,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      labelText: 'Usuário',
                      filled: true,
                      fillColor: Colors.white70,
                      focusColor: Colors.greenAccent,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: 600,
                  child: TextField(
                    onChanged: authStore.setPassword,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        labelText: 'Senha',
                        filled: true,
                        fillColor: Colors.white70),
                  ),
                ),
                SizedBox(height: 10),
                Observer(builder: (_) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(fixedSize: Size(240, 50)),
                    onPressed: authStore.isValid
                        ? () {
                            authStore.login();
                          }
                        : null,
                    child: authStore.loading
                        ? CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          )
                        : Text('Entrar', style: TextStyle(fontSize: 20)),
                  );
                }),
              ],
            ),
          ),
        ),
      )
    ]));
  }
}
