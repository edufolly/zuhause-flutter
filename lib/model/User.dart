class User {
  static final User _singleton = new User._internal();

  String server;
  String user;
  String pass;

  factory User() {
    return _singleton;
  }

  User._internal();
}
