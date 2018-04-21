import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:zuhause/components/BasicButton.dart';
import 'package:zuhause/components/MyHttp.dart';
import 'package:zuhause/login.dart';
import 'package:zuhause/model/User.dart';
import 'package:zuhause/raspi.dart';
import 'package:zuhause/util/MyDialogs.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  static const String routerName = '/home';

  HomeState createState() => new HomeState();
}

class HomeState extends State<Home> {
  User user = new User();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: _buildDrawer(context),
      appBar: new AppBar(
        title: const Text('Zuhause'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => setState(() {}),
            child: new FutureBuilder(
              future: _getTemp(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return new CircularProgressIndicator(
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.white),
                    );
                  default:
                    if (snapshot.hasError) {
                      return new Text(
                        'Error: ${snapshot.error}',
                        style: new TextStyle(
                          color: Colors.white,
                        ),
                      );
                    } else {
                      return new Text(
                        '${snapshot.data}˚C',
                        style: new TextStyle(
                          color: Colors.white,
                        ),
                      );
                    }
                }
              },
            ),
          ),
        ],
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return new Drawer(
      child: new ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName: new Text(user.user),
            accountEmail: new Text(user.server),
            currentAccountPicture: new CircleAvatar(
              backgroundImage: new CachedNetworkImageProvider(
                user.getGravatarUrl(),
              ),
            ),
          ),
          new ListTile(
            leading: new Icon(Icons.home),
            title: new Text('Home'),
            selected: true,
          ),
          new ListTile(
            leading: new Icon(Icons.developer_board),
            title: new Text('Raspi'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(Raspi.routerName);
            },
          ),
          new Divider(),
          new ListTile(
            leading: new Icon(Icons.exit_to_app),
            title: new Text('Desconectar'),
            onTap: _logout,
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    return new GridView.count(
      crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3,
      padding: const EdgeInsets.all(4.0),
      childAspectRatio: (orientation == Orientation.portrait) ? 1.6 : 1.9,
      children: <Widget>[
        new GridTile(
          child: new BasicButton(
            text: 'Suíte',
            onPressed: () => _callApi('/api/luz/suite'),
          ),
        ),
        new GridTile(
          child: new BasicButton(
            text: 'Escritório',
            onPressed: () => _callApi('/api/luz/escritorio'),
          ),
        ),
        new GridTile(
          child: new BasicButton(
            text: 'Sala',
            onPressed: () => _callApi('/api/luz/sala'),
          ),
        ),
        new GridTile(
          child: new BasicButton(
            text: 'Cozinha',
            onPressed: () => _callApi('/api/luz/cozinha'),
          ),
        ),
        new GridTile(
          child: new BasicButton(
            text: 'Escada Teto',
            onPressed: () => _callApi('/api/luz/escada_teto'),
          ),
        ),
        new GridTile(
          child: new BasicButton(
            text: 'Escada Parede',
            onPressed: () => _callApi('/api/luz/escada_parede'),
          ),
        ),
        new GridTile(
          child: new BasicButton(
            text: 'Frente',
            onPressed: () => _callApi('/api/luz/frente'),
          ),
        ),
        new GridTile(
          child: new BasicButton(
            text: 'Rele Off',
            onPressed: () => _callApi('/api/rele/off'),
            color: Colors.deepOrange,
          ),
        ),
        new GridTile(
          child: new BasicButton(
            text: 'Rele On',
            onPressed: () => _callApi('/api/rele/on'),
            color: Colors.deepOrange,
          ),
        ),
      ],
    );
  }

  void _callApi(String path) async {
    Map result = await MyHttp.get(path);
    if (!result['success']) {
      MyDialogs.alertError(context, '${result['message']} (${result['code']})');
    }
    print(result);
  }

  Future<int> _getTemp() async {
    Map result = await MyHttp.get('/api/temp/interna');
    return (result['data']['t'] as double).ceil();
  }

  void _logout() {
    final storage = new FlutterSecureStorage();
    storage.delete(key: 'server');
    storage.delete(key: 'user');
    storage.delete(key: 'pass');
    Navigator.pop(context);
    Navigator.of(context).pushReplacementNamed(Login.routerName);
  }
}
