


import 'package:devicepreview/AppTranslation/AppTranslation.dart';
import 'package:devicepreview/WidthAndHeighTWidget/Size_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


import '../CustomerData.dart';


class RadioButton extends StatefulWidget {
  @override
int value;
  RadioButton(this.value);
  RadioButtonWidget createState() => RadioButtonWidget(value);

}
class RadioButtonWidget extends State<RadioButton> {
bool radioItem=true;int group=1;
int  value;String gender="Male";double width;


RadioButtonWidget(this.value);


  @override
    Widget build(BuildContext context) {

    CustomerData.gender=gender;
      return
          FittedBox(fit: BoxFit.fitWidth,
            child: Container(



    decoration: new BoxDecoration(color: Colors.grey[200],
    borderRadius: new BorderRadius.all(
    new Radius.circular(10.0)),),

            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Row(

                children: <Widget>[

                   Radio( value:1,
                      groupValue: group,onChanged: (T)
                      {setState(() {
                        print(T);
                       group=T;
                     gender="Male";
                        CustomerData.gender=gender;



                  }



                  );}),
    Container( width: Size1.width_ofgender,
        margin:EdgeInsets.only(left:5,right: 5),
        child: Text(
      ApplicationLocalizations.of(context).translate("Male"),
              style: TextStyle(fontSize: Size1.Font_size,color:Colors.grey[700]),)),



                  Radio( value:2,
                      groupValue: group,onChanged: (T)
                      {setState(() {
                        print(T);
                        group=T;
                      gender="Female";
                        CustomerData.gender=gender;
                        });



                      }),Container(width: Size1.width_ofgender,
                      margin:EdgeInsets.only(right: 5,left: 5),
                      child: Text(  ApplicationLocalizations.of(context).translate
                        ("Female"),
                style: TextStyle(fontSize: Size1.Font_size,color:Colors.grey[700]),)),


    ]),
            ),
        ),
          )
      ;}






  }


