
import 'package:devicepreview/AppTranslation/AppTranslation.dart';
import 'package:devicepreview/CustomTexts/Cancel_Reservation_text.dart';
import 'package:devicepreview/ReservationInformationDesign/ReservationInfo.dart';
import 'package:devicepreview/WidthAndHeighTWidget/Size_layout.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Urls.dart';
import 'MyBooking.dart';
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
  FocusNode _focusNode = new FocusNode();
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
      confirm = ApplicationLocalizations.of(context).translate(
          "Reservation_Not_Confirmed");
    } else {
      confirm = ApplicationLocalizations.of(context).translate(
          "Reservation_Confirmed");
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
  }

  Future CancelReservation() async {
    print("Enter  Cancel");

    var data = Urls.cancelres;

    http.Response response = await http.post(data, body: {
      'resrvationID': snapshot.data[index].resid,
      'reason': controll.text.toString(),
    });
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => (MyBooking()),
        ));
  }

  Future<List<InnsuranceReservationData>> Innsurance() async {
    print("DataPass");
    List<InnsuranceReservationData> innsurance = [];

    var url = Urls.getinssurance;


    http.Response response = await http
        .post(url, body: {'reservation_id': snapshot.data[index].resid});
    print(response.body);
    innsurance.clear();

    var Offers = json.decode(response.body);
    suminnssurance = 0.0;
    for (var u in Offers) {
      InnsuranceReservationData in1 = InnsuranceReservationData(
          u["name_english"], u["insurance_price"]);
      innsurance.add(in1);
      try {
        double price = double.parse(u["insurance_price"]);
        suminnssurance = suminnssurance+(price);
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
    return
      showDialog(
        context: context,
        builder: (context) {
          return Container(width:400,height: 400,
              child: AlertDialog(
                  title: SafeArea(
                    child: Container(width: Size1.Font_size,
                        child: Text(
                            ApplicationLocalizations.of(context).translate("Warning")),
                      ),
                  ),

                  content: FittedBox(
                    child: Text(ApplicationLocalizations.of(context).translate(
                        "Are_You _sure _want _to _Cancel _This_Reservation ?")),
                  ),
                  actions: <Widget>[
                    Row(children: <Widget>[
                      MaterialButton(
                          elevation: 5.0,
                          onPressed: () {
                            Navigator.of(context).pop();
                            AlertDialogReason(context);
//                        Navigator.push(
//                            context,
//                            MaterialPageRoute(
//                              builder: (context) => (),
//                            ));

                          },
                          child: Text(
                              ApplicationLocalizations.of(context).translate(
                                  "ok"))),
                      MaterialButton(
                          elevation: 5.0,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            (ApplicationLocalizations.of(context).translate(
                                "Cancel")),
                          )
                      )
                    ])
                  ]),
            );

        });
  }

  AlertDialogReason(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text(
                  ApplicationLocalizations.of(context).translate("Warning")),
              content: Container(width: MediaQuery
                  .of(context)
                  .size
                  .width,
                  child: SingleChildScrollView(
                    child: Wrap(
                        direction: Axis.vertical, children: <Widget>[
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
                                ), child: Cancel_Reservation_text(
                                  inputBoxController: controll,
                                  focusNod: _focusNode,
                                  textSize: 12.0,
                                  textFont: "Nexa_Bold",
                                )
                                    .textFieldWithOutPrefix(
                                    ApplicationLocalizations.of(context)
                                        .translate(
                                        "Please_Enter_Reason"),
                                    ApplicationLocalizations.of(context)
                                        .translate(
                                        "Please_Enter_Reason")),
                              ),
                            ]),


                          ))
                    ]),
                  )),
              actions: <Widget>[
                Row(children: <Widget>[
                  MaterialButton(
                    elevation: 5.0,
                    onPressed: () {
                      Navigator.of(context).pop();

                      CancelReservation();
                    },
                    child: Text(
                      ApplicationLocalizations.of(context).translate("ok"),),),
                  MaterialButton(
                      elevation: 5.0,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                          ApplicationLocalizations.of(context).translate(
                              "Cancel"))),

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
        width: double.infinity, child: Material(
        elevation: 5,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        color: Colors.white,
        child: Container(


            margin: EdgeInsets.all(5),
            child: Column(

                children: <Widget>[
                  //Container(child: FirstDesign())


                  Container(child: FirstDesign(),)]))));
  }


  Widget FirstDesign() {
    return SafeArea(
      child: Container(width: double.infinity,
        child: Column(children: <Widget>[
          Container(width: double.infinity,
            child: ResrevationInfo(
                ApplicationLocalizations.of(context).translate("Resid")+":",
                snapshot.data[index].resid),),
          Container(width: double.infinity,
            child: ResrevationInfo(
                ApplicationLocalizations.of(context).translate("Pickup_date")+
                    "  && "+ApplicationLocalizations.of(context).translate(
                    "Pickup_time"), snapshot.data[index].pickup_date+", "+
                snapshot.data[index].pickuptime),),
          Container(width: double.infinity,
            child: ResrevationInfo(
                ApplicationLocalizations.of(context).translate("Return_date")+
                    "&&"+ApplicationLocalizations.of(context).translate(
                    "Return_Time"), snapshot.data[index].return_date+" ,"+
                snapshot.data[index].returntime),),
          Container(width: double.infinity,
            child: ResrevationInfo(
                ApplicationLocalizations.of(context).translate(
                    "Total_All_Price"),
                snapshot.data[index].total_price_after_tax),),
          Container(width: double.infinity,
            child: ResrevationInfo(
                ApplicationLocalizations.of(context).translate(
                    "Reservation_Status"), confirm),),

          Container(
            width:double.infinity,child: CarDesign(),),


          Container(width:Size1.width_text/1.5,
              child: FittedBox(
                child: SafeArea(
                  child: Row(
                      crossAxisAlignment:CrossAxisAlignment.center,children: <Widget>[
                    Container(
                        padding:
                        EdgeInsets.only(
                             bottom: 3, top: 3),
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
                                          snapshot.data[index].offername,
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
                                              .car_model_english,snapshot.data[index].options_status,
                                          snapshot.data[index].insurance_status)));
                        }, child: Row(    crossAxisAlignment:CrossAxisAlignment.center,children: <Widget>[
                          Container(child: Icon(Icons.arrow_back_ios,
                            color: Colors.indigo,size: Size1.size_icon,)),
                          Container(
                              padding: EdgeInsets.only(
                                  left: 2, right: 2),
                              child: Text( ApplicationLocalizations.of(context).translate("More_Info") ,
                                style: TextStyle(fontSize: Size1.Font_size,color: Colors.indigo[900]),))]))
                    )]),
                ),
              )),
          Container(width:Size1.width_text/1.5,
              child: FittedBox(
                child: SafeArea(
                  child: Row(
                      crossAxisAlignment:CrossAxisAlignment.center,children: <Widget>[
                    Container(
                        padding:
                        EdgeInsets.only(
                            bottom: 3, top: 3),
                        child: FlatButton(onPressed: () {
                          AlertDialogWarning(context);
                        }, child: Row(    crossAxisAlignment:CrossAxisAlignment.center,children: <Widget>[
                          Container(child: Icon(Icons.cancel,
                            color: Colors.indigo,size: Size1.size_icon,)),
                          Container(
                              padding: EdgeInsets.only(
                                  left: 2, right: 2),
                              child: Text( ApplicationLocalizations.of(context).translate("Cancel_Reservation") ,
                                style: TextStyle(fontSize: Size1.Font_size,color: Colors.indigo[900]),))]))
                    )]),
                ),
              ))]),

      ),


    );
