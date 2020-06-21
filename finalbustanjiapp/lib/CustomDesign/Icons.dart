
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SetIcons extends StatefulWidget {
  IconData icon;
  SetIcons(this.icon, {Color color, int size});
  @override
  _IconState createState() => _IconState(this.icon);
}

class _IconState extends State<SetIcons> {
  IconData icon;
  _IconState(this.icon);
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: new BoxDecoration(
      borderRadius: new BorderRadius.all(
          new Radius.circular(1.0)),
      color: Colors.indigo[700],
    ),
        padding: EdgeInsets.all(10),
        child:Icon(icon,
          color: Colors.white,
          size:30,
        ));
  }
}