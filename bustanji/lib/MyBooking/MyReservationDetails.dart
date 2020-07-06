
import 'dart:convert';
import 'package:devicepreview/AppTranslation/AppTranslation.dart';
import 'package:devicepreview/ReservationInformationDesign/AirportLocationMyReservation.dart';
import 'package:devicepreview/ReservationInformationDesign/ReservationInfo.dart';
import 'package:devicepreview/WidthAndHeighTWidget/Size_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../Urls.dart';
import 'InnsuranceReservationsData.dart';
import 'MyInnsurance.dart';
import 'MyOption.dart';
import 'OptionsReservation.dart';
import 'UpdateReservationLocations.dart';

import 'package:http/http.dart' as http;

class MyReservationDetails extends StatefulWidget {
  double suminnsurance = 0, sumoption = 0;
  String pickuplocation,offername,
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
      this.confirmation,this.offername,
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
      this.confirmation,this.offername,
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

  String pickuplocation ,
  offername='',
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
      this.confirmation,this.offername,
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
    var url = await http.get(Urls.searchlocation);
    String typel = '';
    String type2 = '';
    var user = json.decode(url.body);
    print("yd");
    print(user);
    for (var i in user) {
      if (i["location_name_english"] == pickuolocation ||i["location_name_english"]==returnlocation) {
        String locationtxt = i["tax_amount"];
        taxamount = double.parse(locationtxt);
        print("Tax_Amount" + taxamount.toString());
        typel = i["type"];
      }


      if (i["location_name_english"] == returnlocation ||i["location_name_english"]==returnlocation) {
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


  Future<List<InnsuranceReservationData>> Innsurance() async {
    print("Innsurance");
    print(visinssurance);
    List<InnsuranceReservationData> innsurance = [];

    var url = Urls.getinssurance;

    http.Response response =
    await http.post(url, body: {'reservation_id': resid});
    print(response.body);
    innsurance.clear();

    var Offers = json.decode(response.body);
    suminnsurance = 0.0;
    for (var u in Offers) {
      InnsuranceReservationData in1 = InnsuranceReservationData(
          u["name_english"],  u["insurance_price"]);
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
                  margin: EdgeInsets.
                all(5),
                  width: double.infinity,
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: Colors.white,
                    child: Container(
                      margin:
                      EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
                      child: Column(children: <Widget>[
                        Container(margin: EdgeInsets.only(
                            left: 10, right: 10, top: 10, bottom: 10),
                        width: double.infinity,
                        child: Material(
                            elevation: 5,
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            color: Colors.white,child: Column(children: <Widget>[

                        ],),)),
                       Container(child: FirstDesign()),
//                    ),
                        Container(
                          child: Car(),
                        ),
                        //  Container(child:Op
                        //  tions()),
                       Container(
                         child: MyOption(resid,visoption),
                        ),
                        Container(margin: EdgeInsets.only(top: 20,bottom: 20),
                          child: MyInnsurance(resid,visinssurance),
                        ),
            Container(
                        width:double.infinity,
                        margin: EdgeInsets.only(top: 0,left: 5,right: 5),
                        child: Material(elevation: 5.0,
                            borderRadius: BorderRadius.all(Radius.circular(2.0)),
                            child:SafeArea(
                              child: Column(children: <Widget>[ Container(
                                child: ResrevationInfo(
                                    ApplicationLocalizations.of(context).translate("Total_Before_Tax"),
                                    ""+":"+TotalbeforeTax),
                              ),
                                Container(
                                  child: ResrevationInfo(
                                      ApplicationLocalizations.of(context).translate("Total_After_Tax"),
                                      ""+":"+TotalAfterTax),
                                ),]),
                        )
                        ))]),
                    ),
                  ))),
            ])));
  }


  Widget FirstDesign() {
    return SafeArea(
        child: Container(width: double.infinity,margin: EdgeInsets.only(top: 10,bottom: 10),
        child: Material(
        elevation: 5,
        borderRadius: BorderRadius.all(Radius.circular(2.0)),
    color: Colors.white,

    child: Column(children: <Widget>[
      Container(
        width:double.infinity, margin: EdgeInsets.only(top: 5, bottom: 5),

          child: Container(child: ResrevationInfo(
              ApplicationLocalizations.of(context).translate("PickupLoc"),
              pickuplocation),),),
            Container(width: double.infinity,
              child: ResrevationInfo(
                  ApplicationLocalizations.of(context).translate("returnloc"),

                returnlocation),),

            Container(width: double.infinity,
                child: ResrevationInfo(
                    ApplicationLocalizations.of(context).translate("Pickup_date")+
                        "&& "+ApplicationLocalizations.of(context).translate(
                        "Pickup_time")," "+pickupdate+ ' ,'+pickuptime),),

            Container(width: double.infinity,
              child: ResrevationInfo(
                  ApplicationLocalizations.of(context).translate("Return_date")+
                      "&& "+ApplicationLocalizations.of(context).translate(
                      "Return_Time"),""+returndate+ ' ,'+returntime),),
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
                            offername,
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

            child: Center(
              child: Text(
                ApplicationLocalizations.of(context).translate("Change"),
                style: TextStyle(
                    fontSize: Size1.Font_size, color: Colors.indigo[900]),
              ),
            ),
          ),
        ),
      ),]))));



  }

  Widget PickupLocation() {


    return Container(
        width:double.infinity,
        child:  Container(
          width: double.infinity,
          child: Material(
              elevation: 5,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              color: Colors.white,

          child: Column(


              children: <Widget>[
                Container(
                  width:double.infinity, margin: EdgeInsets.only(top: 5, bottom: 5),
                  child: FittedBox(
                    child: Container(child: ResrevationInfo(
                        ApplicationLocalizations.of(context).translate("PickupLoc"),
                        pickuplocation),),),),
                Container(
                  width:double.infinity, margin: EdgeInsets.only(top: 5, bottom: 5),
                  child: FittedBox(
                    child: Container(child: ResrevationInfo(
                        ApplicationLocalizations.of(context).translate("returnloc"),
                        returnlocation),),),),
          Container(width:double.infinity,margin: EdgeInsets.only(top: 5,bottom: 5),
            child: FittedBox(
              child: Container(child: ResrevationInfo(ApplicationLocalizations.of(context).translate("Pickup_date")+" && "+
                  ApplicationLocalizations.of(context).translate("Pickup_time") +":",pickupdate+','+pickuptime),),),),
          Container(width:double.infinity,margin: EdgeInsets.only(top: 5,bottom: 5),),
          Container(width:double.infinity,margin: EdgeInsets.only(top: 5,bottom: 5),
            child: FittedBox(
              child: Container(child: ResrevationInfo(ApplicationLocalizations.of(context).translate("Return_date")+" && "+
                  ApplicationLocalizations.of(context).translate("Return_Time") +":"  ,returndate+' ,'+returntime,),),),),
          Container(width:MediaQuery.of(context).size.width,margin:EdgeInsets.only(top: 5,bottom: 5),child: AirportLocationMyReservation(visairport,airportdate,airportnumber,airportnumber,),),


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
                                      confirmation,offername,
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


              ]),
        )));
  }
