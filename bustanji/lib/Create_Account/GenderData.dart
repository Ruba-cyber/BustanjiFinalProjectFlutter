import 'package:devicepreview/CustomDesign/Icons.dart';
import 'package:devicepreview/WidthAndHeighTWidget/Size_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'RadioButton.dart';

class GenderData extends StatelessWidget {
int selctedgender;


  @override
  Widget build(BuildContext context) { @override
  void initState(){}
    return Container(
      margin: EdgeInsets.only(
          left: 5,
          right: 5,
          top: Size1.margin_top,
          bottom: Size1.margin_bottom),
      //padding: EdgeInsets.only(top: 5,bottom: 5),


      child: Container(
width: double.infinity,


        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Row(
            children: <Widget>[
              Container(


                  child: SetIcons(
                    Icons.merge_type,
                    color: Colors.white,
                  ),
                ),

              Container(


                color: Colors.grey[100],
                child: RadioButton(1)),
      ]),
        ),

          ),

      );

  }
}



