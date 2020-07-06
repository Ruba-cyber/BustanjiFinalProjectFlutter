import 'dart:convert';

import 'package:devicepreview/AppTranslation/AppTranslation.dart';
import 'package:devicepreview/Offers/OffersData.dart';
import 'package:devicepreview/WidthAndHeighTWidget/Size_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:devicepreview/Steps_Of_Reservation/ChooseCar.dart';
import '../CustomerData.dart';
import '../ReservationData.dart';
import '../Urls.dart';

import 'package:http/http.dart' as http;

class SearchDesign extends StatefulWidget {
  @override
  _SearchDesignState createState() => _SearchDesignState();
}

class _SearchDesignState extends State<SearchDesign> {
  var numberofpassanger = "0", numberofluggage = "0", carcategory = "";
  int numpassanger = 0, numluggage = 0;
  String flag1 = "0", flag2 = "0", flag3 = "0", flag4 = "0";
  bool vis = true, vissearch = true;
  TextDirection textDirection;

  final button = new GlobalKey();
  int limitpassanger, intlimitluggage;

  void incrementluggage() {
    if (numluggage < intlimitluggage) {
      print("less");
      setState(() {
        numluggage = numluggage + 1;
        numberofluggage = "" + numluggage.toString();
        print(num);
        vis = true;
      });
    } else {
      print("More");
      setState(() {
        numluggage = numluggage;
        numberofluggage = "" + numluggage.toString();
        vissearch = false;
      });
    }
  }

  void decrementLuggage() {
    if (numluggage > 0) {
      print("less");
      setState(() {
        numluggage = numluggage - 1;
        numberofluggage = "" + numluggage.toString();
        vissearch = false;
      });
    } else {
      print("More");
      setState(() {
        numluggage = 0;
        numberofluggage = "" + numluggage.toString();
        vissearch = true;
        //  numberofpassanger=num as String;
      });
    }
  }

  void incrementpassanger() {
    if (numpassanger < limitpassanger) {
      print("less");
      setState(() {
        numpassanger = numpassanger + 1;
        numberofpassanger = "" + numpassanger.toString();
        vissearch = false;
        print(num);
      });
    } else {
      print("More");
      setState(() {
        numpassanger = numpassanger;
        vissearch = false;
        //  numberofpassanger=num as String;
      });
    }
  }

  void decrementPassanger() {
    if (numpassanger > 0) {
      print("less");
      setState(() {
        numpassanger = numpassanger - 1;
        numberofpassanger = "" + numpassanger.toString();
        vissearch = false;
      });
    } else {
      print("More");
      setState(() {
        numpassanger = 0;
        numberofpassanger = "" + numpassanger.toString();
        vissearch = false;
        //  numberofpassanger=num as String;
      });
    }
  }

  Future<String> Car_Category() async {
    var url = await http.get(Urls.getcategory);

    var user = json.decode(url.body);
    ReservationData.CarCategory.clear();
    ReservationData.Car_Catgory_id.clear();
    ReservationData.CarYear.add(ApplicationLocalizations .of(context).translate("All"),);

    for (var i in user) {
      ReservationData.CarCategory.add(i["category_name"]);
      ReservationData.Car_Catgory_id.add(i["category_id"]);
    }
  }

  Future<String> Car_Year() async {
    var url = await http.get(Urls.getyear);

    var user = json.decode(url.body);
    ReservationData.CarYear.clear();
     ReservationData.CarYear.add(ApplicationLocalizations .of(context).translate("All"),);
    for (var i in user) {
      ReservationData.CarYear.add(i["car_year"]);
    }
  }

  Future<int> Passanaserandluggage() async {
    var url = await http.get(Urls.getpassangerandluggage);

    var user = json.decode(url.body);
    String limitpassanger1 = user[0]["MAX(passenger)"];
    limitpassanger = int.parse(limitpassanger1);
    String intlimitluggage1 = user[0]["MAX(luggage)"];
    intlimitluggage = int.parse(intlimitluggage1);

    print(limitpassanger);
  }

