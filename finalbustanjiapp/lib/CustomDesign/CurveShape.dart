
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CurveShape extends StatefulWidget {
  IconData icon;String text;
  CurveShape(this.icon,this.text);
  @override
  _CurveShapeState createState() => _CurveShapeState(this.icon,this.text);
}

class _CurveShapeState extends State<CurveShape> {
  IconData icon;String text;
  @override
  _CurveShapeState(this.icon,this.text);
  Widget build(BuildContext context) {
    return Container(
        decoration: (BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF1A237E),
                  Color(0xFF283593)
                ]),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(80)))),
        width: MediaQuery.of(context).size.width,
        height: 150,
        child: Column(children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            child: Icon(icon,
              size: 60,
              color: Colors.white,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Text(text,

              style: TextStyle(
                  fontSize: 20, color: Colors.white),
            ),
          )
        ]));
  }}