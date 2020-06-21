
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:language/AppTranslation/AppTranslation.dart';
import 'package:language/ReservationInformationDesign/ReservationInfo.dart';
import 'package:language/ReservationInformationDesign/TotalDesign.dart';
import 'package:language/Urls/BustanjiUrl.dart';

import 'MyReservationDetails.dart';
import 'OptionsReservation.dart';
import 'InnsuranceReservationsData.dart';
import 'UpdateReservationLocations.dart';


class Designrespickuplocation extends StatefulWidget {
  AsyncSnapshot snapshot;
  int index;

  @override
  Designrespickuplocation(this.snapshot, this.index) {}

  _DesignrespickuplocationState createState() =>
      _DesignrespickuplocationState(snapshot, index);
}
@override
void initState() {

}

class _DesignrespickuplocationState extends State<Designrespickuplocation> {
  AsyncSnapshot snapshot;
  int index;
  String reason,
      optionoffertext = '';
  TextEditingController controll = new TextEditingController();
  bool visiblecolorred = false,
      visiblecolorgreen = false,
      visiblecolorblue = false,
      visiblecoloewhite,
      visiblecolorblack,
      visiblecoloryellow,
      visiblecolorgrey,
      visiblecolorgold,
      visairport,
      visiblity1 = false,
      visoption = true,
      visop = false,
      visinssurance = true;
  double sumoption = 0.0,
      suminnssurance = 0.0;
  Color colors;
  String confirm;

  bool viscancel = true;

  void confirmandoffer() {
    if (snapshot.data[index].confirmation == "0") {
      confirm = "Reservation is  not Confirmed yet";
    } else {
      confirm = "Reservation  Confirmed";
    }
    print(snapshot.data[index].offername);
    if (snapshot.data[index].offername == 'timeOffer' ||
        snapshot.data[index].offername == 'daysOffer' ||
        snapshot.data[index].offername == 'fuelOffer' ||
        snapshot.data[index].offername == 'discountOffer' ||
        snapshot.data[index].offername == 'optionOffer') {
      setState(() {
        colors = Colors.red;
      });
    } else {
      setState(() {
        colors = Colors.indigo[900];
      });
    }
    String p = snapshot.data[index].pickuplocation;
    String R = snapshot.data[index].returnlocation;
    if (p.contains("Aireport") || R.contains("Aireport")) {
      setState(() {
        visairport = true;
      });
    } else {
      setState(() {
        visairport = false;
      });
    }
  }

  Future<List<OptionsReservation>> Option() async {
    List<OptionsReservation> Option = [];
    Option.clear();
    var url = BustanjiUrls.getoption;
    print(snapshot.data[index].resid);
    http.Response response = await http
        .post(url, body: {'reservation_id':
    snapshot.data[index].resid});
    print(response.body);
    var Offers = json.decode(response.body);
    sumoption = 0;
    for (var u in Offers) {
      OptionsReservation optionsReservation = OptionsReservation(
          u["option_name_english"],
          u["option_name_arabic"],
          u["quantity"],
          u["option_price"], u["option_offer"]);
      Option.add(optionsReservation);
      print(u["option_off"
          "er"]);
      try {
        double price = double.parse(u["option_price"]);
        double count = double.parse(u["quantity"]);
        if (u["option_offer"] == "Yes") {
          setState(() {
            optionoffertext =
                "One Free " + " " + u["option_name_english"] +
                    " Option";
            count = count - 1;
          });
        }
        sumoption = sumoption + (price * count);
      } catch (Ex) {}
    }
    print(Option.length);
    return Option;
  }

  Future UpdateReservation() async {
    print("Enter  Cancel");

    var data = BustanjiUrls.cancelres;

    http.Response response = await http.post(data, body: {
      'resrvationID': snapshot.data[index].resid,
      'reason': controll.text.toString(),
    });
  }

