
import 'dart:convert';

import 'package:devicepreview/AppTranslation/AppTranslation.dart';
import 'package:devicepreview/Options/OptionData.dart';
import 'package:devicepreview/ReservationInformationDesign/ReservationInfo.dart';
import 'package:devicepreview/WidthAndHeighTWidget/Size_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../CustomerData.dart';
import '../Urls.dart';
import 'OptionsReservation.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:flutter/material.dart';

import '../Urls.dart';
import 'InnsuranceReservationsData.dart';
import 'package:http/http.dart' as http;

class MyOption extends StatefulWidget {
  String resid,status;
  @override
  MyOption(this.resid,this.status);
  _MyOptionState createState() => _MyOptionState(this.resid,this.status);
}


class _MyOptionState extends State<MyOption> {
  String resid = '',status='',textoffer='';
  double sumoption = 0;


  _MyOptionState(this.resid,this.status);

  Future<List<OptionsReservation>> OptionData() async {
    print("Innsurance");

    print("Innsurancd" + resid);
    List<OptionsReservation> optionlist = [];

    var url = Urls.getoption;

    http.Response response =
    await http.post(url, body: {'reservation_id': resid});
    print(response.body);
    optionlist.clear();
sumoption=0.0;
    var Offers = json.decode(response.body);
    //print(""+Offers);

    for (var u in Offers) {
      if (CustomerData.Language == "Arabic") {
        OptionsReservation optionsReservation = OptionsReservation(
            u["option_name_arabic"],
            u["quantity"],
            u["option_price"],
            u["option_offer"]);
        optionlist.add(optionsReservation);
      }
      else {
        OptionsReservation optionsReservation = OptionsReservation(
            u["option_name_arabic"],
            u["quantity"],
            u["option_price"],
            u["option_offer"]);
        optionlist.add(optionsReservation);
      }
      try {
        double price = double.parse(u["option_price"]);
        double count = double.parse(u["quantity"]);
        if (u["option_offer"] == "yes") {

            setState(() {

              if(CustomerData.Language=="English") {
                textoffer='Option Free';
               }
              else{setState(() {
                textoffer='Option Free';
              });}
                count = count - 1;
                sumoption = sumoption + (price * count);
               });
          }else {
          setState(() {
            sumoption = sumoption + (price * count);
          });
        }
      } catch (Ex) {}
    }



    return optionlist;
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: Options(),);
  }
  Widget Options() {
    if (status=="1") {

      return Container(
          margin: EdgeInsets.all(5),
          width:double.maxFinite,
          child: Material(
              elevation: 5.0,
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              color: Colors.white,
              child: Wrap(direction: Axis.vertical, children: <Widget>[
                Container(
                  width:MediaQuery.of(context).size.width,
                  margin: EdgeInsets.all(5),
                  child: FittedBox(fit: BoxFit.fitWidth,
                    child: SafeArea(
                      child: Wrap(direction: Axis.horizontal,

                        children: <Widget>[
                          Container(
                            width: Size1.Option_Name_width,
                            padding: EdgeInsets.only(
                                top: 5, bottom: 5, left: 2, right: 2),
                            child: Text(
                              ApplicationLocalizations.of(context).translate("Option_Name"),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: Size1.Font_size),
                            ),
                          ),
                          Container(
                            width:Size1.Option_Quantitiy_width,
                            padding: EdgeInsets.only(
                                top: 5, bottom: 5, left: 2, right: 2),
                            child: Text(
                              ApplicationLocalizations.of(context).translate("Quantitiy"),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: Size1.Font_size),
                            ),
                          ),
                          Container(
                            width: Size1.Option_Price_width,
                            padding: EdgeInsets.only(
                                top: 5, bottom: 5, left: 4, right: 4),
                            child: Text(
                              ApplicationLocalizations.of(context).translate("Price"),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: Size1.Font_size),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 5, bottom: 5),
                    child: FutureBuilder(
                        future: OptionData(),
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.data == null) {
                            return Center(
                              child: Container(
                                child: Center(
                                  child: Text(
                                    "  No Option Data ",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Container(
                                width: MediaQuery.of(context).size.width,
                                child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin: EdgeInsets.all(5),
                                      child: FittedBox(
                                        child: SafeArea(
                                          child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: <Widget>[
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        left: 4, right: 4),
                                                    width:Size1.Option_Name_width,

                                                    child: Text(
                                                      "" +
                                                          snapshot.data[index]
                                                              .optionnameen,
                                                      style: TextStyle(
                                                          fontSize: Size1.Font_size),
                                                    )),
                                                Container(
                                                    width: Size1.Option_Quantitiy_width,
                                                    margin: EdgeInsets.only(
                                                        left: 6, right: 6),
                                                    child: Text(
                                                      "" +
                                                          snapshot.data[index]
                                                              .quantity,
                                                      style: TextStyle(
                                                          fontSize: Size1.Font_size),
                                                    )),
                                                Container(
                                                    width: Size1.Option_Price_width,
                                                    padding: EdgeInsets.only(
                                                      left: 2,
                                                      right: 2,
                                                      top: 5,
                                                    ),
                                                    child: Text(
                                                      "" +
                                                          snapshot.data[index]
                                                              .price,
                                                      style: TextStyle(
                                                          fontSize: Size1.Font_size),
                                                    )),
                                              ]),
                                        ),
                                      ),
                                    );
                                  },
                                ));
                          }
                        })),



                SafeArea(
                  child: Container(width: MediaQuery.of(context).size.width/3,
                    child: ResrevationInfo(
                        ApplicationLocalizations.of(context).translate("Total_Option"),
                        sumoption.toString()),
                  ),
                ),

                Container(padding: const EdgeInsets.all(5.0),
                  child: SafeArea(

                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text(
                        "" + textoffer,
                        style: TextStyle(fontSize: Size1.Font_size, color: Colors.red),
                      ),
                    ),
                  ),
                ),
              ])));
    }

  }
    }