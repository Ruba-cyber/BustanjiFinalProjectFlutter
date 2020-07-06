import 'dart:convert';
import 'package:devicepreview/AppTranslation/AppTranslation.dart';
import 'package:devicepreview/Options/OptionData.dart';
import 'package:devicepreview/ReservationInformationDesign/Airport.dart';
import 'package:devicepreview/ReservationInformationDesign/ReservationInfo.dart';
import 'ContinueBooking.dart';

import 'package:devicepreview/WidthAndHeighTWidget/Size_layout.dart';
import 'package:flutter/material.dart';
import 'package:devicepreview/MakeBooking/MakeBooking.dart';
import '../CustomerData.dart';
import '../ReservationData.dart';
import '../Urls.dart';
import 'package:devicepreview/Innsurance/InssuranceData.dart';
import 'package:devicepreview/Innsurance/InssuranceDesign.dart';
import 'package:devicepreview/Options/OptionDesign.dart';

import 'package:devicepreview/ReservationInformationDesign/CarDesign.dart';
import 'package:http/http.dart' as http;

class SecondStepChooseOptionAndInnsyranc extends StatefulWidget {
  @override
  _OffersResultState createState() => _OffersResultState();
}

class _OffersResultState extends State<SecondStepChooseOptionAndInnsyranc> {
  List<OptionData> OptionList = [];
  List<InssurranceData> inssurance = [];
  bool visop = false, visinssurance = false;

  Future<List<OptionData>> Data() async {
    var url = await http.get(Urls.options);

    var Offers = json.decode(url.body);
    OptionList.clear();

    for (var u in Offers) {
      if (CustomerData.Language == "Arabic") {
        OptionData d = new OptionData(
            u["option_name_arabic"],
            u["option_limit"],
            u["option_image"],
            u["price"],
            u["price_dollar"],
            u["euro_price"]);
        OptionList.add(d);
      } else {
        OptionData d = new OptionData(
            u["option_name_english"],
            u["option_limit"],
            u["option_image"],
            u["price"],
            u["price_dollar"],
            u["euro_price"]);

        OptionList.add(d);
      }
    }
    return OptionList;
  }

  Future<List<InssurranceData>> InnsuranceDataoption() async {
    var url = await http.get(Urls.innsurance);
    var Ins = json.decode(url.body);
    inssurance.clear();

    for (var u in Ins) {
      if (CustomerData.Language == "Arabic") {
        InssurranceData innsuranceData = new InssurranceData(u["name_arabic"],
            u["price"], u["euro_price"], u["price_dollar"], u["option_image"]);

        inssurance.add(innsuranceData);
      } else {
        InssurranceData innsuranceData = new InssurranceData(u["name_english"],
            u["price"], u["euro_price"], u["price_dollar"], u["option_image"]);
        inssurance.add(innsuranceData);
      }
      print(u["name_english"]);
    }
    return inssurance;
  }

