
import 'package:devicepreview/AppTranslation/AppTranslation.dart';
import 'package:devicepreview/WidthAndHeighTWidget/Size_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../ReservationData.dart';

class Airport extends StatefulWidget {
  @override
  _AirportState createState() => _AirportState();
}

class _AirportState extends State<Airport> {

  @override

  Widget build(BuildContext context) {
    return Container(child: Airport(),);
  }
  Widget Airport() {
    if (ReservationData.Airport == true ||
        ReservationData.ReturnLocationAirport == true) {
      return Container(
          child: Column(children: <Widget>[
            Container(width: MediaQuery.of(context).size.width/4,
              margin: EdgeInsets.only(top: 5,bottom: 5,left: 5,right: 5),
              child: FittedBox(fit: BoxFit.fitWidth,
                child: Row(
                    children: <Widget>[
                  Container(width: Size1.width_of_data_text,

                    child: Text(
                        ApplicationLocalizations.of(context).translate("Flight_Date")+"  &&"+
                            ApplicationLocalizations.of(context).translate("Flight_Time"),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: Size1.Font_size,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    width: Size1.width_of_data_text,
                    padding: EdgeInsets.only(
                        left: 2, right: 2, top: 5, bottom: 5),
                    child: Text(
                      "" + ReservationData.FlightDate + ","
                          +
                          ReservationData.Flightime,
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: Size1.Font_size,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ]),
              ),
            ),
            Container(width:MediaQuery.of(context).size.width /4,
              child: FittedBox(
                child: Wrap(direction: Axis.horizontal,
                    children: <Widget>[
                  Container(width: Size1.width_of_data_text,
                    padding: EdgeInsets.only(
                        top: 5, bottom: 5, left: 5, right: 5),
                    child: Text(
                      ApplicationLocalizations.of(context).translate("Flight_Number"),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: Size1.Font_size,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                   width:Size1.width_of_data2,

                    child: Text(
                      '' + ReservationData.NumberFlight,
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: Size1.Font_size,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ]),
              ),
            ),
          ]));
    }
  }}