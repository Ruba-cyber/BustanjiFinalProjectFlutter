import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:language/AppTranslation/AppTranslation.dart';
import 'package:language/CustomerInfo/CustomerData.dart';

import 'package:language/OffersData/OfferData.dart';
import 'package:language/Reservation/ReservationData.dart';



import 'package:http/http.dart' as http;
import 'package:language/Urls/BustanjiUrl.dart';

import 'ChooseCar.dart';

class SearchDesign extends StatefulWidget {
  @override
  _SearchDesignState createState() => _SearchDesignState();
}

class _SearchDesignState extends State<SearchDesign> {
  var numberofpassanger = "0", numberofluggage = "0";
  int numpassanger = 0, numluggage = 0;
  String flag1 = "0", flag2 = "0", flag3 = "0", flag4 = "0";
  bool vis = true,vissearch=true;
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
        vis = true;
      });
    }
  }

  void decrementLuggage() {
    if (numluggage > 0) {
      print("less");
      setState(() {
        numluggage = numluggage - 1;
        numberofluggage = "" + numluggage.toString();
        vis = true;
      });
    }
     else {
      print("More");
      setState(() {
        numluggage = 0;
        numberofluggage = "" + numluggage.toString();
        vis = true;
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
        vis = true;
        print(num);
      });
    } else {
      print("More");
      setState(() {
        numpassanger = numpassanger;
        vis = true;
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
        vis = true;
      });
    } else {
      print("More");
      setState(() {
        numpassanger = 0;
        numberofpassanger = "" + numpassanger.toString();
        vis = true;
        //  numberofpassanger=num as String;
      });
    }
  }

  Future<String> Car_Category() async {
    var url = await http.get(BustanjiUrls.getcategory);

    var user = json.decode(url.body);
    ReservationData.CarCategory.clear();
    ReservationData.CarCategory.add(  ApplicationLocalizations.of(context).translate("All"),);
    for (var i in user) {
      ReservationData.CarCategory.add(i["category_name"]);
    }
  }

  Future<String> Car_Year() async {
    var url = await http.get(BustanjiUrls.getyear);

    var user = json.decode(url.body);
    ReservationData.CarYear.clear();
    ReservationData.CarYear.add(  ApplicationLocalizations.of(context).translate("All"),);
    for (var i in user) {
      ReservationData.CarYear.add(i["car_year"]);
    }
  }

  Future<int> Passanaserandluggage() async {
    var url = await http.get(BustanjiUrls.getpassangerandluggage);

    var user = json.decode(url.body);
    String limitpassanger1 = user[0]["MAX(passenger)"];
    limitpassanger = int.parse(limitpassanger1);
    String intlimitluggage1 = user[0]["MAX(luggage)"];
    intlimitluggage = int.parse(intlimitluggage1);

    print(limitpassanger);
  }

  Future<List<OfferData>> SearchDatareasult() async {
    List<OfferData> search = [];
 var url =BustanjiUrls.searchresult;
    http.Response response = await http.post(url, body: {
      'caryear1': ReservationData.caryear,
      'flag2': flag2,
      'groupid1': ReservationData.carcategory,
      'flag1': flag1,
      'luggage1': numluggage.toString(),
      'flag4': flag4,
      'passenger1': numpassanger.toString(),
      'flag3': flag3
    });
//search.clear();
var Offers = json.decode(response.body);
print("Resultogg"+Offers);
    for (var u in Offers) {
      if(CustomerData.Language=="Arabic"){
        OfferData offers = OfferData(
            u["car_model_arabic"],
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
        print(u["euro_price"]);
        print(u["price_dollar"]);
        search.add(offers);
      }

      else{//search.clear();

        OfferData offers = OfferData(
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
        print(u["euro_price"]);
        print(u["price_dollar"]);
        search.add(offers);
        print("aDD");
      }

    }
//
    print("SearchLenght"+search.length.toString());
    return search;
  }



  @override
  Widget build(BuildContext context) {


    Car_Category();
    Car_Year();Data();
    Passanaserandluggage();


    return Container(
//    if (search.length == 0) {setState(() {
//      vissearch=false;
//    });}else{setState(() {
//      vissearch=true;
//    });}
        child: SingleChildScrollView(
            child: Container(
                child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: Colors.white,
                    child: Container(margin: EdgeInsets.only(top: 10,bottom: 10),
                      child: Column(children: <Widget>[
                        Container(width: 300,
                          child: FittedBox(
                            child: Row(crossAxisAlignment: CrossAxisAlignment.start,textDirection:textDirection,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Container(
                                    width: 250,
                                    margin: EdgeInsets.only(bottom: 10, top: 10,left: 10,right: 10),
                                    child: Text(
                                       ApplicationLocalizations.of(context).translate("Car_Category"),  textDirection:textDirection,
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black),
                                    )),
                                Container(
                                    padding: EdgeInsets.only(left: 10, top: 10,right: 10,bottom: 10),
                                    decoration: BoxDecoration(
                                      border: Border.all(),
                                      color: Colors.white,
                                    ),
                                    child: new DropdownButton<String>(
                                      isDense: true,
                                      hint: FittedBox(
                                        child: Container(width: 50,
                                          child: new Text(
                                            ReservationData.carcategory,
                                            style: TextStyle(color: Colors.black),
                                          ),
                                        ),
                                      ),
                                      onChanged: (String newValue) {
                                        setState(() {
                                          vis = true;

                                          ReservationData.carcategory = newValue;
                                          print("Category Changed"+newValue+  ReservationData.carcategory);

                                        });
                                      },
                                      items:
                                          ReservationData.CarCategory.map((item) {
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
                        Container(width: 300,margin: EdgeInsets.only(bottom: 10, top: 10),
                          child: FittedBox(
                            child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,textDirection:textDirection,
                              children: <Widget>[
                                Container(
                                    width: 250,
                                    margin: EdgeInsets.only(bottom: 10, top: 10),
                                    child: Text(
                                       ApplicationLocalizations.of(context).translate("Car_Year"),  textDirection:textDirection,
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black),
                                    )),
                                Container(
                                    padding: EdgeInsets.only(left: 10, top: 10),
                                    decoration: BoxDecoration(
                                      border: Border.all(),
                                      color: Colors.white,
                                    ),
                                    child: new DropdownButton<String>(
                                      isDense: true,
                                      hint: FittedBox(
                                        child: Container(width: 50,
                                          child: new Text(
                                            ReservationData.caryear,
                                            style: TextStyle(color: Colors.black),
                                          ),
                                        ),
                                      ),
                                      onChanged: (String newValue) {
                                        setState(() {
                                          vis = true;
                                          ReservationData.caryear = newValue;
                                        });
                                      },
                                      items: ReservationData.CarYear.map((item) {
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
                        Container(width: 300,
                            margin: EdgeInsets.only(top: 10),
                            child: FittedBox(
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,textDirection:textDirection,
                                  children: <Widget>[
                                    Container(
                                      width: 200,
                                      child: Text(
                                           ApplicationLocalizations.of(context).translate("Number_Of_Passanger"),
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 18),
                                        textDirection:textDirection,
                                      ),
                                    ),
                                    Container(margin: EdgeInsets.only(left: 5,right: 5),
                                      child: Row(crossAxisAlignment: CrossAxisAlignment.start,textDirection:textDirection,
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(bottom: 10),
                                            decoration: BoxDecoration(
                                              border: Border.all(),
                                              color: Colors.white,
                                            ),
                                            width: 40,
                                            height: 40,
                                            padding: EdgeInsets.only(
                                                bottom: 0, top: 0),
                                            child: FittedBox(
                                              child: Container(
                                                width: 50,
                                                height: 50,
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
                                                      textAlign: TextAlign.center,
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
                                            margin: EdgeInsets.only(bottom: 10),
                                            color: Colors.grey[300],
                                            width: 40,
                                            height: 40,
                                            child: Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Container(
                                                width: 40,
                                                height: 40,
                                                child: Text(
                                                  numberofpassanger.toString(),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 20,
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
                                            width: 40,
                                            height: 40,
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
                                                    fontSize: 30,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                            )),
                        Container(width: 300,
                            margin: EdgeInsets.only(top: 10),
                            child: FittedBox(
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,textDirection:textDirection,
                                  children: <Widget>[
                                    Container(
                                      width: 200,
                                      child: Text(
                                         ApplicationLocalizations.of(context).translate("Number_Of_Luggage"),
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 18),
                                        textDirection:textDirection,),
                                    ),
                                    Container(
                                      child: Row(textDirection:textDirection,
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(bottom: 10),
                                            decoration: BoxDecoration(
                                              border: Border.all(),
                                              color: Colors.white,
                                            ),
                                            width: 40,
                                            height: 40,
                                            padding: EdgeInsets.only(
                                                bottom: 0, top: 0),
                                            child: FittedBox(
                                              child: Container(
                                                width: 40,
                                                height: 40,
                                                child: RaisedButton(
                                                  color: Colors.indigo[900],
                                                  onPressed: () {
                                                  incrementluggage();
                                                  },

                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(2),
                                                    child: Text(
                                                      "+",
                                                      textAlign: TextAlign.center,
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
                                            margin: EdgeInsets.only(bottom: 10),
                                            color: Colors.grey[300],
                                            width: 40,
                                            height: 40,
                                            child: Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Text(
                                                numberofluggage.toString(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(bottom: 10),
                                            decoration: BoxDecoration(
                                              border: Border.all(),
                                              color: Colors.white,
                                            ),
                                            width: 40,
                                            height: 40,
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
                                                    fontSize: 30,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                            )),
                        Container(
                          margin: EdgeInsets.only(left: 30, top: 20,right: 30),
                          child: RaisedButton(
                            color: Colors.indigo[900],
                            onPressed: () {
                              print('caryear1'+ ReservationData.caryear+'');
                              print('groupid1'+ ReservationData.carcategory);
                              print('luggage1'+ numberofluggage.toString());
                               print('Passanger'+ ReservationData.passager);

                              setState(() {

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
                                if (ReservationData.caryear ==   ApplicationLocalizations.of(context).translate("All")) {
                                  setState(() {
                                    flag2 = "0";
                                  });
                                } else {
                                  setState(() {
                                    flag2 = "1";
                                  });
                                  ;
                                }
                                if (ReservationData.carcategory ==   ApplicationLocalizations.of(context).translate("All")
                                    ) {
                                  setState(() {
                                    flag1 = "0";
                                  });
                                } else {
                                  setState(() {
                                    flag1 = "1";
                                  });
                                }

                                SearchDatareasult();
                              });

                             },
                            child: Text(
                               ApplicationLocalizations.of(context).translate("Filter"),
                              style: TextStyle(color: Colors.white),
                              textDirection:textDirection,  ),
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
//    if (vissearch == false) {
//    return Container(child: Center(child:Text(  ApplicationLocalizations.of(context).translate("No_Result_Found"),style: TextStyle(fontSize: 20),)),);}
//
//    else{

        return Container(
          child: FutureBuilder(
              future: SearchDatareasult(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.data == null) {
                  return Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Center(
                      child: Text(  ApplicationLocalizations.of(context).translate("Loading"),
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  );
                } else {
                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      print(snapshot.data[index].car_model_english);
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: 230,
                        child: ChooseCar(
                            snapshot,
                            index,
                             ApplicationLocalizations.of(context).translate("Warning_Reserve_Without_Offer"),
                            'No Offers'),
                        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 6),
                      );
                    },
                  );
                }
              }),
        );}

    }


