import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:zuhause/components/BasicButton.dart';
import 'package:zuhause/components/MyHttp.dart';
import 'package:zuhause/raspi.dart';
import 'package:zuhause/util/MyDialogs.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  static const String routerName = '/home';

  HomeState createState() => new HomeState();
}

class HomeState extends State<Home> {
  int temp = 0;

  @override
  void initState() {
    MyHttp.get('/api/temp/interna').then((result) {
      if (result['success']) {
        setState(() => temp = (result['data']['t'] as double).ceil());
      }
    });
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
            child: new Text(
              '${temp.toString()}˚C',
              style: new TextStyle(color: Colors.white),
            ),
            onPressed: () {},
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
            onTap: logout,
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return new Center(
      child: new ListView(
        padding: new EdgeInsets.all(6.0),
        children: <Widget>[
          new BasicButton(
            text: 'Suíte',
            onPressed: () => callApi('/api/luz/suite'),
          ),
          new BasicButton(
            text: 'Escritório',
            onPressed: () => callApi('/api/luz/escritorio'),
          ),
          new BasicButton(
            text: 'Sala',
            onPressed: () => callApi('/api/luz/sala'),
          ),
          new BasicButton(
            text: 'Cozinha',
            onPressed: () => callApi('/api/luz/cozinha'),
          ),
          new BasicButton(
            text: 'Escada Teto',
            onPressed: () => callApi('/api/luz/escada_teto'),
          ),
          new BasicButton(
            text: 'Escada Parede',
            onPressed: () => callApi('/api/luz/escada_parede'),
          ),
          new BasicButton(
            text: 'Frente',
            onPressed: () => callApi('/api/luz/frente'),
          ),
          new BasicButton(
            text: 'Rele Off',
            onPressed: () => callApi('/api/rele/off'),
            color: Colors.deepOrange,
          ),
          new BasicButton(
            text: 'Rele On',
            onPressed: () => callApi('/api/rele/on'),
            color: Colors.deepOrange,
          ),
        ],
      ),
    );
  }

  void callApi(String path) async {
    Map result = await MyHttp.get(path);
    if (!result['success']) {
      MyDialogs.alertError(context, '${result['message']} (${result['code']})');
    }
    print(result);
  }

  void logout() {
    final storage = new FlutterSecureStorage();
    storage.delete(key: 'server');
    storage.delete(key: 'user');
    storage.delete(key: 'pass');
  }
}
