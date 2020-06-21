import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:language/AppTranslation/AppTranslation.dart';
import 'package:language/CustomerInfo/CustomerData.dart';
import 'package:language/ReservationSteps/ChooseCar.dart';
import 'package:language/Urls/BustanjiUrl.dart';

import 'OfferData.dart';
import 'OfferDataAvaliable.dart';




class Offer extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Offer> {
  String PeriodDataOffer = 'No Offers';
  bool Offerorallcar = true;

  Future<List<OfferData>> Data() async {
    print("Data");
    List<OfferData> offerslist = [];
    offerslist.clear();
    var url = BustanjiUrls.searchcaroffer;

    http.Response response = await http
        .post(url, body: {'CATEGORY_ID': OfferDataAvaliable.category_id});
    offerslist.clear();
    var Offers = json.decode(response.body);

    for (var u in Offers) {
      if (CustomerData.Language == "Arabic") {
        OfferData offers = OfferData(
            u["car_model_arabic"],

            u["car_year"],
            u["luggage"],
            u["passenger"],
            u["doors"],
            u["car_image"],
            u["transmission"],
            OfferDataAvaliable.price,
            OfferDataAvaliable.dollar_price,
            OfferDataAvaliable.euro_price,
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
      else {
        OfferData offers = OfferData(
            u["car_model_english"],
            u["car_year"],
            u["luggage"],
            u["passenger"],
            u["doors"],
            u["car_image"],
            u["transmission"],
            OfferDataAvaliable.price,
            OfferDataAvaliable.dollar_price,
            OfferDataAvaliable.euro_price,
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
    }
    return offerslist;
  }


  Future<List<OfferData>> AllCar() async {
    print("Data");
    List<OfferData> offerslist = [];
    var url = await http.get(BustanjiUrls.searchAllcar);

    var Offers = json.decode(url.body);
    for (var u in Offers) {




        OfferData offers = OfferData(
            u["car_model_english"],
            u["car_year"],
            u["luggage"],
            u["passenger"],
            u["doors"],
            u["car_image"],
            u["transmission"],
            u["price"],
            u["dollar_price"],
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


  void AllCarOrOffer() {
    if (OfferDataAvaliable.offername == null) {

     // PeriodDataOffer =  AppTranslations.of(context).text("All_Car");
      setState(() {
        Offerorallcar = false;
      });
    }
    else{setState(() {
      Offerorallcar=true;
    });}
  }

  @override
  Widget build(BuildContext context) {
    AllCarOrOffer();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: (
            SingleChildScrollView(
              child: Container(
                child: Column(
                    children: <Widget>[
                      Container(
                          margin:
                          EdgeInsets.only(
                              top: 10, left: 10, right: 10, bottom: 0),
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          child: Material(
                              elevation: 5.0,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(10.0)),
                              color: Colors.brown[200],

                              child: Center(
                                child: Text(
                                  PeriodDataOffer,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),))),


                      Container(child: OfferFuture(),),
                      Container(child: AllCarFuture(),)
                    ]),
              ),
            )));
  }

  Widget OfferFuture() {
    if (Offerorallcar == true) {
      return Container(

        child: FutureBuilder(
            future: Data(),
            builder: (BuildContext context,
                AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.data == null) {
                return Container(margin: EdgeInsets.only(top: 100, bottom: 100),
                  child: Center(
                    child: Text("Loading",
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
                    print(snapshot.data[index].price);
                    return Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      height: 230,

                      child: ChooseCar(
                          snapshot,
                          index,
                          ApplicationLocalizations.of(context).translate("Warning_offer"),
                          " Offer"),
                      padding: EdgeInsets.symmetric(
                          horizontal: 0, vertical: 6),

                    );
                  },
                );
              }
            }),
      );
    }
  }

  Widget AllCarFuture() {
    if (Offerorallcar == false) {
      return Container(

        child: FutureBuilder(
            future: AllCar(),
            builder: (BuildContext context,
                AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.data == null) {
                return Container(margin: EdgeInsets.only(top: 100, bottom: 100),
                  child: Center(
                    child: Text("Loading .... ",
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
                    print(snapshot.data[index].price);
                    return Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      height: 230,

                      child: ChooseCar(
                          snapshot,
                          index,"",
                          "No Offer"),
                      padding: EdgeInsets.symmetric(
                          horizontal: 0, vertical: 6),

                    );
                  },
                );
              }
            }),
      );
    }
  }
}