  Future<List<OffersData>> AllCar() async {
    print("Data");
    List<OffersData> offerslist = [];

    var url = await http.post(Urls.searchresult, body: {
      'flag1': flag1,
      'flag2': flag2,
      'flag3': flag3,
      'flag4': flag4,
      'caryear1': ReservationData.caryear,
      'groupid1': carcategory,
      'luggage1': numluggage.toString(),
      'passenger1': numpassanger.toString()
    });
    var Offers = json.decode(url.body);
    print(flag1 + '' + flag2 + '' + flag3 + '' + flag3);
    //offerslist.clear();
    for (var u in Offers) {
      OffersData offers = OffersData(
          u["car_model_english"],
          u["car_year"],
          u["luggage"],
          u["passenger"],
          u["doors"],
          u["car_image"],
          u["transmission"],
          u["price"],
          u["price_dollar"],
          u["euro_price"],
          u["red"],
          u["green"],
          u["blue"],
          u["black"],
          u["white"],
          u["sliver"],
          u["gold"],
          u["yellow"],
          u["group_id"]);
      offerslist.add(offers);
    }
    print(offerslist);

    return offerslist;
  }

  @override
  Widget build(BuildContext context) {
//    if(TextDirections1.textDirections=="rtl"){textDirection=TextDirection.rtl;
//    }else{textDirection=TextDirection.ltr;}

    Car_Category();
    Car_Year();
    Passanaserandluggage();

    return Container(
//    if (search.length == 0) {setState(() {
//      vissearch=false;;
//    });}else{setState(() {
//      vissearch=true;
//    });}
        child: SingleChildScrollView(
            child: Container(
                child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: Colors.white,
                    child: Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      child: Column(children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          width: MediaQuery.of(context).size.width,
                          child: FittedBox(fit: BoxFit.scaleDown,
                            child: SafeArea(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                      width: Size1.width_text,
                                      margin: EdgeInsets.only(
                                          bottom: 10,
                                          top: 10,
                                          left: 10,
                                          right: 10),
                                      child: Text(
                                        ApplicationLocalizations.of(context)
                                            .translate("Car_Category"),
                                        style: TextStyle(
                                            fontSize: Size1.Font_size,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      )),
                                  Container(
                                      width: Size1.width_text,
                                      padding: EdgeInsets.only(
                                          left: 10,
                                          top: 10,
                                          right: 10,
                                          bottom: 10),
                                      decoration: BoxDecoration(
                                        border: Border.all(),
                                        color: Colors.white,
                                      ),
                                      child: new DropdownButton<String>(
                                        isDense: true,
                                        hint: FittedBox(fit: BoxFit.scaleDown,
                                          child: Container(
                                            width: Size1.width_of_dropdown,
                                            child: new Text(
                                              ReservationData.carcategory,
                                              style:
                                                  TextStyle(color: Colors.black),
                                            ),
                                          ),
                                        ),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            for (int i = 0;
                                                i <
                                                    ReservationData
                                                        .CarCategory.length;
                                                i++) {
                                              if (ReservationData
                                                      .CarCategory[i] ==
                                                  newValue) {
                                                setState(() {
                                                  carcategory = ReservationData
                                                      .Car_Catgory_id[i]
                                                      .toString();
                                                  ReservationData.carcategory =
                                                      newValue;
                                                });
                                              }
                                            }
                                            vissearch = false;
                                          });
                                        },
                                        items: ReservationData.CarCategory.map(
                                            (item) {
                                          return new DropdownMenuItem<String>(
                                            value: item.toString(),
                                            child: new Text(
                                              item.toString(),
                                            ),
                                          );
                                        }).toList(),
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(
                              bottom: 10, top: 10, left: 10, right: 10),
                          child: FittedBox(fit: BoxFit.scaleDown,
                            child: 
                            SafeArea(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                textDirection: textDirection,
                                children: <Widget>[
                                  Container(
width:  Size1.width_text,
                                      margin:
                                          EdgeInsets.only(bottom: 10, top: 10,left: 10,right: 10),
                                      child: Text(
                                        ApplicationLocalizations.of(context)
                                            .translate("Car_Year"),
                                        textDirection: textDirection,
                                        style: TextStyle(
                                            fontSize: Size1.Font_size,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      )),
                                  Container(
                                      width:
                                      Size1.width_text,
                                      padding: EdgeInsets.only(left: 10, top: 10,right: 10),
                                      decoration: BoxDecoration(
                                        border: Border.all(),
                                        color: Colors.white,
                                      ),
                                      child: new DropdownButton<String>(
                                        isDense: true,
                                        hint: FittedBox(fit: BoxFit.scaleDown,
                                          child: Container(
                                            width:Size1.width_of_dropdown,
                                            child: Padding(
                                              padding:
                                              const EdgeInsets.only(
                                                  left: 5, right: 5),
                                              child: new Text(
                                                ReservationData.caryear,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                 ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            vissearch = false;
                                            ReservationData.caryear = newValue;
                                          });
                                        },
                                        items:
                                            ReservationData.CarYear.map((item) {
                                          return new DropdownMenuItem<String>(
                                            value: item.toString(),
                                            child: new Text(
                                              item.toString(),
                                            ),
                                          );
                                        }).toList(),
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width,
                            margin:
                                EdgeInsets.only(top: 10, left: 10, right: 10),
                            child: FittedBox(fit: BoxFit.scaleDown,
                              child: SafeArea(
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,

                                    children: <Widget>[
                                      Container(
                                        width:Size1.width_text,
                                        child: Text(
                                          ApplicationLocalizations.of(context)
                                              .translate("Number_Of_Passanger"),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: Size1.Font_size),

                                        ),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.only(left: 5, right: 5),
                                        child: 
                                        SafeArea(
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,

                                            children: <Widget>[
                                              Container(
                                                margin: EdgeInsets.only(bottom: 10),
                                                decoration: BoxDecoration(
                                                  border: Border.all(),
                                                  color: Colors.white,
                                                ),
                                                width: Size1.width_of_Search,
                                                height: Size1.height_of_Search,
                                                padding: EdgeInsets.only(
                                                    bottom: 0, top: 0),
                                                child: FittedBox(fit: BoxFit.scaleDown,
                                                  child: Container(
                                                    width: Size1.width_of_Search,
                                                    height: Size1.height_of_Search,
                                                    child: RaisedButton(
                                                      color: Colors.indigo[900],
                                                      onPressed: () {
                                                        incrementpassanger();
                                                      },
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets.all(2),
                                                        child: Text(
                                                          "+",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize:20,
                                                              color: Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(bottom: 5),
                                                color: Colors.grey[300],
                                                width: Size1.width_of_Search,
                                                height: Size1.height_of_Search,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(top: 10,bottom: 10),
                                                  child: Container(
                                                    width: Size1.width_of_Search,
                                                    height: Size1.height_of_Search,
                                                    child: Text(
                                                      numberofpassanger.toString(),
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize:20,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(bottom: 10),
                                                decoration: BoxDecoration(
                                                  border: Border.all(),
                                                  color: Colors.white,
                                                ),
                                                width: Size1.width_of_Search,
                                                height: Size1.height_of_Search,
                                                child: RaisedButton(
                                                  color: Colors.indigo[900],
                                                  onPressed: () {
                                                    decrementPassanger();
                                                  },
                                                  padding: EdgeInsets.only(
                                                      bottom: 0, top: 0),
                                                  child: Text(
                                                    "-",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize:20,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ]),
                              ),
                            )),
                        Container(
                            width: MediaQuery.of(context).size.width,
                            margin:
                                EdgeInsets.only(top: 10, left: 10, right: 10),
                            child: FittedBox(
                             
                              child: SafeArea(
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,

                                    children: <Widget>[
                                      Container(
                                          width:Size1.width_text,
                                          child: Text(
                                              ApplicationLocalizations.of(context)
                                                  .translate("Number_Of_Luggage"),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: Size1.Font_size),
                                              )),
                                      Container(
                                        child: SafeArea(
                                          child: Row(

                                            children: <Widget>[
                                              Container(
                                                margin: EdgeInsets.only(bottom: 10,top: 10),
                                                decoration: BoxDecoration(
                                                  border: Border.all(),
                                                  color: Colors.white,
                                                ),
                                                width: Size1.width_of_Search,
                                                height: Size1.height_of_Search,
                                                padding: EdgeInsets.only(
                                                    bottom: 0, top: 0),
                                                child: FittedBox(fit: BoxFit.scaleDown,
                                                  child: Container(
                                                    width: Size1.width_of_Search,
                                                    height: Size1.height_of_Search,
                                                    child: RaisedButton(
                                                      color: Colors.indigo[900],
                                                      onPressed: () {
                                                        incrementluggage();
                                                      },
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets.only(top: 10,bottom: 10),
                                                        child: Text(
                                                          "+",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              color: Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(bottom: 10,top: 10),
                                                color: Colors.grey[300],
                                                width: Size1.width_of_Search,
                                                height: Size1.height_of_Search,



                                                  child: Padding(
                                                    padding: const EdgeInsets.only(top: 10,bottom:10),
                                                    child: Text(
                                                      numberofluggage.toString(),
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize:20,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                ),

                                              Container(
                                                margin: EdgeInsets.only(bottom: 10,top: 10),
                                                decoration: BoxDecoration(
                                                  border: Border.all(),
                                                  color: Colors.white,
                                                ),
                                                width: Size1.width_of_Search,
                                                height: Size1.height_of_Search,
                                                child: RaisedButton(
                                                  color: Colors.indigo[900],
                                                  onPressed: () {
                                                    decrementLuggage();
                                                  },
                                                  padding: EdgeInsets.only(
                                                      bottom: 0, top: 0),
                                                  child: Text(
                                                    "-",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ]),
                              ),
                            )),
                        Container(
                          margin: EdgeInsets.only(left: 30, top: 20, right: 30),
                          child: RaisedButton(
                            color: Colors.indigo[900],
                            onPressed: () {
                              print('caryear1' + ReservationData.caryear + '');
                              print('groupid1' + ReservationData.carcategory);
                              print('luggage1' + numberofluggage.toString());
                              print('Passanger' + numberofpassanger.toString());
                              setState(() {
                                vissearch = true;
                                if (numpassanger > 0) {
                                  setState(() {
                                    flag3 = "1";
                                  });
                                } else {
                                  setState(() {
                                    flag3 = "0";
                                  });
                                }

                                if (numluggage > 0) {
                                  setState(() {
                                    flag4 = "1";
                                  });
                                } else {
                                  setState(() {
                                    flag4 = "0";
                                  });
                                }
                                if (ReservationData.caryear ==
                                    ApplicationLocalizations.of(context)
                                        .translate("All")) {
                                  setState(() {
                                    flag2 = "0";
                                  });
                                } else {
                                  setState(() {
                                    flag2 = "1";
                                  });
                                  ;
                                }
                                if (ReservationData.carcategory ==
                                    ApplicationLocalizations.of(context)
                                        .translate("All")) {
                                  setState(() {
                                    flag1 = "0";
                                  });
                                } else {
                                  setState(() {
                                    flag1 = "1";
                                  });
                                }
                              });
                              AllCar();
                            },
                            child: Container(
                              height: Size1.height_of_button,
                              child: Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Text(
                                  ApplicationLocalizations.of(context)
                                      .translate("Filter"),
                                  style: TextStyle(color: Colors.white),

                                ),
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          ),
                        ),
                        Container(
                          child: Data(),
                        ),
                      ]),
                    )))));
  }

  Widget Data() {
    if (vissearch == false) {
    return Container(child: Center(child:Text(
      ApplicationLocalizations.of(context).translate("No_Result_Found"),
      style: TextStyle(fontSize: Size1.Font_size),)),);}

  else{
    if (vissearch == true) {
      return Container(
        child: FutureBuilder(
            future: AllCar(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.data == null) {
                return Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Center(
                      child: Text( ApplicationLocalizations.of(
                          context)
                          .translate(
                          "Loading"),
                        style: TextStyle(fontSize: 20),
                      ),
                    ));
              } else {
                return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    
                    return Container(
                      width: double.infinity,
                      height: 230,
                      child: ChooseCar(
                          snapshot,
                          index,
                         ApplicationLocalizations.of(context).translate("Warning_Reserve_Without_Offer"),"No Offer"),
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 6),
                    );
                  },
                );
              }
            }),
      );
    }
  }
}}
// }
