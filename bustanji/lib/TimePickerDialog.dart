
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


import 'AppTranslation/AppTranslation.dart';

import 'CustomDesign/Icons.dart';
import 'ReservationData.dart';
import 'WidthAndHeighTWidget/Size_layout.dart';

DateTime dateTime;
 class TimePickerDialog extends StatefulWidget {
  @override
  String txthint;int hour=0;
  TimePickerDialog(this.txthint){}
  _TimePickerDialogState createState() => _TimePickerDialogState(txthint);
}

class _TimePickerDialogState extends State<TimePickerDialog> {
int hour;
  String txttime;String selecttime;TextDirection textDirections;bool error=false;
  _TimePickerDialogState(this.selecttime){txttime=selecttime;}



  Future<TimeOfDay> selecteddate(BuildContext context) async {
    final now = DateTime.now();
    final  dateTime= await
    showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: now.hour, minute: now.minute),
    );

    if(dateTime!=null){
      setState(() {

        print(selecttime);
        txttime=''+dateTime.format(context);
        if(txttime.contains('ص')){setState(() {
          SetTime(dateTime.hour);
          txttime =
              hour.toString() + ':' + dateTime.minute.toString()+ ' AM';
          });
       }
        else {
          if (txttime.contains('م')) {
            setState(() {
              SetTime(dateTime.hour);
              txttime =
                 hour.toString() + ':' + dateTime.minute.toString()+ ' PM';

            });
          }
        }
        if(selecttime ==  ApplicationLocalizations.of(context).translate("Pickup_time")){
          ReservationData.pickuptime=dateTime.format(context);
        }

        else{
          if(selecttime ==  ApplicationLocalizations.of(context).translate("Return_Time")){

            ReservationData.returntime=txttime;
          }
          else{if(selecttime ==  ApplicationLocalizations.of(context).translate("Flight_Time")){

            ReservationData.Flightime=txttime;
          }}

         // txttime=''+dateTime.hour.toString()+':'+dateTime.minute.toString();
        };
      });



    }
  else{setState(() {
    error=true;
  });}}
void SetTime(int h){
    print("hour"+h.toString());
switch(h){
  case(13):setState(() {
    hour=1;
  });break;
  case(14):setState(() {
    hour=2;

  });break;
  case(15):setState(() {
    hour=3;
  });break;
  case(16):setState(() {
    hour=4;

  });break;
  case(16):setState(() {
    hour=5;
  });break;
  case(17):setState(() {
    hour=6;

  });break;
  case(18):setState(() {
    hour=7;
  });break;
  case(19):setState(() {
    hour=8;

  });break;
  case(20):setState(() {
    hour=9;
  });break;
  case(21):setState(() {
    hour=10;

  });break;
  case(22):setState(() {
    hour=11;
  });break;
  case(23):setState(() {
    hour=12;

  });break;
  default:
    hour=h;

}
}
    @override
  Widget build(BuildContext context) {
      return Container(
        margin: EdgeInsets.only(right: 5,left: 5),
        child: Container(
width: double.infinity,

      decoration: new BoxDecoration(color: Colors.grey[200],
      borderRadius: new BorderRadius.all(
      new Radius.circular(10.0)),),
          child: FittedBox(fit: BoxFit.fitWidth,
            child: Row(
              children: <Widget>[

                Container(child: SetIcons(Icons.access_alarm)),




                Container(
width: Size1.width_text,
                  child: InkWell(
                    onTap: () {
                      selecteddate(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: 10,bottom: 10,left: 7,right:7),
                      child: Text(txttime,
                        style: TextStyle(letterSpacing:2,fontSize:Size1.Font_size,color:Colors.grey[600]),
                      ),
                    ),
                  ),
                ),
//              Container(width: 20,
//                child: Visibility(
//                    visible: error,
//                    child: Icon(Icons.error,
//                      color: Colors.red,))

              ],
            ),
          ),
        ),
      );
    }
  }






