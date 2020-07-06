import 'dart:convert';

import 'package:devicepreview/AppTranslation/AppTranslation.dart';
import 'package:devicepreview/Steps_Of_Reservation/ChooseCar.dart';
import 'package:devicepreview/WidthAndHeighTWidget/Size_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import '../CustomerData.dart';
import '../Urls.dart';
import 'OffersData.dart';


class AllCar extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<AllCar> {
  String PeriodDataOffer = 'No Offers';

  Future<List<OffersData>> Data() async {
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

    }    return offerslist; }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(width: double.infinity,
            child: FutureBuilder(
                future: Data(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.data == null) {
                    return Container(
                      child: Center(
                        child: Text(
                          ApplicationLocalizations.of(context).translate("Loading"),
                          style: TextStyle(fontSize:Size1.Font_size),
                        ),
                      ),
                    );
                  } else {

                    print(snapshot.data.length);
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        print(snapshot.data[index].car_model_english);
                      return Container(
                         width: double.infinity,
                          height: 230,
                          child: SafeArea(
                            child: ChooseCar(
                               snapshot,
                               index,
                               ApplicationLocalizations.of(context).translate("Warning_Reserve_Without_Offer"),
                                "No Offer"),
                          ),
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

//   <List<OffersData>>offersdata()async(){}