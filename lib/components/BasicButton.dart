import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class BasicButton extends StatelessWidget {
  const BasicButton({
    Key key,
    @required this.text,
    @required this.onPressed,
    this.color: const Color(0xFF4152AF),
  })
      : assert(text != null),
        assert(onPressed != null),
        assert(color != null),
        super(key: key);

  final String text;
  final VoidCallback onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: new EdgeInsets.all(6.0),
      child: new RaisedButton(
        padding: new EdgeInsets.all(8.0),
        child: new Text(
          text,
          style: new TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        color: color,
        onPressed: onPressed,
      ),
    );
  }
}
