
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:language/AppTranslation/AppTranslation.dart';
import 'package:language/MyBooking/MyInnsurance.dart';
import 'package:language/ReservationInformationDesign/AirportLocationMyReservation.dart';
import 'package:language/ReservationInformationDesign/ReservationInfo.dart';
import 'package:language/ReservationInformationDesign/TotalDesign.dart';
import 'package:language/Urls/BustanjiUrl.dart';

import 'InnsuranceReservationsData.dart';
import 'OptionsReservation.dart';
import 'UpdateReservationLocations.dart';

import 'package:http/http.dart' as http;

class MyReservationDetails extends StatefulWidget {
  double suminnsurance = 0, sumoption = 0;
  String pickuplocation,
      returnlocation,
      pickupdate,
      returndate,
      pickuptime,
      returntime,
      airportdate,
      airporttime,
      airportnumber,
      resid,
      coin,
      TotalAfterTax,
      TotalbeforeTax,
      price,
      carimage,
      transmission,
      passanger,
      luggage,
      year,
      carname,
      doors,
      confirmation,visoption = "",visinnsurance="";
  bool visiblecolorred = false,
      visiblecolorgreen = false,
      visiblecolorblue = false,
      visiblecoloewhite,
      visiblecolorblack,
      visiblecoloryellow,
      visiblecolorgrey,
      visiblecolorgold,
      visairport,
      visiblity1 = false;



  @override
  _Myresdetails createState() => _Myresdetails(
      this.resid,
      this.confirmation,
      this.pickuplocation,
      this.returnlocation,
      this.pickupdate,
      this.pickuptime,
      this.returndate,
      this.returntime,
      this.airportdate,
      this.airporttime,
      this.airportnumber,
      this.coin,
      this.TotalbeforeTax,
      this.TotalAfterTax,
      this.price,
      this.carimage,
      this.transmission,
      this.passanger,
      this.luggage,
      this.year,
      this.doors,
      this.visiblecolorred,
      this.visiblecolorblue,
      this.visiblecolorgreen,
      this.visiblecolorgrey,
      this.visiblecolorblack,
      this.visiblecoloryellow,
      this.visiblecoloewhite,
      this.visiblecolorgold,
      this.visairport,
      this.carname,this.visoption,this.visinnsurance);

  MyReservationDetails(
      this.resid,
      this.confirmation,
      this.pickuplocation,
      this.returnlocation,
      this.pickupdate,
      this.pickuptime,
      this.returndate,
      this.returntime,
      this.airportdate,
      this.airporttime,
      this.airportnumber,
      this.coin,
      this.TotalbeforeTax,
      this.TotalAfterTax,
      this.price,
      this.carimage,
      this.transmission,
      this.passanger,
      this.luggage,
      this.year,
      this.doors,
      this.visiblecolorred,
      this.visiblecolorblue,
      this.visiblecolorgreen,
      this.visiblecolorgrey,
      this.visiblecolorblack,
      this.visiblecoloryellow,
      this.visiblecoloewhite,
      this.visiblecolorgold,
      this.visairport,
      this.carname,this.visoption,this.visinnsurance);

}

class _Myresdetails extends State<MyReservationDetails> {
  double suminnsurance = 0.0,
      taxamount,
      sumoption = 0.0;

  String pickuplocation,
      visoption = "1",
      visinssurance = "1",
      optionoffertext,
      returnlocation,
      pickupdate,
      returndate,
      pickuptime,
      returntime,
      airportdate,
      airporttime,
      airportnumber,
      resid,
      coin,
      TotalAfterTax,
      TotalbeforeTax,
      price,
      carimage,
      transmission,
      passanger,
      luggage,
      year,
      door,
      confirmation,
      carname;
  bool visiblecolorred = false,
      visiblecolorgreen = false,
      visiblecolorblue = false,
      visiblecoloewhite,
      visiblecolorblack,
      visiblecoloryellow,
      visiblecolorgrey,
      visiblecolorgold,
      visairport,
      visiblity1 = false;


