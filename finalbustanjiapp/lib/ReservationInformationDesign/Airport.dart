
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:language/AppTranslation/AppTranslation.dart';
import 'package:language/Reservation/ReservationData.dart';

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
            Container(width: 370,
              child: FittedBox(
                child: Row(children: <Widget>[
                  Container(width: 200,
                    padding: EdgeInsets.only(
                        left: 5, right: 5, top: 5, bottom: 5),
                    child: Text(
                           ApplicationLocalizations.of(context).translate("Flight_date")+" &&"+
                               ApplicationLocalizations.of(context).translate("Flight_Time"),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    width: 200,
                    padding: EdgeInsets.only(
                        left: 2, right: 2, top: 5, bottom: 5),
                    child: Text(
                      "" + ReservationData.FlightDate + ","
                          +
                          ReservationData.Flightime,
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 15,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ]),
              ),
            ),
            Container(width: MediaQuery.of(context).size.width,
              child: FittedBox(
                child: Row(children: <Widget>[
                  Container(width: MediaQuery.of(context).size.width/1.5,
                    padding: EdgeInsets.only(
                        top: 5, bottom: 5, left: 5, right: 5),
                    child: Text(
                         ApplicationLocalizations.of(context).translate("Flight_Number"),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width/1.5,
                    padding: EdgeInsets.only(
                        top: 5, bottom: 5, left: 5, right: 5),
                    child: Text(
                      '' + ReservationData.NumberFlight,
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 15,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ]),
              ),
            ),
          ]));
    }
  }}