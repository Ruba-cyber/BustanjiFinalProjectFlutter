

import 'package:devicepreview/WidthAndHeighTWidget/Size_layout.dart';
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
    return  Container(
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
          width:   double.infinity,

          height: Size1.height_of_curve,
          child: Column(children: <Widget>[
            Center(
              child: Container(width: Size1.title,
                padding: EdgeInsets.all(10),
                child: FittedBox(
                  child: Icon(icon,
                    size: Size1.size_icon,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Container(width: Size1.title,
              padding: EdgeInsets.only(top: 10),
              child: FittedBox(
                child: Text(text,

                  style: TextStyle(
                      fontSize: Size1.Font_size, color: Colors.white),
                ),
              ),
            )
          ]));

  }
}
