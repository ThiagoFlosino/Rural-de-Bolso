import 'package:flutter/material.dart';
import 'package:rural_de_bolso/model/Aluno.dart';
import 'package:rural_de_bolso/scrapping/LandingPage.dart';
import 'package:rural_de_bolso/scrapping/ServiceLogin.dart';
import 'package:rural_de_bolso/utils/app_router.dart';
import 'package:rural_de_bolso/components/snackBar.dart';

class Login extends StatelessWidget {
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
        _body(),
      ]),
    );
  }
}

class _body extends StatefulWidget {
  @override
  __bodyState createState() => __bodyState();
}

class __bodyState extends State<_body> {
  String _username = '';

  String _pass = '';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                  onChanged: (text) {
                    _username = text;
                  },
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
                  onChanged: (text) {
                    _pass = text;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      labelText: 'Senha',
                      filled: true,
                      fillColor: Colors.white70),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                    content: new Row(
                      children: <Widget>[
                        new CircularProgressIndicator(),
                        new Text("  Signing-In...")
                      ],
                    ),
                    duration: new Duration(seconds: 10),
                  ));
                  ServiceLogin.doLogin(_username, _pass).then((logado) => {
                        if (logado)
                          {
                            LandingPage.instance
                                .extraiInformacaoesLanding()
                                .then((value) => {
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar(),
                                      Navigator.of(context)
                                          .pushReplacementNamed(AppRouter.HOME,
                                              arguments: value)
                                    })
                          }
                        else
                          {
                            ScaffoldMessenger.of(context).showSnackBar(
                                new CustomSnackBar('Usuário ou senha inválidos')
                                    .getSnackBar())
                          }
                      });
                },
                child: Text('Entrar', style: TextStyle(fontSize: 20)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
