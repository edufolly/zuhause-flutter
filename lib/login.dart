import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:zuhause/components/MyHttp.dart';
import 'package:zuhause/home.dart';
import 'package:zuhause/model/User.dart';
import 'package:zuhause/util/MyDialogs.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  static const String routerName = '/login';

  @override
  _LoginState createState() => new _LoginState();
}

class _LoginState extends State<Login> {
  final storage = new FlutterSecureStorage();

  static final TextEditingController _server = new TextEditingController();
  static final TextEditingController _user = new TextEditingController();
  static final TextEditingController _pass = new TextEditingController();

  User u = new User();

  @override
  void initState() {
    storage.read(key: 'server').then((server) {
      if (server != null) {
        u.server = server;
        storage.read(key: 'user').then((user) {
          if (user != null) {
            u.user = user;
            storage.read(key: 'pass').then((pass) {
              if (pass != null) {
                u.pass = pass;
                valid();
              }
            });
          }
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Zuhause'),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return new ListView(
      padding: const EdgeInsets.all(40.0),
      children: <Widget>[
        new Icon(
          Icons.home,
          size: 130.0,
          color: Theme.of(context).accentColor,
        ),
        new Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: new TextField(
            controller: _server,
            keyboardType: TextInputType.url,
            decoration: new InputDecoration(hintText: 'Servidor'),
          ),
        ),
        new Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: new TextField(
            controller: _user,
            keyboardType: TextInputType.text,
            decoration: new InputDecoration(hintText: 'Usuário'),
          ),
        ),
        new Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: new TextField(
            controller: _pass,
            obscureText: true,
            keyboardType: TextInputType.text,
            decoration: new InputDecoration(hintText: 'Senha'),
          ),
        ),
        new Padding(
          padding: const EdgeInsets.only(top: 60.0),
          child: new RaisedButton(
            child: new Text(
              'ENTRAR',
              style: new TextStyle(color: Colors.white),
            ),
            onPressed: login,
          ),
        ),
      ],
    );
  }

  void login() {
    if (_server.text.isEmpty) {
      MyDialogs.alertError(context, 'O servidor deve ser informado.');
      return;
    }

    if (_user.text.isEmpty) {
      MyDialogs.alertError(context, 'O usuário deve ser informado.');
      return;
    }

    if (_pass.text.isEmpty) {
      MyDialogs.alertError(context, 'A senha deve ser informada.');
      return;
    }

    u.server = _server.text;
    u.user = _user.text;
    u.pass = _pass.text;

    valid();
  }

  void valid() async {
    MyDialogs.circularWating(context, 'Autenticando...');

    Map result = await MyHttp.get('/api/login');

    if (result['success']) {
      storage.write(key: 'server', value: u.server);
      storage.write(key: 'user', value: u.user);
      storage.write(key: 'pass', value: u.pass);

      _server.clear();
      _user.clear();
      _pass.clear();

      Navigator.pop(context);
      Navigator.of(context).pushReplacementNamed(Home.routerName);
    } else {
      Navigator.pop(context);
      MyDialogs.alertError(context, '${result['message']} (${result['code']})');
    }
  }
}
