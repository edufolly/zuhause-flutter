import 'dart:async';

import 'package:flutter/material.dart';

class CircularWaiting {
  final BuildContext context;
  final String message;

  bool _closeable = false;

  CircularWaiting(this.context, this.message);

  void show() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => new WillPopScope(
            onWillPop: _onWillPop,
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
          ),
    );
  }

  void close() {
    _closeable = true;
    Navigator.of(context).pop();
  }

  Future<bool> _onWillPop() async {
    return _closeable;
  }
}
