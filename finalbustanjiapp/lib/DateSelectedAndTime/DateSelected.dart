
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:language/AppTranslation/AppTranslation.dart';
import 'package:language/CustomDesign/Icons.dart';
import 'package:language/CustomerInfo/CustomerData.dart';
import 'package:language/Reservation/ReservationData.dart';

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
    final DateTime dateTime = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1920),
        lastDate: DateTime(DateTime
            .now()
            .year + 2));

    if (dateTime != null) {
      print(texthint);
      setState(() {
        dateTime1 = dateTime;
      });
      if (texthint ==   ApplicationLocalizations.of(context).translate("Flight_Date")) {
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
        if (texthint ==   ApplicationLocalizations.of(context).translate("Birth_date")) {
          selectedate =
              '' + dateTime1.day.toString() + '/' + dateTime1.month.toString() +
                  '/' + dateTime1.year.toString();

          CustomerData.birhdate =
              dateTime1.year.toString() + '-' + dateTime1.month.toString() +
                  '-' +
                  dateTime1.day.toString();
        }
        else {
          if (texthint ==   ApplicationLocalizations.of(context).translate("Pickup_date")) {
            selectedate =
                '' + dateTime1.day.toString() + '/' +
                    dateTime1.month.toString() +
                    '/' + dateTime1.year.toString();

            ReservationData.pickupdate =
                dateTime1.year.toString() + '-' + dateTime1.month.toString() +
                    '-' +
                    dateTime1.day.toString();
          } else {
            if (texthint ==   ApplicationLocalizations.of(context).translate("Return_date")) {
              selectedate =
                  '' + dateTime1.day.toString() + '/' +
                      dateTime1.month.toString() +
                      '/' + dateTime1.year.toString();

              ReservationData.returndate =
                  dateTime1.year.toString() + '-' + dateTime1.month.toString() +
                      '-' +
                      dateTime1.day.toString();
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

    return Container(margin: EdgeInsets.all(5),  decoration: new BoxDecoration(
      color: Colors
          .grey[200],
      borderRadius: new BorderRadius
          .all(
          new Radius
              .circular(1)),),
        child: Row(textDirection: textDirection,
          children: <Widget>[

            Container(child:SetIcons(Icons.date_range)),



            Container(

              child: InkWell(

                onTap: () {
                  date(context);
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 10,left: 5,right: 5,bottom: 10),
                  child: Text(selectedate,textDirection: textDirection,
                    style: TextStyle(fontSize: 17, color: Colors.grey[600]),
                  ),
                ),
              ),
            ),


          ],
        ));


  }
}