Widget Car(){

  return Container(
    width:double.infinity,
    margin:
    EdgeInsets.only(top: 10),
    child: Material(
        elevation: 5.0,
        borderRadius:
        BorderRadius.all(Radius.circular(2.0)),
        color: Colors.white,
        child: FittedBox(
        child: SafeArea(
        child: Row(children: <Widget>[
    Container(margin: EdgeInsets.only(left:5,right: 5),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Container(
              padding: EdgeInsets.only(
                  bottom: 10, top: 10, left: 10),
              child: Image.network(
               carimage,
                width: MediaQuery
                    .of(context)
                    .size
                    .width /
                    3.4,
                height:  MediaQuery
                    .of(context)
                    .size
                    .width /
                    6.4,
              )),
          Container(
              child: FittedBox(
                child: Row(children: <Widget>[
                  Container(
                    //padding: (EdgeInsets.all(2)),
                    child: Row(children: <Widget>[
                      Container(
                        width: Size1.size_icon,
                        padding: EdgeInsets.all(2),
                        child: Icon(Icons.person),
                      ),
                      Container(
                        width: Size1.size_icon,
                        padding: EdgeInsets.all(5),
                        child: Text(
                            passanger),
                      ),
                    ]),
                  ),
                  Container(
                    child: Row(children: <Widget>[
                      Container(
                        width: Size1.size_icon,
                        padding: EdgeInsets.all(2),
                        child: Image.network(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRAnSdWWPCYXS1jmDaF_VhIPJR81UVTCZFNL1H3yByIAxd4vwx7"),
                      ),
                      Container(
                        width: Size1.size_icon,
                        padding: EdgeInsets.all(5),
                        child:
                        Text(luggage),
                      ),
                    ]),
                  ),
                ]),
              )),
          Container(
            child: Row(children: <Widget>[
              Container(
                width: Size1.size_icon,
                padding: EdgeInsets.all(2),
                child: Image.network(
                    "https://3.imimg.com/data3/VT/QG/GLADMIN-140882/car-door-250x250.jpg"),
              ),
              Container(
                width: 20,
                padding: EdgeInsets.all(5),
                child: Text(door),
              ),
              Container(
                width: 80,
                padding:
                EdgeInsets.only(left: 15, right: 15),
                child: Text(year),
              ),
            ]),
          ),
        ]),
  ),
  Container(
  child: Column(children: <Widget>[
  Container(
  padding: EdgeInsets.only(
  left: 10, right: 10, top: 10),
  child: Text(
  carname,
  style: TextStyle(
  fontSize: Size1.Font_size,
  color: Colors.black,
  fontWeight: FontWeight.normal),
  ),
  ),
  Container(
  padding: EdgeInsets.only(
  left: 0, right: 10, top: 0),
  child: Text(
  transmission,
  style: TextStyle(
  fontSize: Size1.Font_size,
  color: Colors.black),
  ),
  ),

  Container(
  padding: EdgeInsets.only(
  top: 5,
  left: 20,
  bottom: 5,
  right: 20),
  child: Container(

  child: Row(
  children: <Widget>[
  Container(
  width: 30,
  height: 20,
  child: Offstage(
  child: Container(
  padding: EdgeInsets.only(
  left: 2, right: 2),
  decoration: BoxDecoration(
  border: Border.all(),
  color: Colors.red[500],
  ),
  ),
  offstage:
 visiblecolorred,
  ),
  ),
  Container(
  padding: EdgeInsets.only(left: 2, right: 2),
  child: Offstage(
  offstage:visiblecolorblue,
  child: (Container(
  padding: EdgeInsets.only(
  left: 2, right: 2),
  decoration: BoxDecoration(
  border: Border.all(),
  color: Colors.blue,
  ),
  width: 30,
  height: 20,
  )))),

  Padding(
  padding: const EdgeInsets.only(
  left: 2, right: 2),
  child: Offstage(
  offstage:
visiblecolorgreen,
  child: Container(
  padding: EdgeInsets.only(
  left: 2, right: 2),
  decoration: BoxDecoration(
  border: Border.all(),
  color: Colors.green,
  ),
  width: 30,
  height: 20,
  )),
  ),
  Padding(
  padding: const EdgeInsets.only(
  left: 2, right: 2),
  child: Offstage(
  offstage:
 visiblecolorblack,
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
  ),
  //,padding: EdgeInsets.only(left: 50,right: 10,top: 10)),
  ],
  ),
  ),
  ),
  //,),

  Container(
  padding: EdgeInsets.all(0),
  child: Text(
 price +''+coin,

  style: TextStyle(
  fontSize: Size1.Font_size,
  color: Colors.black, fontWeight: FontWeight.bold),
  ),
  )



  ]))]))
  ),
  ));
}
  Widget Carss() {
    return SafeArea(
      child: Container(
          margin: EdgeInsets.only(top: 10, bottom: 10),
          width: double.infinity,
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
          )),
    );
  }


    }


