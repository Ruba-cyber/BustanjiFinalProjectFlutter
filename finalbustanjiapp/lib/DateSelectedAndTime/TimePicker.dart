
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:language/AppTranslation/AppTranslation.dart';
import 'package:language/CustomDesign/Icons.dart';
import 'package:language/Reservation/ReservationData.dart';

DateTime dateTime;
class TimePickerDialog extends StatefulWidget {
  @override
  String txthint;
  TimePickerDialog(this.txthint){}
  _TimePickerDialogState createState() => _TimePickerDialogState(txthint);
}

class _TimePickerDialogState extends State<TimePickerDialog> {

  String txttime;String selecttime;TextDirection textDirections;bool error=false;
  _TimePickerDialogState(this.selecttime){txttime=selecttime;}

  Future<TimeOfDay> selecteddate(BuildContext context) async {

    final now = DateTime.now();
    final  dateTime= await
    showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: now.hour, minute: now.minute),);

    if(dateTime!=null){
      setState(() {
        print(selecttime);
        txttime=''+dateTime.format(context);
        if(txttime.contains("ص")){setState(() {
          txttime=dateTime.format(context)+'am';
        });}
        else{if(txttime.contains("م")){setState(() {
          txttime=dateTime.format(context)+'pm';

        });}}
        if(selecttime ==    ApplicationLocalizations.of(context).translate("Pickup_time")){

          ReservationData.pickuptime=dateTime.format(context);
        }
        else{
          if(selecttime ==    ApplicationLocalizations.of(context).translate("Return_Time")){

            ReservationData.returntime=txttime;
          }
          else{if(selecttime ==    ApplicationLocalizations.of(context).translate("Flight_Time")){

            print("h");
            ReservationData.Flightime=txttime;
          }}

          // txttime=''+dateTime.hour.toString()+':'+dateTime.minute.toString();
        };
      });



    }
    else{setState(() {
      error=true;
    });}}

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.only(top: 5,bottom: 5,right: 5,left: 5),
      child: Container(

        margin: EdgeInsets.only(top:5,bottom:5),
        decoration: new BoxDecoration(color: Colors.grey[200],
          borderRadius: new BorderRadius.all(
              new Radius.circular(10.0)),),
        child: Row(
          children: <Widget>[

            Container(child: SetIcons(Icons.access_alarm)),




            Container(

              child: InkWell(
                onTap: () {
                  selecteddate(context);
                },
                child: Padding(
                  padding: EdgeInsets.only(top: 10,bottom: 10,left: 5,right:5),
                  child: Text(txttime,
                    style: TextStyle(fontSize:17,color:Colors.grey[600]),
                  ),
                ),
              ),
            ),
            Container(width: 20,
              child: Visibility(
                  visible: error,
                  child: Icon(Icons.error,
                    color: Colors.red,))
              ,)
          ],
        ),
      ),
    );
  }
}