  Future<bool> _onWillPop() async {
    return (await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => new MakeBooking(ReservationData.resstatus),
        )));
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: _onWillPop,
        child: new Scaffold(
            appBar: new AppBar(
              backgroundColor: Colors.indigo[900],
              title: new Text(""),
            ),
            resizeToAvoidBottomInset: false,
            body: SingleChildScrollView(

                          child: Container(
                              width:double.infinity,
                              child: Container(
                                  child: Material(
                                      elevation: 5.0,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      child: Column(children: <Widget>[
                                     Container(
                                      margin:
                                          EdgeInsets.only(top: 30, left: 5, right: 5, bottom: 30),
                                      child: Material(
                                          elevation: 5.0,
                                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                          color: Colors.white,
                                          child: SafeArea(
                                            child: Column(children: <Widget>[
                                              Container(width:double.infinity*2,
                                                  margin:(EdgeInsets.only(top: 10,bottom: 10,left: 5,right: 5)),
                                                  child: Material(
                                                    elevation: 5.0,
                                                    borderRadius:
                                                    BorderRadius.all(Radius.circular(10.0)),
                                                    color: Colors.white,
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          width:double.infinity,
                                                          child: Container(
                                                              child: ResrevationInfo(
                                                                ApplicationLocalizations.of(context)
                                                                    .translate("PickupLoc") ,
                                                                    ":" +
                                                                ReservationData.pickuploc


                                                              ),
                                                        )),
                                                        Container(
                                                          width:double.infinity,
                                                          child: Container(
                                                              child: ResrevationInfo(
                                                                ApplicationLocalizations.of(context)
                                                                    .translate("Pickup_date") +
                                                                    " && " +
                                                                    ApplicationLocalizations.of(context)
                                                                        .translate("Pickup_time") +
                                                                    ":",
                                                                ReservationData.pickupdate +
                                                                    ' ,' +
                                                                    ReservationData.pickuptime,
                                                              )),
                                                        ),
                                                        Container(
                                                          width:double.infinity,
                                                          child: Container(
                                                              child: ResrevationInfo(
                                                                ApplicationLocalizations.of(context)
                                                                    .translate("returnloc") + ':' ,

                                                                ReservationData.returnlocation


                                                              )),
                                                        ),
                                                        Container(
                                                          width:double.infinity,
                                                          child: Container(
                                                              child: ResrevationInfo(
                                                                ApplicationLocalizations.of(context)
                                                                    .translate("Return_date") +
                                                                    " && " +
                                                                    ApplicationLocalizations.of(context)
                                                                        .translate("Return_Time") +
                                                                    ":",
                                                                ReservationData.returndate +
                                                                    ' ,' +
                                                                    ReservationData.returntime,
                                                              )),
                                                        ),
                                                        Container(child: Airport(),),
                                                        Container(
                                                          child: FlatButton(
                                                            onPressed: () {
                                                              ReservationData.caryear =  ApplicationLocalizations.of(context).translate("All") ;
                                                              ReservationData.carcategory =  ApplicationLocalizations.of(context).translate("All") ;
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          MakeBooking('No offer')));


                                                            },



                                                                child:
                                                                Container(padding: EdgeInsets.only(top: 5,bottom: 5),
                                                                  child: Text(
                                                                    ApplicationLocalizations.of(context).translate("Change"),

                                                                    style: TextStyle(
                                                                        fontSize: Size1.Font_size, color: Colors.indigo[900]),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),

                                                         ],
                                                    ),
                                                  )),
                                        Container(
                                            child: CarDesign(),
                                        ),
                                        Container(
                                              //margin: EdgeInsets.all(50),
                                              margin: EdgeInsets.only(
                                                  bottom: 10, top: 10),
                                              child: Container(
                                                width: MediaQuery.of(context).size.width,
                                                margin: EdgeInsets.only(
                                                    left: 20,
                                                    right: 20,
                                                    bottom: 10,
                                                    top: 10),
                                                child: SafeArea(
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width,
                                                    decoration: BoxDecoration(
                                                        color: Colors.indigo[900],
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(20),
                                                        )),
                                                    child: ExpansionTile(
                                                      onExpansionChanged:
                                                          ((newState) {
                                                        setState(() {
                                                          if (visop == false) {
                                                            visop = true;
                                                          } else {
                                                            visop = false;
                                                          }
                                                        });
                                                      }),
                                                      title: Text(
                                                        ApplicationLocalizations.of(
                                                                context)
                                                            .translate(
                                                                "chooseOption"),
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: Size1.Font_size,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )),
                                        Container(
                                            margin: EdgeInsets.only(top: 10),
                                            child: Option(),
                                        ),
                                        SafeArea(
                                          child: Container(
                                              width: MediaQuery.of(context).size.width,
                                                //margin: EdgeInsets.all(50),
                                                margin: EdgeInsets.only(
                                                    bottom: 5, top: 5),
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      left: 20,
                                                      right: 20,
                                                      bottom: 5),
                                                  child: SafeArea(
                                                    child: Container(
                                                      width: Size1.width_text,
                                                      decoration: BoxDecoration(
                                                          color: Colors.indigo[900],
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(20),
                                                          )),
                                                      child: ExpansionTile(
                                                        onExpansionChanged:
                                                            ((newState) {
                                                          setState(() {
                                                            if (visinssurance ==
                                                                false) {
                                                              visinssurance = true;
                                                            } else {
                                                              visinssurance = false;
                                                            }
                                                          });
                                                        }),
                                                        title: Text(
                                                          ApplicationLocalizations.of(
                                                                  context)
                                                              .translate(
                                                                  "ChooseInnsurance"),
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: Size1.Font_size,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )),
                                        ),
                                        Container(
                                            child: Inssurance(),
                                        ),
                                        Container(
                                            margin: EdgeInsets.all(20),
                                            width: MediaQuery.of(context).size.width,
                                            height: Size1.height_of_container,
                                            child: RaisedButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ContinueBooking()));
                                              },
                                              child: Text(
                                                ApplicationLocalizations.of(
                                                        context)
                                                    .translate("Continue"),
                                                style: TextStyle(
                                                    fontSize: Size1.Font_size,
                                                    color: Colors.white),
                                              ),
                                              color: Colors.indigo[900],
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(10))),
                                            ),
                                        ),
                                        Container(
                                            child: FlatButton(
                                              onPressed: () {
                                                ReservationData.caryear =
                                                    ApplicationLocalizations.of(
                                                            context)
                                                        .translate("All");
                                                ReservationData.carcategory =
                                                    ApplicationLocalizations.of(
                                                            context)
                                                        .translate("All");
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            MakeBooking(
                                                                'No offer')));
                                              },
                                            ),
                                        ),
                                      ]),
                                          )))])
                        ))))));

    //

//
  }

  Widget Option() {
    if (visop == true) {
      return FutureBuilder(
          future: Data(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.data == null) {
              return Container(
                  child: Center(
                child: Text(
                  ApplicationLocalizations.of(context).translate("Loading"),
                  style: TextStyle(fontSize: Size1.Font_size),
                ),
              ));
            } else {
              if (snapshot.data.length == 0) {
                return Center(
                    child: Container(
                  child: Text(
                    ApplicationLocalizations.of(context).translate("No_Option"),
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ));
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    print(snapshot.data[index].price);
                    return Container(
                      width:double.infinity,
                      height: 200,
                      child: OptionDesign(snapshot, index),
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 6),
                    );
                  },
                );
              }
            }
          });
    }
  }

  Widget Inssurance() {
    if (visinssurance == true) {
      return FutureBuilder(
          future: InnsuranceDataoption(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: Text(
                    ApplicationLocalizations.of(context).translate("Loading"),
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              );
            } else {
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  print(snapshot.data[index].price);
                  return Container(
                    child: InssuranceDesign(snapshot, index),
                    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 6),
                  );
                },
              );
            }
          });
    }
  }
}
