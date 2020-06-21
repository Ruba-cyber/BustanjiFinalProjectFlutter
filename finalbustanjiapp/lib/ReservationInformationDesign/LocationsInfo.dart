import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:language/AppTranslation/AppTranslation.dart';
import 'package:language/Reservation/ReservationData.dart';

import '../MakeBooking.dart';


class LocationsInfo extends StatefulWidget {
  @override
  _LocationsInfoState createState() => _LocationsInfoState();
}

class _LocationsInfoState extends State<LocationsInfo> {
  @override
  Widget build(BuildContext context) {


      return Container(
          width: MediaQuery
              .of(context)
              .size
              .width,
          margin: EdgeInsets.only(top: 5, bottom: 5, left: 2, right: 2),
          child: Material(
              elevation: 5.0,
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              color: Colors.white,
              child: Wrap(direction: Axis.vertical, children: <Widget>[
                Container(
                    child: Column(children: <Widget>[
                      Container(width: 370,
                          child: FittedBox(
                            child: Wrap(direction: Axis.horizontal,
                              children: <Widget>[
                                Container(width: 200,
                                  padding: EdgeInsets.only(
                                      left: 2, right: 2, bottom: 5, top: 5),
                                  child: Text(
                                      ApplicationLocalizations.of(context).translate("PickupLoc"),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  width: 200,
                                  padding: EdgeInsets.only(
                                      left: 2, right: 2, bottom: 5, top: 5),
                                  child: Text(
                                    " " + ReservationData.pickuploc,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,

                                    ),
                                  ),
                                )
                              ],
                            ),
                          )),
                      Container(width: 370,
                          child: FittedBox(
                            child: Row(children: <Widget>[
                              Container(width: 200,
                                padding:
                                EdgeInsets.only(
                                    left: 2, right: 2, bottom: 5, top: 5),
                                child: Text(
                                    ApplicationLocalizations.of(context).translate("returnloc"),
                                  style: TextStyle(fontWeight: FontWeight.bold,
                                      fontSize: 16, color: Colors.black),
                                ),
                              ),
                              Container(
                                width: 200,
                                padding:
                                EdgeInsets.only(
                                    left: 2, right: 2, bottom: 5, top: 5),
                                child: Text(
                                  " " + ReservationData.returnlocation,
                                  style: TextStyle(

                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              )
                            ]),
                          )),
                      Container(width: 370,
                          child: FittedBox(
                            child: Row(children: <Widget>[
                              Container(width: 300,
                                padding:
                                EdgeInsets.only(
                                    left: 2, right: 2, bottom: 5, top: 5),
                                child: FittedBox(
                                  child: Container(width: 280,
                                    child: Text(    ApplicationLocalizations.of(context).translate("Pickup_date")+" && "+
                                          ApplicationLocalizations.of(context).translate("Pickup_time") +":",

                                      style: TextStyle(color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 200,
                                padding:
                                EdgeInsets.only(
                                    left: 2, right: 2, bottom: 5, top: 5),
                                child: Text(
                                  "" +
                                      ReservationData.pickupdate + "," +
                                      ReservationData.pickuptime,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,

                                  ),
                                ),
                              )
                            ]),
                          )),
                      Container(width: 370,
                          child: FittedBox(

                            child: Row(children: <Widget>[
                              Container(
                                padding:
                                EdgeInsets.only(
                                    left: 2, right: 2, top: 5, bottom: 5),
                                child: FittedBox(
                                  child: Container(width: MediaQuery.of(context).size.width/1.4,
                                    child: Text(   ApplicationLocalizations.of(context).translate("Return_date")+" && "+
                                          ApplicationLocalizations.of(context).translate("Return_Time") +" :",
                                      style: TextStyle(
                                          fontSize: 17, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 200,
                                padding:
                                EdgeInsets.only(
                                    left: 2, right: 2, bottom: 5, top: 5),
                                child: Text(
                                  "" +
                                      ReservationData.returndate + "," +
                                      ReservationData.returntime,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black87,
                                  ),
                                ),
                              )
                            ]),
                          )),

                       Container(
                        child: FlatButton(
                          onPressed: () {
                            ReservationData.caryear =    ApplicationLocalizations.of(context).translate("All") ;
                            ReservationData.carcategory =    ApplicationLocalizations.of(context).translate("All") ;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        MakeBooking('No offer')));
//                                    if (CustomerData.CustomerType == 'Guest') {
//                                      AlertDialogShow(context);
//                                    } else {
//                                      if (offer == 'Offers') {
//                                        Navigator.pushReplacement(
//                                            context,
//                                            MaterialPageRoute(
//                                                builder: (context) => new MakeBooking(offer)),
//                                            result: (Route<dynamic> route())C => false);
                            // }
                            //      }
                          },
                          child: Text(
                                ApplicationLocalizations.of(context).translate("Change"),

                            style: TextStyle(
                                fontSize: 20, color: Colors.indigo[900]),
                          ),
                        ),
                      ),
                    ])),
              ])));
    }

  }