  _Myresdetails(this.resid,
      this.confirmation,
      this.pickuplocation,
      this.returnlocation,
      this.pickupdate,
      this.pickuptime,
      this.returndate,
      this.returntime,
      this.airportdate,
      this.airporttime,
      this.airportnumber,
      this.coin,
      this.TotalbeforeTax,
      this.TotalAfterTax,
      this.price,
      this.carimage,
      this.transmission,
      this.passanger,
      this.luggage,
      this.year,
      this.door,
      this.visiblecolorred,
      this.visiblecolorblue,
      this.visiblecolorgreen,
      this.visiblecolorgrey,
      this.visiblecolorblack,
      this.visiblecoloryellow,
      this.visiblecoloewhite,
      this.visiblecolorgold,
      this.visairport,
      this.carname, this.visoption, this.visinssurance);

  Future<String> LocationType(String returnlocation,
      String pickuolocation) async {
    var url = await http.get(BustanjiUrls.searchlocation);
    String typel = '';
    String type2 = '';
    var user = json.decode(url.body);
    print("yd");
    print(user);
    for (var i in user) {
      if (i["location_name_english"] == pickuolocation||i["location_name_arabic"]) {
        String locationtxt = i["tax_amount"];
        taxamount = double.parse(locationtxt);
        print("Tax_Amount" + taxamount.toString());
        typel = i["type"];
      }


      if (i["location_name_english"] == returnlocation) {
        type2 = i["type"];
      }

      if (typel == "1" || type2 == "1") {
        print("Airport");
        setState(() {
          visairport = true;
        });
      }
      else {
        setState(() {
          visairport == false;
        });
      }
    }
  }

  Future<List<OptionsReservation>> OptionData() async {
    List<OptionsReservation> Option = [];

    var url = BustanjiUrls.getoption;

    http.Response response =
    await http.post(url, body: {'reservation_id': resid.toString()});
    var op = json.decode(response.body);
    print("Option");
    print(op);
    Option.clear();
    for (var u in op) {
      OptionsReservation optionsReservation = OptionsReservation(
          u["option_name_english"],
          u["option_name_arabic"],
          u["quantity"],
          u["option_price"],
          u["option_offer"]);
      Option.add(optionsReservation);


      try {
        double price = double.parse(u["option_price"]);
        double count = double.parse(u["quantity"]);
        if (u["option_offer"] == "yes") {
          setState(() {
            optionoffertext =
                "One Free " + " " + u["option_name_english"] + " Option";
            count = count - 1;
          });
        }
        sumoption = sumoption + (price * count);
      } catch (Ex) {}
    }


    return Option;
  }

  Future<List<InnsuranceReservationData>> Innsurance() async {
    print("Innsurance");
    print(visinssurance);
    List<InnsuranceReservationData> innsurance = [];

    var url = BustanjiUrls.getinssurance;

    http.Response response =
    await http.post(url, body: {'reservation_id': resid});
    print(response.body);
    innsurance.clear();

    var Offers = json.decode(response.body);
    suminnsurance = 0.0;
    for (var u in Offers) {
      InnsuranceReservationData in1 = InnsuranceReservationData(
          u["name_english"], u["name_arabic"], u["insurance_price"]);
      innsurance.add(in1);
      try {
        double price = double.parse(u["insurance_price"]);
        suminnsurance = suminnsurance + (price);
      } catch (Ex) {}
    }

    return innsurance;
  }

