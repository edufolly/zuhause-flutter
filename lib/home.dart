import 'package:flutter/material.dart';
import 'package:zuhause/raspi.dart';


class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  static const String routerName = '/';

  HomeState createState() => new HomeState();
}

class HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: _buildDrawer(context),
      appBar: new AppBar(
        title: const Text("Zuhause"),
      ),
      body: new Center(
        child: const Text("Home"),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return new Drawer(
      child: new ListView(
        children: <Widget>[
          new ListTile(
            leading: new Icon(Icons.home),
            title: new Text("Home"),
            selected: true,
          ),
          new ListTile(
            leading: new Icon(Icons.developer_board),
            title: new Text("Raspi"),
            onTap: _raspiTap(),
          )
        ],
      ),
    );
  }

  _raspiTap() {
    Navigator.popAndPushNamed(context, Raspi.routerName);
  }

}