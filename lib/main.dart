import 'package:flutter/material.dart';
import 'package:zuhause/home.dart';
import 'package:zuhause/login.dart';
import 'package:zuhause/raspi.dart';

class ZuhauseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Zuhause",
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.indigo,
        buttonColor: Colors.indigo,
      ),
      home: new Login(),
      routes: <String, WidgetBuilder>{
        Login.routerName: (BuildContext context) => new Login(),
        Home.routerName: (BuildContext context) => new Home(),
        Raspi.routerName: (BuildContext context) => new Raspi(),
      },
    );
  }
}

void main() => runApp(new ZuhauseApp());
