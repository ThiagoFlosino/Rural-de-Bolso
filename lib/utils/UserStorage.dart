import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rural_de_bolso/model/Aluno.dart';

class UserStorage {
  static final _storage = FlutterSecureStorage();

  static const _keyUserName = 'username';
  static const _keyPassword = 'password';
  static const _keyLoggedIn = 'loggedIn';
  static const _keyAluno = 'aluno';

  static Future setUsername(String username) async =>
      await _storage.write(key: _keyUserName, value: username);

  static Future setPassword(String password) async =>
      await _storage.write(key: _keyPassword, value: password);

  static Future setLoggedIn(bool loggedIn) async =>
      await _storage.write(key: _keyLoggedIn, value: loggedIn.toString());

  static Future<String?> getUsername() async =>
      await _storage.read(key: _keyUserName);

  static Future<String?> getPassword() async =>
      await _storage.read(key: _keyPassword);

  static Future<bool> isLoggedIn() async {
    var log = await _storage.read(key: _keyLoggedIn);
    if (log != null) {
      return log.toLowerCase() == 'true';
    } else {
      return false;
    }
  }

  static Future setAluno(Aluno aluno) async =>
      await _storage.write(key: _keyAluno, value: aluno.toString());

  static Future<Aluno?> getAluno() async =>
      await _storage.read(key: _keyAluno) as Aluno;
}
