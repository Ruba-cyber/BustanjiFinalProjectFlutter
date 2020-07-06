import 'package:devicepreview/AppTranslation/AppTranslation.dart';
import 'package:devicepreview/WidthAndHeighTWidget/Size_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../ReservationData.dart';

class AirportLocationMyReservation extends StatefulWidget {
  bool Airport;
  String FlightDate, FlightNumber, Flighttime;

  AirportLocationMyReservation(
      this.Airport, this.FlightDate, this.FlightNumber, this.Flighttime);

  @override
  _AirportState createState() => _AirportState(
      this.Airport, this.FlightDate, this.FlightNumber, this.Flighttime);
}

class _AirportState extends State<AirportLocationMyReservation> {
  @override
  bool Airport1;
  String FlightDate, FlightNumber, Flighttime;

  _AirportState(
      this.Airport1, this.FlightDate, this.FlightNumber, this.Flighttime);

  Widget build(BuildContext context) {
    return Container(
      child: Airport(),
    );
  }

  Widget Airport() {
    if (Airport1 == true) {
      return Container(
          child: Column(children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          child: FittedBox(
            child: Wrap(direction: Axis.horizontal, children: <Widget>[
              Container(
                width: Size1.width_text,
                padding: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
                child: Text(
                  ApplicationLocalizations.of(context)
                          .translate("Flight_Date") +
                      " &&" +
                      ApplicationLocalizations.of(context)
                          .translate("Flight_Time"),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: Size1.Font_size,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                width:Size1.width_text,
                padding: EdgeInsets.only(left: 2, right: 2, top: 5, bottom: 5),
                child: Text(
                  "" + FlightDate + "," + FlightNumber,
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 15,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ]),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          child: FittedBox(
            child: Wrap(direction: Axis.horizontal, children: <Widget>[
              Container(
                width:Size1.width_text,
                padding: EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
                child: Text(
                  ApplicationLocalizations.of(context)
                      .translate("Flight_Number"),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: Size1.Font_size,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                width:Size1.width_text,
                padding: EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
                child: Text(
                  '' + FlightNumber,
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
  }
}
