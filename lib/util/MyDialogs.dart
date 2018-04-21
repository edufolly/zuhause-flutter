import 'package:flutter/material.dart';

class MyDialogs {
  static void alertError(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => new AlertDialog(
            title: new Text('Atenção'),
            content: new Text(message),
            actions: <Widget>[
              new RaisedButton(
                child: new Text(
                  'OK',
                  style: new TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: Theme.of(context).accentColor,
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
    );
  }
}
