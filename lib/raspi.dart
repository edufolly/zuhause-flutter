import 'package:flutter/material.dart';

class Raspi extends StatefulWidget {
  Raspi({Key key}) : super(key: key);

  static const String routerName = '/';

  RaspiState createState() => new RaspiState();
}

class RaspiState extends State<Raspi> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text("Zuhause"),
      ),
      body: new Center(
        child: const Text("Rapi"),
      ),
    );
  }
}


