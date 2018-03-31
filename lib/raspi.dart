import 'package:flutter/material.dart';
import 'package:zuhause/components/MyHttp.dart';

class Raspi extends StatefulWidget {
  Raspi({Key key}) : super(key: key);

  static const String routerName = '/raspi';

  RaspiState createState() => new RaspiState();
}

class RaspiState extends State<Raspi> {
  int proc = 0;
  int usedRam = 0;
  int disk = 0;
  String uptime = '';
  String temp = '';
  String volts = '';

  @override
  void initState() {
    refreshData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Raspi'),
        actions: <Widget>[
          new IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: refreshData,
          ),
        ],
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return new ListView(
      children: <Widget>[
        new ListTile(
          leading: const Icon(Icons.developer_board),
          title: new Text('Processador: ${proc.toString()}%'),
          subtitle: new LinearProgressIndicator(
            value: proc * 0.01,
          ),
        ),
        new ListTile(
          leading: const Icon(Icons.memory),
          title: new Text('RAM: ${usedRam.toString()}%'),
          subtitle: new LinearProgressIndicator(
            value: usedRam * 0.01,
          ),
        ),
        new ListTile(
          leading: const Icon(Icons.sd_storage),
          title: new Text('Disco: ${disk.toString()}%'),
          subtitle: new LinearProgressIndicator(
            value: disk * 0.01,
          ),
        ),
        new ListTile(
          leading: const Icon(Icons.access_time),
          title: const Text('Uptime:'),
          subtitle: new Text(uptime),
        ),
        new ListTile(
          leading: const Icon(Icons.whatshot),
          title: const Text('Temperatura:'),
          subtitle: new Text(temp),
        ),
        new ListTile(
          leading: const Icon(Icons.flash_on),
          title: const Text('Voltagem:'),
          subtitle: new Text(volts),
        ),
      ],
    );
  }

  void refreshData() {
    MyHttp.get('/api/raspi/proc').then((result) {
      if (result['success']) {
        for (Map data in result['data']) {
          if (data['CPU'] == 'all') {
            double idle = double.parse(data['%idle']);
            setState(() => proc = (100.0 - idle).ceil());
            break;
          }
        }
      }
    });

    MyHttp.get('/api/raspi/ram').then((result) {
      if (result['success']) {
        double used = double.parse(result['data'][0]['used']);
        double total = double.parse(result['data'][0]['total']);
        double value = used / total * 100.0;
        setState(() => usedRam = value.ceil());
      }
    });

    MyHttp.get('/api/raspi/disk').then((result) {
      if (result['success']) {
        for (Map data in result['data']) {
          if (data['Mounted on'] == '/') {
            int used = int.parse(data['Used']);
            int available = int.parse(data['Available']);
            double value = used / (used + available) * 100.0;
            setState(() => disk = value.ceil());
            break;
          }
        }
      }
    });

    MyHttp.get('/api/raspi/uptime').then((result) {
      if (result['success']) {
        setState(() => uptime = result['data']['uptime']);
      }
    });

    MyHttp.get('/api/raspi/temp').then((result) {
      if (result['success']) {
        setState(() => temp = result['data']['raw']);
      }
    });

    MyHttp.get('/api/raspi/volts').then((result) {
      if (result['success']) {
        setState(() => volts = result['data']['raw']);
      }
    });
  }
}
