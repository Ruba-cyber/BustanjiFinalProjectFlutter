import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:language/AppTranslation/AppTranslation.dart';
import 'package:language/CustomerInfo/CustomerData.dart';
import 'package:language/ReservationSteps/ChooseCar.dart';
import 'package:language/Urls/BustanjiUrl.dart';
import 'package:language/OffersData/OfferData.dart';
import 'package:flutter/material.dart';
class AllCar extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<AllCar> {
  String PeriodDataOffer = 'No Offers';

  Future<List<OfferData>> Data() async {
    print("Data");
    List<OfferData> offerslist = [];
    var url = await http.get(BustanjiUrls.searchAllcar);

    var Offers = json.decode(url.body);
    for (var u in Offers) {

        if(CustomerData.Language=="Arabic"){
          OfferData offers = OfferData(   u["car_model_arabic"],

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

        else{
          OfferData offers = OfferData(   u["car_model_english"],

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
    }}

    return offerslist;
  }
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
            child: FutureBuilder(
                future: Data(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.data == null) {
                    return Container(
                      child: Center(
                        child: Text(
                          "Loading.....",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    );
                  } else {
                    print(" ALL Car Enter");
                    print(snapshot.data.length);
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        print(snapshot.data[index].car_model_english);
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          height: 230,
                          child: ChooseCar(
                              snapshot,
                              index,
                            ApplicationLocalizations.of(context).translate("Warning_Reserve_Without_Offer"),"No Offer"),
                          padding:
                          EdgeInsets.symmetric(horizontal: 0, vertical: 6),
                        );
                      },
                    );
                  }
                })));
    //  ]),),);
  }
}