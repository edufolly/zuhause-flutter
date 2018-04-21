import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart' as crypto;

class User {
  static final User _singleton = new User._internal();

  String server;
  String user;
  String pass;

  factory User() {
    return _singleton;
  }

  User._internal();

  String getGravatarUrl() {
    var content = new Utf8Encoder().convert(user.trim().toLowerCase());
    var hash = crypto.md5.convert(content);
    return 'https://www.gravatar.com/avatar/' +
        hex.encode(hash.bytes) +
        '.jpg?s=200&d=mm';
  }
}