  @override
  Widget build(BuildContext context) {
    LocationType(returnlocation, pickuplocation);
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.indigo[900],

        ),
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
              (Container(
                  margin: EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 10),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: Colors.white,
                    child: Container(
                      margin:
                      EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
                      child: Column(children: <Widget>[
                        Container(
                          child: PickupLocation(),
                        ),
                        Container(
                          child: Carss(),
                        ),
                        //  Container(child:Op
                        //  tions()),
                        Container(
                          child: MyInnsurance(resid),
                        ),
                        Container(
                          child: TotalDesign(TotalbeforeTax, TotalAfterTax),
                        )
                      ]),
                    ),
                  ))),
            ])));
  }


  Widget PickupLocation() {
    var snapshot;


    Container(

        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 400, margin: EdgeInsets.only(top: 10, bottom: 10),
                child: FittedBox(
                  child: Container(child: ResrevationInfo(
                        ApplicationLocalizations.of(context).translate("PickupLoc"),
                      pickuplocation),),),),
              Container(
                width: 400, margin: EdgeInsets.only(top: 10, bottom: 10),
                child: FittedBox(
                  child: Container(child: ResrevationInfo(
                        ApplicationLocalizations.of(context).translate("returnloc"),
                      returnlocation),),),),
              Container(
                width: 400, margin: EdgeInsets.only(top: 10, bottom: 10),
                child: FittedBox(
                  child: Container(child: ResrevationInfo(
                        ApplicationLocalizations.of(context).translate("Pickup_date") + " && " +
                            ApplicationLocalizations.of(context).translate("Pickup_time") + ":",
                      pickuptime + ',' + pickupdate),),),),
              Container(
                width: 400, margin: EdgeInsets.only(top: 10, bottom: 10),
                child: FittedBox(
                  child: Container(child: ResrevationInfo(
                        ApplicationLocalizations.of(context).translate("Return_date") + " && " +
                            ApplicationLocalizations.of(context).translate("Return_Time") + ":",
                      '' + returndate + ',' + returntime),),),),
              Container(
                  width: 400, margin: EdgeInsets.only(top: 10, bottom: 10),
                  child: FittedBox(child: AirportLocationMyReservation(
                      visairport, airportdate, airportnumber, airporttime),)),
              Container(
                child: FlatButton(
                  onPressed: () {
                    double price1 = double.parse(price);
                    double sum = price1 + sumoption + suminnsurance;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                UpdateReservationLocations(
                                    resid,
                                    confirmation,
                                    pickuplocation,
                                    returnlocation,
                                    pickupdate,
                                    returndate,
                                    pickuptime,
                                    returntime,
                                    airportdate,
                                    airporttime,
                                    airportnumber,
                                    sum,
                                    visairport,
                                    taxamount)));
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        left: 100, right: 100, top: 10, bottom: 10),
                    child: Text(
                        ApplicationLocalizations.of(context).translate("Change"),
                      style: TextStyle(
                          fontSize: 18, color: Colors.indigo[900]),
                    ),
                  ),
                ),
              ),


            ]));
  }

  Widget Carss() {
    return Container(
        margin: EdgeInsets.only(top: 10, bottom: 10),
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: Material(
          elevation: 5.0,
          borderRadius: BorderRadius.all(Radius.circular(1.0)),
          color: Colors.white,
          child: Row(
            children: <Widget>[
              Container(
                child: Column(children: <Widget>[
                  Container(
                      padding: EdgeInsets.only(
                          bottom: 10, top: 10, left: 5, right: 5),
                      child: Image.network(
                        carimage,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width / 3,
                        height: 120,
                      )),
                  Container(
                      child: Row(children: <Widget>[
                        Container(
                          padding: (EdgeInsets.all(2)),
                          child: Row(children: <Widget>[
                            Container(
                              width: 40,
                              padding: EdgeInsets.all(2),
                              child: Icon(Icons.person),
                            ),
                            Container(
                              width: 30,
                              padding: EdgeInsets.all(5),
                              child: Text('' + passanger),
                            ),
                          ]),
                        ),
                        Container(
                          child: Row(children: <Widget>[
                            Container(
                              width: 40,
                              padding: EdgeInsets.all(2),
                              child: Image.network(
                                  "https://encrypted-tbn0.gstatic.com/"
                                      "images?q=tbn%3AANd9GcRAnSdWWPCYXS1jmDaF_"
                                      "VhIPJR81UVTCZFNL1H3yByIAxd4vwx7"),
                            ),
                            Container(
                              width: 30,
                              padding: EdgeInsets.all(5),
                              child: Text("" + luggage),
                            ),
                          ]),
                        ),
                      ])),
                  Container(
                    child: Row(children: <Widget>[
                      Container(
                        width: 40,
                        padding: EdgeInsets.all(2),
                        child: Image.network(
                            "https://3.imimg.com/data3/VT/QG/GLADMIN-140882/car-door-250x250.jpg"),
                      ),
                      Container(
                        width: 20,
                        padding: EdgeInsets.all(5),
                        child: Text(luggage),
                      ),
                      Container(
                        width: 80,
                        padding: EdgeInsets.only(left: 20),
                        child: Text(year),
                      ),
                    ]),
                  ),
                ]),
              ),
              Container(
                  margin:
                  EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
                  child: Column(children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: Text(
                        carname,
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10, top: 0),
                      child: Text(
                        "" + transmission,
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.only(
                        top: 10, bottom: 10,),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 30,
                            height: 20,
                            child: Offstage(
                              child: Container(
                                padding: EdgeInsets.only(left: 2, right: 2),
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                  color: Colors.red[500],
                                ),
                              ),
                              offstage: visiblecolorred,
                            ),
                          ),
                          Container(padding: EdgeInsets.only(left: 2, right: 2),
                              child: Offstage(
                                  offstage: visiblecolorblue,
                                  child: (Container(
                                    padding: EdgeInsets.only(left: 2),
                                    decoration: BoxDecoration(
                                      border: Border.all(),
                                      color: Colors.blue,
                                    ),
                                    width: 30,
                                    height: 20,
                                  )))),

                          Offstage(
                              offstage: true,
                              child: Container(padding: EdgeInsets.only(
                                  left: 2, right: 2),
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                  color: Colors.green,
                                ),
                                width: 30,
                                height: 20,
                              )),
                          Offstage(
                            offstage: visiblecolorgreen,
                            child: Container(padding: EdgeInsets.only(
                                left: 2, right: 2),
                              decoration: BoxDecoration(
                                border: Border.all(),
                                color: Colors.black,
                              ),
                              width: 30,
                              height: 20,
                            ),
                          ),
                          //,padding: EdgeInsets.only(left: 50,right: 10,top: 10)),
                        ],
                      ),
                    ), //,),
                    Container(
                      padding: EdgeInsets.only(
                          top: 0, left: 0, bottom: 10, right: 0),
                      child: Row(
                        children: <Widget>[
                          Offstage(
                              offstage: visiblecolorgrey,
                              child: Container(padding: EdgeInsets.only(
                                  left: 2, right: 2),
                                decoration: BoxDecoration(
                                    border: Border.all(), color: Colors.grey),
                                width: 30,
                                height: 20,
                              )),
                          Offstage(
                              offstage: visiblecoloryellow,
                              child: Container(
                                padding: EdgeInsets.only(left: 2, right: 2),
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                  color: Colors.yellow,
                                ),
                                width: 30,
                                height: 20,
                              )),
                          Offstage(
                            offstage: visiblecoloewhite,
                            child: Container(
                              padding: EdgeInsets.only(left: 2, right: 2),
                              decoration: BoxDecoration(
                                border: Border.all(),
                                color: Colors.white,
                              ),
                              width: 30,
                              height: 20,
                            ),
                          ),
                          Offstage(
                              offstage: visiblecolorgold,
                              child: Container(
                                  padding: EdgeInsets.only(left: 2, right: 2),
                                  width: 30,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                    color: Colors.orangeAccent,
                                  ))),

                          //,padding: EdgeInsets.only(left: 50,right: 10,top: 10)),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(2),
                      child: Text(
                        '' + price + "  " + coin,
                        style: TextStyle(fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ])),
            ],
          ),
        ));
  }

  Widget Airport() {
    if (visairport == true) {
      return Container(
          child: Wrap(direction: Axis.vertical, children: <Widget>[
            Container(width: 370,
              padding: EdgeInsets.only(left: 2, right: 2, top: 10, bottom: 5),
              child: FittedBox(
                child: Row(
                    children: <Widget>[
                      Container(

                        child: Text(
                          "Flight Date   && Time :   ",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        width: 200,
                        padding: EdgeInsets.all(5),

                        child: Text(
                          airportdate + "  ," + airporttime,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15, fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),

                    ]),
              ),
            ),
            Container(

              width: 400,
              child: FittedBox(
                child: Row(children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                        top: 5, bottom: 5, left: 2, right: 2),

                    child: Container(width: 200,
                      child: Text(
                        "Flight  Number   : ",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),

                  ),
                  Container(
                    width: 200,
                    padding: EdgeInsets.only(
                        top: 5, bottom: 5, left: 2, right: 2),

                    child: Text(
                      " " + airportnumber,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15, fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),

                ]),
              ),
            ),
          ]));
    }
  }

}