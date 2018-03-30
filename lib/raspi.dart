import 'package:flutter/material.dart';
import 'package:zuhause/components/MyHttp.dart';

class Raspi extends StatefulWidget {
  Raspi({Key key}) : super(key: key);

  static const String routerName = '/raspi';

  RaspiState createState() => new RaspiState();
}

class RaspiState extends State<Raspi> {
  int usedRam = 0;

  @override
  void initState() {
    testes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text("Zuhause"),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return new Center(
      child: new Text("Used RAM: ${usedRam.toString()}%"),
    );
  }

  void testes() {
    MyHttp.get("/api/raspi/ram").then((result) {
      print(result);
      double used = double.parse(result['data'][0]['used']);
      double total = double.parse(result['data'][0]['total']);
      double value = used / total * 100;
      setState(() => usedRam = value.ceil());
    });
  }
}