  Future<List<InnsuranceReservationData>> Innsurance() async {
    print("DataPass");
    List<InnsuranceReservationData> innsurance = [];

    var url = BustanjiUrls.getinssurance;


    http.Response response = await http
        .post(url, body: {'reservation_id': snapshot.data[index].resid});
    print(response.body);
    innsurance.clear();

    var Offers = json.decode(response.body);
    suminnssurance = 0.0;
    for (var u in Offers) {
      InnsuranceReservationData in1 = InnsuranceReservationData(
          u["name_english"], u["name_arabic"], u["insurance_price"]);
      innsurance.add(in1);
      try {
        double price = double.parse(u["insurance_price"]);
        suminnssurance = suminnssurance + (price);
      } catch (Ex) {}
    }

    return innsurance;
  }

  void setcolors() {
    visiblity1
    = snapshot.data[index].visbility;
    if (snapshot.data[index].red == "1") {
      //  print('its red');
      visiblecolorred = true;
    } else {
      visiblecolorred = false;
    }
    if (snapshot.data[index].green == "1") {
      print('its green');
      //  visiblecolorgreen = true;
    } else {
      visiblecolorgreen = false;
    }
    if (snapshot.data[index].blue == "1") {
      ///  print('its blue');
      visiblecolorblue = true;
    } else {
      visiblecolorblue = false;
    }
    if (snapshot.data[index].white == "1") {
      //  print('its white');
      visiblecoloewhite = true;
    } else {
      visiblecoloewhite = false;
    }
    if (snapshot.data[index].sliver == "1") {
      //  print('its grey');
      visiblecolorgrey = true;
    } else {
      visiblecolorgrey = false;
    }
    if (snapshot.data[index].gold == "1") {
      //   print('its gold');
      visiblecolorgold = true;
    } else {
      visiblecolorgold = false;
    }
    if (snapshot.data[index].black == "1") {
      //   print('its black');
      visiblecolorblack = true;
    } else {
      visiblecolorblack = false;
    }
    if (snapshot.data[index].yellow == "1") {
      //  print('its yellow');
      visiblecoloryellow = true;
    } else {
      visiblecoloryellow = false;
    }
  }

