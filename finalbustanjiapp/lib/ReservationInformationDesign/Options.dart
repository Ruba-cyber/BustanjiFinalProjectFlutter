
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:language/AppTranslation/AppTranslation.dart';
import 'package:language/MyBooking/OptionsReservation.dart';
import 'package:language/OffersData/OfferDataAvaliable.dart';
import 'package:language/Reservation/ReservationData.dart';



class Options  extends StatefulWidget {
  String TotalOption;
  Options(this.TotalOption);
  @override

  _State createState() => _State(this.TotalOption);
}

class _State extends State<Options> {
  double sum = 0,
      tax,
      TotalDays = 0,
      TotalTaxAfterTax,
      TotalInssurance = 0,
      carprice;
  String offername, Totaloption ;
  _State(this.Totaloption);
  String locationTxt = "0", optionofferstate = 'No Option Offer ';
  @override
  Future<List<OptionsReservation>> OptionReservation() async {
    List<OptionsReservation> option = [];
    String o = '';


    for (int i = 0; i < ReservationData.optionname.length; i++) {
      if (ReservationData.optionname[i] == OfferDataAvaliable.option_en ||
          ReservationData.optionname[i] == OfferDataAvaliable.option_ar) {
        o = 'Yes';
      } else {
        o = 'No';
      }

      OptionsReservation option2 = new OptionsReservation(
          ReservationData.optionname[i],
          ReservationData.optionname[i],
          ReservationData.optioncount[i],
          ReservationData.optionprice[i],
          o);
      option.add(option2);
      print("nn" + option2.optionnameen);
      print("" + option.length.toString());
    }
    return option;}
  Widget build(BuildContext context) {
  return Options();
  }
  Widget Options() {
    if (ReservationData.optionname.length >= 1) {
      if (MediaQuery.of(context).orientation == Orientation.portrait) {
        return Container(
            margin: EdgeInsets.all(5),
            width: MediaQuery.of(context).size.width,
            child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                color: Colors.white,
                child: Wrap(direction: Axis.vertical, children: <Widget>[
                  Container(
                    width: 400,
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
                                   ApplicationLocalizations.of(context).translate("Option_Name"),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ),
                          Container(
                            width: 100,
                            padding: EdgeInsets.only(
                                top: 5, bottom: 5, left: 2, right: 2),
                            child: Text(
                                 ApplicationLocalizations.of(context).translate("Quantity"),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ),
                          Container(
                            width: 100,
                            padding: EdgeInsets.only(
                                top: 5, bottom: 5, left: 4, right: 4),
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
                      margin: EdgeInsets.only(top: 5, bottom: 5),
                      child: FutureBuilder(
                          future: OptionReservation(),
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
                                  width: MediaQuery.of(context).size.width / 1,
                                  child: ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: snapshot.data.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                        width: 350,
                                        margin: EdgeInsets.all(5),
                                        child: FittedBox(
                                          child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: <Widget>[
                                                Container(
                                                    width: 170,

                                                    child: Text(
                                                      "" +
                                                          snapshot.data[index]
                                                              .optionnameen,
                                                      style: TextStyle(
                                                          fontSize: 17),
                                                    )),
                                                Container(
                                                    width: 100,
                                                    margin: EdgeInsets.only(
                                                        left: 2, right: 2),
                                                    child: Text(
                                                      "" +
                                                          snapshot.data[index]
                                                              .quantity,
                                                      style: TextStyle(
                                                          fontSize: 17),
                                                    )),
                                                Container(
                                                    width: 100,
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
                                                          fontSize: 17),
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
                           ApplicationLocalizations.of(context).translate("Total_Option") ,
                            style: TextStyle(fontSize: 17, color: Colors.black),
                          ),
                        ),
                        Container(
                          child: Text(
                            " " + Totaloption.toString(),
                            style: TextStyle(fontSize: 17, color: Colors.black),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text(
                        "" + optionofferstate,
                        style: TextStyle(fontSize: 17, color: Colors.red),
                      ),
                    ),
                  ),
                ])));
      } else {
        return Container(
            margin: EdgeInsets.all(5),
            width: MediaQuery.of(context).size.width,
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
                          padding: EdgeInsets.only(
                              top: 5, bottom: 5, left: 2, right: 2),
                          child: Text(
                                 ApplicationLocalizations.of(context).translate("Option_Name"),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ),
                        Container(
                          width: 150,
                          padding: EdgeInsets.only(
                              top: 5, bottom: 5, left: 5, right: 5),
                          child: Text(
                                 ApplicationLocalizations.of(context).translate("Quantity"),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              top: 5, bottom: 5, left: 20, right: 20),
                          child: Text(
                                 ApplicationLocalizations.of(context).translate("Price"),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 5, bottom: 5),
                      child: FutureBuilder(
                          future: OptionReservation(),
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> snapshot) {
                            if (snapshot.data == null) {
                              return Center(
                                child: Container(
                                  child: Center(
                                    child: Text(
                                           ApplicationLocalizations.of(context).translate("No_Option_Offer"),
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return Container(
                                  width:
                                  MediaQuery.of(context).size.width / 1.2,
                                  child: ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: snapshot.data.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      if (snapshot.data[index].offerstate ==
                                          "Yes") {
                                        optionofferstate = ' ' +
                                            '' +
                                            snapshot.data[index].optionnameen +
                                            ''
                                                'Option Free ';
                                      } else {
                                        optionofferstate =
                                               ApplicationLocalizations.of(context).translate("No_Option_Offer");

                                          }
                                      return Container(
                                        margin: EdgeInsets.all(5),
                                        child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                  width: 200,
                                                  child: Text(
                                                    "" +
                                                        snapshot.data[index]
                                                            .optionnameen,
                                                    style:
                                                    TextStyle(fontSize: 17),
                                                  )),
                                              Container(
                                                  width: 150,
                                                  margin: EdgeInsets.only(
                                                      left: 10, right: 10),
                                                  child: Text(
                                                    "" +
                                                        snapshot.data[index]
                                                            .quantity,
                                                    style:
                                                    TextStyle(fontSize: 17),
                                                  )),
                                              Container(
                                                  padding: EdgeInsets.only(
                                                      left: 10,
                                                      right: 10,
                                                      top: 5,
                                                      bottom: 5),
                                                  child: Flexible(
                                                    child: Text(
                                                      "" +
                                                          snapshot.data[index]
                                                              .price,
                                                      style: TextStyle(
                                                          fontSize: 17),
                                                    ),
                                                  )),
                                            ]),
                                      );
                                    },
                                  ));
                            }
                          })),
                  Container(
                    margin:
                    EdgeInsets.only(left: 5, right: 5, top: 2, bottom: 2),
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Text(
                               ApplicationLocalizations.of(context).translate("Total_Option") ,

                            style: TextStyle(fontSize: 17, color: Colors.black),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: 2, right: 2, top: 5, bottom: 5),
                          child: Text(
                            " " + Totaloption.toString(),
                            style: TextStyle(fontSize: 17, color: Colors.black),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text(
                        "" + optionofferstate,
                        style: TextStyle(fontSize: 17, color: Colors.red),
                      ),
                    ),
                  ),
                ])));
      }
    }
  }}