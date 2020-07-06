

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'AppTranslation/AppTranslation.dart';
import 'CustomDesign/Icons.dart';
import 'CustomerData.dart';
import 'ReservationData.dart';
import 'WidthAndHeighTWidget/Size_layout.dart';



//
class DateSelected extends StatefulWidget {
  String texthint,val;

DateSelected(this.texthint){}

  @override

  _DateSelectedState createState() => _DateSelectedState(texthint);
}

class _DateSelectedState extends State<DateSelected> {
  String selectedate = "",
      texthint = "";TextDirection textDirection;
var lastday=DateTime.now().toString().split('-');bool error=false;

  _DateSelectedState(this.selectedate) {texthint=selectedate;}
  DateTime dateTime1;

  Future<DateTime> date(BuildContext context) async {

    final DateTime dateTime = await

    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1920),
        lastDate: DateTime(DateTime
            .now()
            .year + 2),);

    if (dateTime != null) {
      print(texthint);
      setState(() {
        dateTime1 = dateTime;
      });
      if (texthint == ApplicationLocalizations.of(context).translate("Flight_Date")) {
        print("Flight Date");
        selectedate =
            '' + dateTime1.day.toString() + '/' + dateTime1.month.toString() +
                '/' + dateTime1.year.toString();

        ReservationData.FlightDate =
            dateTime1.year.toString() + '-' + dateTime1.month.toString() +
                '-' +
                dateTime1.day.toString();
      }
      else {
        if (texthint == ApplicationLocalizations.of(context).translate("Birth_date")) {
          selectedate =
              '' + dateTime1.day.toString() + '/' + dateTime1.month.toString() +
                  '/' + dateTime1.year.toString();

          CustomerData.birhdate =
              dateTime1.year.toString() + '-' + dateTime1.month.toString() +
                  '-' +
                  dateTime1.day.toString();
        }
        else {
          if (texthint == ApplicationLocalizations.of(context).translate("Pickup_date")) {
            selectedate =
                '' + dateTime1.day.toString() + '/' +
                    dateTime1.month.toString() +
                    '/' + dateTime1.year.toString();

            ReservationData.pickupdate =
                dateTime1.year.toString() + '-' + dateTime1.month.toString() +
                    '-' +
                    dateTime1.day.toString();
          } else {
            if (texthint == ApplicationLocalizations.of(context).translate("Return_date")) {
              print("Return date");
              selectedate =
                  '' + dateTime1.day.toString() + '/' +
                      dateTime1.month.toString() +
                      '/' + dateTime1.year.toString();

              ReservationData.returndate =
                  dateTime1.year.toString() + '-' + dateTime1.month.toString() +
                      '-' +
                      dateTime1.day.toString();
              print("Reservation Date"+ReservationData.returndate);
            }
            else {
              if (texthint == "customerdate") {
                selectedate =
                    '' + dateTime1.day.toString() + '/' +
                        dateTime1.month.toString() +
                        '/' + dateTime1.year.toString();
                ReservationData.guestdate = dateTime1.year.toString() + '-' +
                    dateTime1.month.toString() +
                    '-' +
                    dateTime1.day.toString();
              }
            }
          }
        }
      }
    }
    else {
     setState(() {
       error=true;
     });
      }

      //print(dateTime1.toString());}}

  }
  @override
  Widget build(BuildContext context) {

    return Container(
        margin: EdgeInsets.only(left: 5,
            right: 5,),


        width: double.infinity,
        height: Size1.height_of_container,
        decoration: new BoxDecoration(
    color: Colors
        .grey[200],
    borderRadius: new BorderRadius
        .all(
    new Radius
        .circular(1)),),
        child: FittedBox(fit: BoxFit.fitWidth,

            child: Row(
              children: <Widget>[

            Container(child:SetIcons(Icons.date_range)),



                Container(

                  child: InkWell(

                    onTap: () {

                      date(context);
                    },

                      child: Container(
                        width:Size1.width_text,
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(selectedate,
                            style: TextStyle(
                                fontSize: Size1.Font_size,
                                color: Colors.grey[600]),
                          ),
                        ),
                      ),
                    ),
                  ),




              ],
            ),
          ));



  }
}