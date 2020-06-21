
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:language/AppTranslation/AppTranslation.dart';
import 'package:language/Urls/BustanjiUrl.dart';

import 'InnsuranceReservationsData.dart';
import 'package:http/http.dart' as http;

class MyInnsurance extends StatefulWidget {
  String resid;
  @override
  MyInnsurance(this.resid);
  _MyInnsuranceState createState() => _MyInnsuranceState(this.resid);
}


class _MyInnsuranceState extends State<MyInnsurance> {
  String resid;double sumInnsurance;bool visinnsurance;
  _MyInnsuranceState(this.resid);
  Future<List<InnsuranceReservationData>> Innsurance() async {
    print("Innsurance");
    List<InnsuranceReservationData> innsurance = [];

    var url = BustanjiUrls.getinssurance;

    http.Response response =
    await http.post(url, body: {'reservation_id': resid});
    print(response.body);
    innsurance.clear();

    var Offers = json.decode(response.body);
    sumInnsurance = 0.0;
    for (var u in Offers) {
      InnsuranceReservationData in1 = InnsuranceReservationData(
          u["name_english"], u["name_arabic"], u["insurance_price"]);
      innsurance.add(in1);

      try {

        double price = double.parse(u["insurance_price"]);
        setState(() {
          sumInnsurance = sumInnsurance + (price);
        });

      } catch (Ex) {}
    }
    if(innsurance.length>=1){setState(() {
      visinnsurance=true;
    });}
    else{setState(() {
      visinnsurance==false;
    });}
    return innsurance;
  }
  @override
  Widget build(BuildContext context) {


  }

  Widget InnsuranceData() {
    if (visinnsurance==true) {
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
                          future: Innsurance(),
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
                                                      ' ',
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
                            " " + sumInnsurance.toString(),
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
                          future: Innsurance(),
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
                            " " + sumInnsurance.toString(),
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