//]
//    }}

  }
  Widget CarDesign(){
    return Container(
        width:double.infinity *2,
        margin:
        EdgeInsets.only(top: 30, left: 5, right: 5),
//        child: Material(
//          elevation: 5.0,
//          borderRadius:
//          BorderRadius.all(Radius.circular(10.0)),
          color: Colors.white,
          child: FittedBox(
            child: SafeArea(

              child: Row(children: <Widget>[
                Container(
                  child: Column(
                      crossAxisAlignment:CrossAxisAlignment.start,children: <Widget>[
                    Container(
                        padding: EdgeInsets.only(
                            bottom: 10, top: 10, left: 10),
                        child: Image.network(
                         snapshot.data[index].carimage,
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
                    Container(margin: EdgeInsets.only(left: 10,right: 10),
                        child:
                        FittedBox(fit: BoxFit.scaleDown,

                          child: Row(children: <Widget>[
                            Container(
                              //padding: (EdgeInsets.all(2)),
                              child: FittedBox(fit: BoxFit.scaleDown ,
                                child: Row(children: <Widget>[
                                  Container(
                                    width: Size1.size_icon ,
                                    padding: EdgeInsets.all(2),
                                    child: Icon(Icons.person),
                                  ),
                                  Container(
                                    width: Size1.size_icon,
                                    padding: EdgeInsets.all(5),
                                    child: Text(
                                      snapshot.data[index].passenger),
                                  ),
                                ]),
                              ),
                            ),
                            Container(
                              child: Row(children: <Widget>[
                                Container(

                                  padding: EdgeInsets.all(4),
                                  child: Image.network(
                                    "https://encrypted-tbn0.gstatic.com/"
                                        "images?q=tbn%3AANd9GcRAnSdWWPCYXS1jmDaF_VhIPJR81UVTCZFNL1H3yByIAxd4vwx7",
                                    width: Size1.size_icon , ),
                                ),
                                Container(
                                  width: Size1.size_icon,
                                  padding: EdgeInsets.all(5),
                                  child:
                                  Text(snapshot.data[index].luggage),
                                ),
                              ]),
                            ),
                          ]),
                        )),

                    Container(margin: EdgeInsets.only(left: 10,right: 10),
                      child: Row(children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(2),
                          child: Image.network(
                            "https://3.imimg.com/data3/VT/QG/GLADMIN-140882/car-door-250x250.jpg",width: Size1.size_icon *5,),
                          width: Size1.size_icon,  ),
                        Container(
                          width: Size1.size_icon,
                          padding: EdgeInsets.all(5),
                          child: Text(snapshot.data[index].doors,
                              style:TextStyle( fontSize:Size1.Font_size,)),
                        ),
                        Container(
                          width:80,
                          padding: EdgeInsets.only(left: 15,right: 15),
                          child: Text(
                            snapshot.data[index].car_year,
                            style: TextStyle(fontSize: Size1.Font_size),
                          ),
                        ),
                      ]),
                    ),

                  ]),
                ),
                Container(margin: EdgeInsets.only(left: 30,right: 30),
                    child: Column(
                        crossAxisAlignment:CrossAxisAlignment.start,
                        children: <Widget>[

                          Container(
                            padding: EdgeInsets.only(
                                left: 10, right: 10, top: 10),
                            child: Text(
                             snapshot.data[index].car_model_english,
                              style: TextStyle(
                                  fontSize: Size1.Font_size,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                left: 10, right: 10, top: 0),
                            child: Text(
                             snapshot.data[index].transmission,
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
                            child: Container(width: MediaQuery.of(context).size.width,
                              child: Flexible(
                                child: Row(mainAxisAlignment: MainAxisAlignment.start,
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
                          ), //,),
                          Container(
                            padding: EdgeInsets.only(
                                top: 5,
                                left: 20,
                                bottom: 5,
                                right: 20),
                            child: Container(width: MediaQuery.of(context).size.width,

                              child: Flexible(
                                child: Row(mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: 30,
                                      height: 20,
                                      child: Offstage(
                                        child: Container(padding: EdgeInsets.only(
                                            left: 2, right: 2),
                                          decoration: BoxDecoration(
                                            border: Border.all(),
                                            color: Colors.grey,
                                          ),
                                        ),
                                        offstage:
                                        visiblecolorgrey,
                                      ),
                                    ),
                                    Container(
                                        padding: EdgeInsets.only(left: 2, right: 2),
                                        child: Offstage(
                                            offstage: visiblecoloryellow,

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
                                        offstage:
                                       visiblecoloewhite,
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              left: 2, right: 2),
                                          decoration: BoxDecoration(
                                            border: Border.all(),
                                            color: Colors.white,
                                          ),
                                          width: 30,
                                          height: 20,
                                        )),
                                    Offstage(
                                      offstage:
                                    visiblecolorgrey,
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
                          ),
                          //,),
                          Container(
                            padding: EdgeInsets.all(0),
                            child: Text(
                              snapshot.data[index].car_price_per_day +' '+snapshot.data[index].coin,

                              style: TextStyle(
                                  fontSize: Size1.Font_size,
                                  color: Colors.black, fontWeight: FontWeight.bold),
                            ),
                          ),


                        ])),
              ]),
            ),
          ));
        //));
  }


  }
