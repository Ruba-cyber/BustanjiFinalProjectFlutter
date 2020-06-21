
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:language/AppTranslation/AppTranslation.dart';
import 'package:language/MyBooking/InnsuranceReservationsData.dart';
import 'package:language/Reservation/ReservationData.dart';


class Innsurance extends StatefulWidget {
  String TotalInnsurance;

  @override
  _InnsuranceState createState() => _InnsuranceState(this.TotalInnsurance);
}

class _InnsuranceState extends State<Innsurance> {
  String TotalInnsurance;

  @override
  Future<List<InnsuranceReservationData>> InnssuranceData2() async {
    List<InnsuranceReservationData> innsurance = [];
    String o = '';
    for (int i = 0; i < ReservationData.inssuracelistname.length; i++) {
      InnsuranceReservationData innsuranceData = new InnsuranceReservationData(
          ReservationData.inssuracelistname[i],
          ReservationData.inssuracelistname[i],
          ReservationData.inssuranceprice[i]);
      innsurance.add(innsuranceData);
    }
    return innsurance;
  }

  _InnsuranceState(this.TotalInnsurance);

  Widget build(BuildContext context) {
    return Container(child: InnsuranceData(),);
  }

  Widget InnsuranceData() {
    if (ReservationData.inssuracelistname.length >= 1) {
      if (MediaQuery
          .of(context)
          .orientation == Orientation.portrait) {
        return Container(
            margin: EdgeInsets.all(5),
            width: MediaQuery
                .of(context)
                .size
                .width,
            child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                color: Colors.white,
                child: Wrap(direction: Axis.vertical, children: <Widget>[
                  Container(
                    width: 300,
                    margin: EdgeInsets.all(5),
                    child: FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            width: 170,
                            padding: EdgeInsets.only(
                                top: 5, bottom: 5, left: 2, right: 2),
                            child: Text(
                            ApplicationLocalizations.of(context).translate(
                                  "Innsurance_Name"),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ),
                          Container(
                            width: 80,
                            padding: EdgeInsets.only(
                                top: 5, bottom: 5, left: 3, right: 3),
                            child: Text(
                              "",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                top: 5, bottom: 5, left: 2, right: 2),
                            child: Text(
                            ApplicationLocalizations.of(context).translate("Price"),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                      child: FutureBuilder(
                          future: InnssuranceData2(),
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> snapshot) {
                            if (snapshot.data.length == 0) {
                              return Center(
                                  child: Text(
                                    "No Innssurance  ",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ));
                            } else {
                              return Container(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width / 1,
                                  child: ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: snapshot.data.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                        width: 200,
                                        margin: EdgeInsets.all(5),
                                        child: FittedBox(
                                          child: Row(children: <Widget>[
                                            Container(
                                                width: 170,
                                                child: Text(
                                                  "" +
                                                      snapshot.data[index]
                                                          .innsurance_en,
                                                  style:
                                                  TextStyle(fontSize: 17),
                                                )),
                                            Container(
                                              width: 50,
                                              padding: EdgeInsets.only(
                                                  top: 5,
                                                  bottom: 5,
                                                  left: 3,
                                                  right: 3),
                                              child: Text(
                                                "",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                              ),
                                            ),
                                            Container(
                                                width: 100,
                                                padding: EdgeInsets.only(
                                                    left: 5,
                                                    right: 5,
                                                    top: 5,
                                                    bottom: 5),
                                                child: Text(
                                                  "" +
                                                      snapshot
                                                          .data[index].price +
                                                      ' ' +
                                                      ReservationData.coin,
                                                  style:
                                                  TextStyle(fontSize: 17),
                                                )),
                                          ]),
                                        ),
                                      );
                                    },
                                  ));
                            }
                          })),
                  Container(
                    margin: EdgeInsets.all(5),
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Text(
                          ApplicationLocalizations.of(context).translate(
                                "Total_Innsurance"),
                            style: TextStyle(fontSize: 17, color: Colors.black),
                          ),
                        ),
                        Container(
                          child: Text(
                            " " + TotalInnsurance.toString(),
                            style: TextStyle(fontSize: 17, color: Colors.black),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    child: Text(
                      "",
                      style: TextStyle(fontSize: 17, color: Colors.red),
                    ),
                  ),
                ])));
      } else {
        return Container(
            margin: EdgeInsets.all(5),
            width: MediaQuery
                .of(context)
                .size
                .width,
            child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                color: Colors.white,
                child: Wrap(direction: Axis.vertical, children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 200,
                          child: Text(
                          ApplicationLocalizations.of(context).translate("Innsurance_Name"),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ),
                        Container(
                          width: 200,
                          padding: EdgeInsets.only(
                              left: 30, right: 30, top: 5, bottom: 5),
                          child: Text(
                            "Price",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      child: FutureBuilder(
                          future: InnssuranceData2(),
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> snapshot) {
                            if (snapshot.data.length == 0) {
                              return Center(
                                  child: Text(
                                    "No Innssurance  ",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ));
                            } else {
                              return Container(
                                  width:
                                  MediaQuery
                                      .of(context)
                                      .size
                                      .width / 1.2,
                                  child: ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: snapshot.data.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                        child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                  width: 200,
                                                  padding: EdgeInsets.only(
                                                      left: 10,
                                                      right: 10,
                                                      top: 5,
                                                      bottom: 5),
                                                  child: Text(
                                                    "" +
                                                        snapshot.data[index]
                                                            .innsurance_en,
                                                    style:
                                                    TextStyle(fontSize: 17),
                                                  )),
                                              Container(
                                                  width: 200,
                                                  padding: EdgeInsets.only(
                                                      left: 30,
                                                      right: 30,
                                                      top: 5,
                                                      bottom: 5),
                                                  child: Text(
                                                    "" +
                                                        snapshot
                                                            .data[index].price,
                                                    style:
                                                    TextStyle(fontSize: 17),
                                                  )),
                                            ]),
                                      );
                                    },
                                  ));
                            }
                          })),
                  Container(
                    margin: EdgeInsets.all(5),
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Text(
                          ApplicationLocalizations.of(context).translate("Price"),
                            style: TextStyle(fontSize: 17, color: Colors.black),
                          ),
                        ),
                        Container(
                          child: Text(
                            " " + TotalInnsurance.toString(),
                            style: TextStyle(fontSize: 17, color: Colors.black),
                          ),
                        )
                      ],
                    ),
                  ),
                ])));
      }
    }
  }
}