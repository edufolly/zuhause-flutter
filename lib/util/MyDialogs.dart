import 'package:flutter/material.dart';

class MyDialogs {
  static void circularWating(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      child: new Dialog(
        child: new Padding(
          padding: const EdgeInsets.all(30.0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new CircularProgressIndicator(),
              new Padding(
                padding: new EdgeInsets.only(top: 12.0),
                child: new Text(
                  message,
                  style: new TextStyle(
                    fontSize: 20.0,
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void alertError(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      child: new AlertDialog(
        title: new Text('Atenção'),
        content: new Text(message),
        actions: <Widget>[
          new RaisedButton(
            child: new Text(
              'OK',
              style: new TextStyle(
                color: Colors.black,
              ),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