  AlertDialogWarning(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text(   ApplicationLocalizations.of(context).translate("Warning") ),
              content: Text(
                  ' '),
              actions: <Widget>[
                Row(children: <Widget>[
                  MaterialButton(
                      elevation: 5.0,
                      onPressed: () {
                        UpdateReservation();
//                        Navigator.push(
//                            context,
//                            MaterialPageRoute(
//                              builder: (context) => (),
//                            ));
                        Navigator.of(context).pop();
                      },
                      child: Text(   ApplicationLocalizations.of(context).translate("ok"))),
                  MaterialButton(
                    elevation: 5.0,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text((   ApplicationLocalizations.of(context).translate("cancel")),
                  )
                  )])
              ]);
        });
  }

  AlertDialogReason(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text(   ApplicationLocalizations.of(context).translate("Warning")),
              content: Container(width: MediaQuery
                  .of(context)
                  .size
                  .width,
                  child: Wrap(children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(5),
                      child:
                      Text(   ApplicationLocalizations.of(context).translate("Are You Sure want to Cancel This_Reservation ?"),),
                    ),
                    Container(
                        margin: EdgeInsets.all(5),
                        child: Form(
                            child: Column(children: [
                              Container(height: 70,
                                margin: EdgeInsets.all(10),
                                decoration: new BoxDecoration(
                                  borderRadius:
                                  new BorderRadius.all(
                                      new Radius.circular(10.0)),
                                ),

                                child: Container(width: 300,
                                  child: TextFormField(
                                    keyboardType: TextInputType.multiline,
                                    controller: controll,
                                    decoration: new InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                        BorderSide(
                                            color: Colors.blue, width: 2.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                        BorderSide(
                                            color: Colors.grey, width: 2.0),
                                      ),
                                      hintText: 'Please Enter The  Reason ',

                                    ),
                                  ),
                                ),
                              ),
                            ])))
                  ])),
              actions: <Widget>[
                Row(children: <Widget>[
                  MaterialButton(
                      elevation: 5.0,
                      onPressed: () {
                        Navigator.of(context).pop();
                        AlertDialogWarning(context);
                      },
                      child: Text("ok")),
                  MaterialButton(
                    elevation: 5.0,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Cancel"),
                  )
                ])
              ]);
        });
  }

  _DesignrespickuplocationState(this.snapshot, this.index);

  @override
  Widget build(BuildContext context) {
    setcolors();
    confirmandoffer();

    return Container(
        margin: EdgeInsets.only(top: 5, bottom: 5, right: 3, left: 3),
        width: MediaQuery
            .of(context)
            .size
            .width / 1, child: Material(
        elevation: 5,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        color: Colors.white,
        child: Container(


          margin: EdgeInsets.all(5),
          child: Column(

            children: <Widget>[
              Container(child: FirstDesign(),),


              Container(
                margin:
                EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 5),
                child: Visibility(visible: snapshot.data[index].visbility,
                    child: InnsuranceData()),
              ),
              Container(
                margin:
                EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 5),
                child: Visibility(
                    visible: snapshot.data[index].visbility, child: TotalDesign(snapshot.data[index].price_before_tax,snapshot.data[index].total_price_after_tax)),
              ),
            ],
          ),
        )));
  }

  Widget FirstDesign() {
    return Container(

        child: Material(
            elevation: 5,
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            color: Colors.white,
            child: Material(elevation: 5,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                color: Colors.white,
                child: Container(margin: EdgeInsets.all(4),
                    child: Wrap(direction: Axis.vertical, children: <Widget>[
                      Container(
                          child: Column(children: <Widget>[
                            Container(width: 400,margin: EdgeInsets.only(top: 10,bottom: 10),
                                child: FittedBox(
                                    child: Container(child: ResrevationInfo(   ApplicationLocalizations.of(context).translate("Reservation_Number"),snapshot.data[index].resid),),),),

                           Container(width: 400,margin: EdgeInsets.only(top: 10,bottom: 10),),
                            Container(width: 400,margin: EdgeInsets.only(top: 10,bottom: 10),
                              child: FittedBox(
                                child: Container(child: ResrevationInfo(   ApplicationLocalizations.of(context).translate("Pickup_date")+" && "+
                                      ApplicationLocalizations.of(context).translate("Pickup_time") +":",snapshot.data[index].returnlocation),),),),
                            Container(width: 400,margin: EdgeInsets.only(top: 10,bottom: 10),
                              child: FittedBox(
                                child: Container(child: ResrevationInfo(   ApplicationLocalizations.of(context).translate("Return_date")+" && "+
                                      ApplicationLocalizations.of(context).translate("Return_Time") +":",snapshot.data[index].returnlocation),),),),

                            Container(width: 400,margin: EdgeInsets.only(top: 10,bottom: 10),
                              child: FittedBox(
                                child: Container(child: ResrevationInfo(   ApplicationLocalizations.of(context).translate("Total_All_Peroid"),snapshot.data[index].total),),),),

                            Container(
                                child: Row(children: <Widget>[
                                  Container(
                                    padding:
                                    EdgeInsets.only(
                                        left: 25, right: 25, bottom: 3, top: 3),
                                    child: FlatButton(onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MyReservationDetails(
                                                      snapshot.data[index]
                                                          .resid,
                                                      snapshot.data[index]
                                                          .confirmation,
                                                      snapshot.data[index]
                                                          .pickuplocation,
                                                      snapshot.data[index]
                                                          .returnlocation,
                                                      snapshot.data[index]
                                                          .pickup_date,
                                                      snapshot.data[index]
                                                          .pickuptime,
                                                      snapshot.data[index]
                                                          .return_date,
                                                      snapshot.data[index]
                                                          .returntime,
                                                      snapshot.data[index]
                                                          .flight_date,
                                                      snapshot.data[index]
                                                          .flight_time,
                                                      snapshot.data[index]
                                                          .flight_number,
                                                      snapshot.data[index].coin,
                                                      snapshot.data[index]
                                                          .price_before_tax,
                                                      snapshot.data[index]
                                                          .total_price_after_tax,
                                                      snapshot.data[index]
                                                          .car_price_per_day,
                                                      snapshot.data[index]
                                                          .carimage,
                                                      snapshot.data[index]
                                                          .transmission,
                                                      snapshot.data[index]
                                                          .passenger,
                                                      snapshot.data[index]
                                                          .luggage,
                                                      snapshot.data[index]
                                                          .car_year,
                                                      snapshot.data[index]
                                                          .doors,
                                                      visiblecolorred,
                                                      visiblecolorblue,
                                                      visiblecolorgreen,
                                                      visiblecolorgrey,
                                                      visiblecolorblack,
                                                      visiblecoloryellow,
                                                      visiblecoloewhite,
                                                      visiblecolorgold,
                                                      visairport,
                                                      snapshot.data[index]
                                                          .car_model_english,snapshot.data[index].Option_status,
                                                      snapshot.data[index].Innsurance_status)));

                                    }, child: Row(children: <Widget>[Container(

                                        child: Icon(Icons.arrow_forward_ios,
                                          color: Colors.indigo,)), Container(
                                      padding: EdgeInsets.only(
                                          left: 2, right: 2),
                                      child: Text(     ApplicationLocalizations.of(context).translate("More_Info") , style:
                                      TextStyle(fontSize: 17,
                                          color: Colors.indigo[900]),),)
                                    ],),),
                                  ),

                                ])),
                            Container(
                                child: Row(children: <Widget>[
                                  Container(
                                    padding:
                                    EdgeInsets.only(
                                        left: 25, right: 25, bottom: 3, top: 3),
                                    child: FlatButton(onPressed: () {
                                      AlertDialogReason(context);
                                    }, child: Row(children: <Widget>[
                                      Container(child: Icon(Icons.cancel,
                                        color: Colors.indigo,)),
    Container(
                                        padding: EdgeInsets.only(
                                            left: 2, right: 2),
                                        child: Text(   ApplicationLocalizations.of(context).translate("Cancel_Reservation") ,
                                          style: TextStyle(fontSize: 17,),))])))]))]))])))));
