import 'dart:convert';

import 'package:devicepreview/AppTranslation/AppTranslation.dart';
import 'package:devicepreview/Steps_Of_Reservation/ChooseCar.dart';
import 'package:flutter/material.dart';
import 'package:devicepreview/WidthAndHeighTWidget/Size_layout.dart';
import '../CustomerData.dart';
import '../OfferDataAvaliable.dart';
import '../Urls.dart';

import 'package:http/http.dart' as http;

import 'OffersData.dart';


class Offer extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Offer> {

  bool Offerorallcar = true;
  String PeriodDataOffer = '' ;
  Future<List<OffersData>> Data() async {
    print("Data");
    List<OffersData> offerslist = [];
    offerslist.clear();
    var url = Urls.searchcaroffer;

    http.Response response = await http
        .post(url, body: {'CATEGORY_ID': OfferDataAvaliable.category_id});
    offerslist.clear();
    var Offers = json.decode(response.body);

    for (var u in Offers) {
      if (CustomerData.Language == "Arabic") {
        OffersData offers = OffersData(
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
        OffersData offers = OffersData(
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


  Future<List<OffersData>> AllCar() async {
    print("Data");
    List<OffersData> offerslist = [];
    var url = await http.get(Urls.searchAllcar);

    var Offers = json.decode(url.body);
    for (var u in Offers) {
      if (CustomerData.Language == "Arabic") {
        OffersData offers = OffersData(
            u["car_model_arabic"],
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
      else {
        OffersData offers = OffersData(
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
  }

  void AllCarOrOffer() {
    if (OfferDataAvaliable.offername == null) {

      PeriodDataOffer =ApplicationLocalizations.of(context).translate("All_Car");
      setState(() {
        Offerorallcar = false;
      });
    }
    else{setState(() {
      PeriodDataOffer =  OfferDataAvaliable.offersperooid;
      print("Peroid "+OfferDataAvaliable.offersperooid);
      Offerorallcar=true;
    });}
  }

  @override
  Widget build(BuildContext context) {
print("image"+Size1.width_of_image.toString());
    AllCarOrOffer();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: (
            SingleChildScrollView(
              child: Container(width: double.infinity,
                child: Column(
                    children: <Widget>[
                      Container(
                          margin:
                          EdgeInsets.only(
                              top: 10, left: 10, right: 10, bottom: 0),
                          width: double.infinity,
                          child: Material(
                              elevation: 5.0,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(10.0)),
                              color: Colors.brown[200],

                              child: Center(

                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SafeArea(
                                    child: Text(
                                      PeriodDataOffer,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: Size1.Font_size),
                                    ),
                                  ),
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
                    child: Text(ApplicationLocalizations.of(context).translate("Loading"),
                      style: TextStyle(fontSize: Size1.Font_size),
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
                    return SafeArea(
                      child: Container(
                        width:double.infinity *2,
                        height: 230,

                        child: ChooseCar(
                            snapshot,
                            index,
                         ApplicationLocalizations.of(context).translate("Warning_Reserve"),
                          ApplicationLocalizations.of(context).translate("offer"),),
                        padding: EdgeInsets.symmetric(
                            horizontal: 0, vertical: 6),

                      ),
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
                    child: Text(ApplicationLocalizations.of(context).translate("Loading"),
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
//                    return Container(
//                      width: MediaQuery
//                          .of(context)
//                          .size
//                          .width,
//                      height: 230,
//
//                      child: ChooseCar(
//                          snapshot,
//                          index,
//                       ApplicationLocalizations.of(context).translate("Warning_Reserve_Without_Offer"),
//                          "No Offer"),
//                      padding: EdgeInsets.symmetric(
//                          horizontal: 0, vertical: 6),
//
//                    );
                  },
                );
              }
            }),
      );
    }
  }
}