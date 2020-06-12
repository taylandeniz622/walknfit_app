import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final Text text;
  final Color color;
  final VoidCallback onPressed;
  final double radius;

  const CommonButton(
      {Key key, this.text, this.color, this.onPressed, this.radius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return RaisedButton(
        onPressed: onPressed,
        child: text,
        color: color,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(radius))),
      );
    } else {
      return CupertinoButton(
        onPressed: onPressed,
        child: text,
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(radius)),
      );
    }
  }
}