//
//                  Container(padding: EdgeInsets.all(5),
//                    child: Row(children: <Widget>[
//                      Container(
//                        padding: EdgeInsets.all(5),
//                        child: Text(
//                          "Pick Up Date & Time :",
//                          style: TextStyle(color: Colors.black, fontSize: 17),
//                        ),
//                      ),
//                      Container(
//                        padding: EdgeInsets.all(5),
//                        child: Text(
//                          snapshot.data[index].pickup_date +
//                              ',' +
//                              '' +
//                              snapshot.data[index].pickuptime,
//                          style:
//                              TextStyle(color: Colors.grey[600], fontSize: 15),
//                        ),
//                      ),
//                    ]),
//                  ),
//                  Container(padding: EdgeInsets.all(5),
//                    child: Row(children: <Widget>[
//                      Container(
//                        padding: EdgeInsets.all(5),
//                        child: Text(
//                          "Return Date  & Time :",
//                          style:
//                              TextStyle(color: Colors.black, fontSize: 17),
//                        ),
//                      ),
//                      Container(
//                        padding: EdgeInsets.all(5),
//                        child: Text(
//                          snapshot.data[index].return_date +
//                              ',' +
//                              snapshot.data[index].returntime,
//                          style:
//                              TextStyle(color: Colors.grey[600], fontSize: 15),
//                        ),
//                      ),
//                    ]),
//                  ), Container(padding: EdgeInsets.all(5),
//                    child: Row(children: <Widget>[
//                      Container(
//                        padding: EdgeInsets.all(5),
//                        child: Text(
//                          "Total Price :",
//                          style:
//                          TextStyle(color: Colors.black, fontSize: 17),
//                        ),
//                      ),
//                      Container(
//                        padding: EdgeInsets.all(5),
//                        child: Text(
//                          snapshot.data[index].totalprice +' '+snapshot.data[index].coin,
//
//                          style:
//                          TextStyle(color: Colors.grey[600], fontSize: 17),
//                        ),
//                      ),
//                    ]),
//                  ),
//                ]),
//                Visibility(visible: viscancel,
//
//                  child: Container(child: Cars(),),
//                ),
//                Container( padding: new EdgeInsets.only(left: 10,right: 10),
//                  child: Column(
//                    children: <Widget>[
//                      Container(
//                        child: FlatButton(
//                          onPressed: () {setState(() {if(visop==false){
//                            viscancel=false;
//                            visop=true;}
//                            else{visop=false;viscancel=true;}
//                          });},
//                          child: Text(
//                            'More Info >',
//                            style:
//                                TextStyle(fontSize: 18, color: Colors.indigo[900]),
//                          ),
//                        ),
//                      ),
//                      Container(
//
//                        child: Visibility(visible: viscancel,
//                          child: FlatButton(
//                            onPressed: () {},
//                            child: Row(
//                              children: <Widget>[
//                                Container(
//                                  child: Text(
//                                    'Cancel Reservation ',
//                                    style: TextStyle(
//                                        fontSize: 18, color: Colors.indigo[900]),
//                                  ),
//                                ),Container(child: Icon(Icons.cancel,color:Colors.indigo[900]),),
//                              ],
//                            ),
//                          ),
//
//                        ),
//                      ),
//                    ],
//                  ),
//                ),
//         Container(child:PickupLocation(),)  ])),
//                 // Container(child: PickupLocation(),),
//
//               ]))]))))]))));
  }

  Widget PickupLocation() {
    if (snapshot.data[index].visbility == true) {
      return Container(
          width: MediaQuery
              .of(context)
              .size
              .width,
          margin: EdgeInsets.all(3),
          child: Material(
              elevation: 5.0,
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              color: Colors.white,
              child: Column(children: <Widget>[
                Container(
                    child: Column(children: <Widget>[
                      Container(width: 400,margin: EdgeInsets.only(top: 10,bottom: 10),
                        child: FittedBox(
                          child: Container(child: ResrevationInfo(   ApplicationLocalizations.of(context).translate("PickupLoc"),snapshot.data[index].pickuplocation),),),),
                      Container(width: 400,margin: EdgeInsets.only(top: 10,bottom: 10),
                        child: FittedBox(
                          child: Container(child: ResrevationInfo(   ApplicationLocalizations.of(context).translate("returnloc"),snapshot.data[index].returnlocation),),),),

                      Container(
                        child: Airport(),
                      ),
                      Container(
                          child: Column(children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 25, right: 25),
                              child: FlatButton(
                                onPressed: () {
                                  double price1 = double.parse(
                                      snapshot.data[index].car_price_per_day);
                                  double sum = price1 + suminnssurance +
                                      sumoption;
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            UpdateReservationLocations(
                                                snapshot.data[index].resid,
                                                snapshot.data[index]
                                                    .confirmation,
                                                snapshot.data[index]
                                                    .pickuplocation,
                                                snapshot.data[index]
                                                    .returnlocation,
                                                snapshot.data[index]
                                                    .pickup_date,
                                                snapshot.data[index]
                                                    .return_date,
                                                snapshot.data[index].pickuptime,
                                                snapshot.data[index].returntime,
                                                snapshot.data[index]
                                                    .flight_date,
                                                snapshot.data[index]
                                                    .flight_time,
                                                snapshot.data[index]
                                                    .flight_number,
                                                sum,visairport,0),
                                      ));
                                },
                                child: Text(
                                  'Change ',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.indigo[900]),
                                ),
                              ),
                            ),
                          ])),
                    ])),
              ])));
    }
  }

  Widget Airport() {
    if (visairport == true) {
      return Container(
          child: Column(children: <Widget>[
            Container(
              child: Wrap(direction: Axis.horizontal, children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                      left: 2, right: 2, top: 5, bottom: 5),
                  child: Text(
                    "Flight Date && Time :   ",
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
                    snapshot.data[index].flight_date +
                        ' ,' +
                        snapshot.data[index].flight_time,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ]),
            ),
            Container(width: 260,
              child: FittedBox(
                child: Row(children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                        top: 5, bottom: 5, left: 2, right: 2),
                    child: Text(
                      "Flight Number  :",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        top: 5, bottom: 5, left: 2, right: 2),
                    child: Text(
                      '' + snapshot.data[index].flight_number,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ]),
              ),
            ),
          ]));
    }
  }


  Widget InnsuranceData() {

    if (MediaQuery
        .of(context)
        .orientation == Orientation.portrait) {
      return Container(margin: EdgeInsets.all(5),
          width: MediaQuery
              .of(context)
              .size
              .width / 1.1,
          child: Material(
              elevation: 5.0,
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              color: Colors.white,
              child: Wrap(direction: Axis.vertical, children: <Widget>[


                Container(
                  margin: EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        width: 170,
                        padding:
                        EdgeInsets.only(top: 5, bottom: 5, left: 2, right: 2),
                        child: Text(
                          "Innsurance Name",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),

                      ), Container(
                        width: 100,
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
                          if (snapshot.data == null) {
                            return Center(

                                child: Text("No Data ",

                                  style: TextStyle(fontSize: 18,),
                                ));
                          } else {
                            return Container(

                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 1.2,

                                child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (BuildContext context,
                                      int index) {
                                    return Container(

                                      margin: EdgeInsets.all(5),
                                      child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                                width: 200,
                                                child: Text(
                                                  "" +
                                                      snapshot.data[index]
                                                          .innsurance_en,
                                                  style: TextStyle(
                                                      fontSize: 17),
                                                )),

                                            Container(
                                                padding: EdgeInsets.only(
                                                    left: 5,
                                                    right: 5,
                                                    top: 5,
                                                    bottom: 5),
                                                child: Text(
                                                  "" + snapshot.data[index]
                                                      .price,
                                                  style: TextStyle(
                                                      fontSize: 17),
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
                          "Total Innsurance :",
                          style: TextStyle(fontSize: 17, color: Colors.black),
                        ),
                      ),
                      Container(
                        child: Text(
                          " " + suminnssurance.toString(),
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
    }
    else {
      return Container(margin: EdgeInsets.all(5),
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
                          "Innsurance Name",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),

                      ),

                      Container(width: 200,
                        padding: EdgeInsets.only(
                            left: 30,
                            right: 30,
                            top: 5,
                            bottom: 5),

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

                                child: Text("No Innssurance  ",

                                  style: TextStyle(fontSize: 18,),
                                ));
                          } else {
                            return Container(

                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 1.2,

                                child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (BuildContext context,
                                      int index) {
                                    return Container(


                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .start,

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
                                                  style: TextStyle(
                                                      fontSize: 17),
                                                )),

                                            Container(width: 200,
                                                padding: EdgeInsets.only(
                                                    left: 30,
                                                    right: 30,
                                                    top: 5,
                                                    bottom: 5),
                                                child: Text(
                                                  "" + snapshot.data[index]
                                                      .price,
                                                  style: TextStyle(
                                                      fontSize: 17),
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
                          "Total Innsurance :",
                          style: TextStyle(fontSize: 17, color: Colors.black),
                        ),
                      ),
                      Container(
                        child: Text(
                          " " + suminnssurance.toString(),
                          style: TextStyle(fontSize: 17, color: Colors.black),
                        ),
                      )
                    ],
                  ),
                ),

              ])));
    }
  }




  Widget CarDesign() {
    return Container(
        margin: EdgeInsets.only(top: 30, left: 2, right: 2),
        child: Material(
            elevation: 0.0,
            borderRadius: BorderRadius.all(Radius.circular(0.0)),
            color: Colors.white,
            child: Row(children: <Widget>[
              Container(
                child: Column(children: <Widget>[
                  Container(
                      padding: EdgeInsets.only(bottom: 10, top: 10, left: 10),
                      child: Image.network(
                        snapshot.data[index].carimage,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width / 2.4,
                        height: 120,
                      )),
                  Container(
                      child: Row(children: <Widget>[
                        Container(
                          //padding: (EdgeInsets.all(2)),
                          child: Row(children: <Widget>[
                            Container(
                              width: 40,
                              padding: EdgeInsets.all(2),
                              child: Icon(Icons.person),
                            ),
                            Container(
                              width: 30,
                              padding: EdgeInsets.all(5),
                              child: Text(snapshot.data[index].passenger),
                            ),
                          ]),
                        ),
                        Container(
                          child: Row(children: <Widget>[
                            Container(
                              width: 40,
                              padding: EdgeInsets.all(2),
                              child: Image.network(
                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRAnSdWWPCYXS1jmDaF_VhIPJR81UVTCZFNL1H3yByIAxd4vwx7"),
                            ),
                            Container(
                              width: 30,
                              padding: EdgeInsets.all(5),
                              child: Text(snapshot.data[index].luggage),
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
                        child: Text(snapshot.data[index].doors),
                      ),
                      Container(
                        width: 80,
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Text(snapshot.data[index].car_year),
                      ),
                    ]),
                  ),
                ]),
              ),
              Container(
                  child: Column(children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 0, right: 10, top: 10),
                      child: Text(
                        snapshot.data[index].car_model_english,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 0, right: 10, top: 0),
                      child: Text(
                        snapshot.data[index].transmission,
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),

                    Container(
                      padding:
                      EdgeInsets.only(top: 5, left: 20, bottom: 5, right: 20),
                      child: Container(
                        width: 100,
                        child: FittedBox(
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
                              Container(
                                  padding: EdgeInsets.only(left: 2, right: 2),
                                  child: Offstage(
                                      offstage: visiblecolorblue,
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
                              Container(
                                  padding: EdgeInsets.only(left: 2, right: 2),
                                  child: Offstage(
                                      offstage: visiblecolorgreen,
                                      child: (Container(
                                        padding: EdgeInsets.only(
                                            left: 2, right: 2),
                                        decoration: BoxDecoration(
                                          border: Border.all(),
                                          color: Colors.green,
                                        ),
                                        width: 30,
                                        height: 20,
                                      )))),
                              Offstage(
                                offstage: visiblecolorblack,
                                child: Container(
                                  padding: EdgeInsets.only(left: 2, right: 2),
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
                        ),
                      ),
                    ), //,),
                    Container(
                      padding:
                      EdgeInsets.only(top: 5, left: 20, bottom: 5, right: 20),
                      child: Container(
                        width: 100,
                        child: FittedBox(
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
                                      color: Colors.grey,
                                    ),
                                  ),
                                  offstage: visiblecoloewhite,
                                ),
                              ),
                              Container(
                                  padding: EdgeInsets.only(left: 2, right: 2),
                                  child: Offstage(
                                      offstage: visiblecoloewhite,
                                      child: (Container(
                                        padding: EdgeInsets.only(
                                            left: 2, right: 2),
                                        decoration: BoxDecoration(
                                          border: Border.all(),
                                          color: Colors.yellow,
                                        ),
                                        width: 30,
                                        height: 20,
                                      )))),

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
                                  )),
                              Offstage(
                                offstage: visiblecolorgold,
                                child: Container(
                                  padding: EdgeInsets.only(left: 2, right: 2),
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                    color: Colors.orangeAccent,
                                  ),
                                  width: 30,
                                  height: 20,
                                ),
                              ),
                              //,padding: EdgeInsets.only(left: 50,right: 10,top: 10)),
                            ],
                          ),
                        ),
                      ),
                    ), //,),
                    Container(
                      padding: EdgeInsets.all(0),
                      child: Text('' +
                          snapshot.data[index].car_price_per_day +
                          ' '+snapshot.data[index].coin,


                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ])),
            ])));
  }
}