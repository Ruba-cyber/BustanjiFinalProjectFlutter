
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:language/Width/WidthAndHeight.dart';

class CurveShape extends StatefulWidget {
  IconData icon;String text;
  CurveShape(this.icon,this.text);
  @override
  _CurveShapeState createState() => _CurveShapeState(this.icon,this.text);
}

class _CurveShapeState extends State<CurveShape> {
  IconData icon;String text;
  AppConfig _ac;
  //provides localised strings
double height,width;
  @override
  _CurveShapeState(this.icon,this.text);
  Widget build(BuildContext context) {
    _ac = AppConfig(context);
    if( MediaQuery
        .of(context)
        .orientation == Orientation.portrait){setState(() {
          height=20;width=100;
        });}
        else{setState(() {
          width=20;height=100;
        });}
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

        child: Column(children: <Widget>[
          Container(//margin: EdgeInsets.all(_ac.rH(2)),
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