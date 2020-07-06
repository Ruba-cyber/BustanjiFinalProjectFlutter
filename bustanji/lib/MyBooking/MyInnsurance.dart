
import 'dart:convert';

import 'package:devicepreview/AppTranslation/AppTranslation.dart';
import 'package:devicepreview/ReservationInformationDesign/ReservationInfo.dart';
import 'package:devicepreview/WidthAndHeighTWidget/Size_layout.dart';
import 'package:flutter/material.dart';

import '../CustomerData.dart';
import '../Urls.dart';
import 'InnsuranceReservationsData.dart';
import 'package:http/http.dart' as http;

class MyInnsurance extends StatefulWidget {
  String resid,status;
  @override
  MyInnsurance(this.resid,this.status);
  _MyInnsuranceState createState() => _MyInnsuranceState(this.resid,this.status);
}


class _MyInnsuranceState extends State<MyInnsurance> {
  String resid = '',status;
  double sumInnsurance = 0;


  _MyInnsuranceState(this.resid,this.status);

  Future<List<InnsuranceReservationData>> Innsurance() async {
    print("Innsurance");
    print("Innsurancd" + resid);
    List<InnsuranceReservationData> innsurance = [];

    var url = Urls.getinssurance;

    http.Response response =
    await http.post(url, body: {'reservation_id': resid});
    print(response.body);
    innsurance.clear();

    var Offers = json.decode(response.body);
    //print(""+Offers);

    for (var u in Offers) {
      if (CustomerData.Language == "Arabic") {
        InnsuranceReservationData in1 = InnsuranceReservationData(
            u["name_arabic"], u["insurance_price"]);
        innsurance.add(in1);
      }
      else {
        InnsuranceReservationData in1 = InnsuranceReservationData(
            u["name_english"], u["insurance_price"]);
        innsurance.add(in1);
      }
  // setState());
    }
    return innsurance;
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: InnsuranceDATA(),);
  }

  Widget InnsuranceDATA() {
    if (status=="1") {

      return Container(
          margin: EdgeInsets.all(5),
          width:double.infinity,
          child: Material(
              elevation: 5.0,
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              color: Colors.white,
              child: Wrap(direction: Axis.vertical, children: <Widget>[
                Container(
                  width:MediaQuery.of(context).size.width,
                  margin: EdgeInsets.all(5),
                  child: FittedBox(fit: BoxFit.fitWidth,
                    child: SafeArea(
                      child: Wrap(direction: Axis.horizontal,

                        children: <Widget>[
                          Container(
                            width: Size1.Option_Name_width,
                            padding: EdgeInsets.only(
                                top: 5, bottom: 5, left: 2, right: 2),
                            child: Text(
                              ApplicationLocalizations.of(context).translate("Innsurance_Name"),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: Size1.Font_size),
                            ),
                          ),

                          Container(
                            width: Size1.Option_Price_width,
                            padding: EdgeInsets.only(
                                top: 5, bottom: 5, left: 4, right: 4),
                            child: Text(
                              ApplicationLocalizations.of(context).translate("Price"),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: Size1.Font_size),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 5, bottom: 5),
                    child: FutureBuilder(
                        future: Innsurance(),
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.data == null) {
                            return Center(
                              child: Container(
                                child: Center(
                                  child: Text(
                                    "  No Option Data ",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Container(
                                width: MediaQuery.of(context).size.width,
                                child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin: EdgeInsets.all(5),
                                      child: FittedBox(
                                        child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      left: 4, right: 4),
                                                  width:Size1.Option_Name_width,

                                                  child: Text(
                                                    "" +
                                                        snapshot.data[index]
                                                            .innsurance_en,
                                                    style: TextStyle(
                                                        fontSize: Size1.Font_size),
                                                  )),


                                              Container(
                                                  width: Size1.Option_Price_width,
                                                  padding: EdgeInsets.only(
                                                    left: 2,
                                                    right: 2,
                                                    top: 5,
                                                  ),
                                                  child: Text(
                                                    "" +
                                                        snapshot.data[index]
                                                            .price,
                                                    style: TextStyle(
                                                        fontSize: Size1.Font_size),
                                                  )),
                                            ]),
                                      ),
                                    );
                                  },
                                ));
                          }
                        })),

        Container(width: MediaQuery.of(context).size.width/2,
                    child: ResrevationInfo(
                        ApplicationLocalizations.of(context).translate("Total_Innsurance"),
                        sumInnsurance.toString()),
                  ),
              ])));
}}}