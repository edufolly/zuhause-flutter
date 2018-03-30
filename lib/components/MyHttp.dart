import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:zuhause/model/User.dart';

class MyHttp {
  static Future<Map> get(String path) async {
    User user = new User();

    if (!user.server.endsWith('/')) {
      user.server += '/';
    }

    if (path[0] == '/') {
      path = path.substring(1);
    }

    String url = user.server + path;

    HttpClient httpClient = new HttpClient();

    var credentials = new HttpClientBasicCredentials(user.user, user.pass);

    httpClient.addCredentials(Uri.parse(url), "basic", credentials);

    Map result;

    try {
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      if (response.statusCode == HttpStatus.OK) {
        var body = await response.transform(UTF8.decoder).join();
        result = {
          'success': true,
          'code': response.statusCode,
          'message': 'sucesso',
          'data': JSON.decode(body)
        };
      } else {
        var body = await response.transform(UTF8.decoder).join();
        result = {
          'success': false,
          'code': response.statusCode,
          'message': body,
          'data': {}
        };
      }
    } catch (exception) {
      print(exception);
      result = {
        'success': false,
        'code': 000,
        'message': exception,
        'data': {}
      };
    }

    return result;
  }
}
