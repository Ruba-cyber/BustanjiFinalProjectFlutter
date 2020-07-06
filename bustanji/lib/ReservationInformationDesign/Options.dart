
import 'package:devicepreview/AppTranslation/AppTranslation.dart';
import 'package:devicepreview/WidthAndHeighTWidget/Size_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:devicepreview/Options/OptionData.dart';
import '../OfferDataAvaliable.dart';
import '../ReservationData.dart';
import 'OptionsReservation.dart';
import 'ReservationInfo.dart';

class Options  extends StatefulWidget {
  String TotalOption;
  Options(this.TotalOption);
  @override

  _State createState() => _State(this.TotalOption);
}

class _State extends State<Options> {
  double sum = 0,
      tax,
      TotalDays = 0,
      TotalTaxAfterTax,
      TotalInssurance = 0,
      carprice;
  String offername, Totaloption ;
  _State(this.Totaloption);
  String locationTxt = "0", optionofferstate='';
  @override
  Future<List<OptionsReservation>> OptionReservation(BuildContext context) async {
    List<OptionsReservation> option = [];
    String o = '';


    for (int i = 0; i < ReservationData.optionname.length; i++) {
      if (ReservationData.optionname[i] == OfferDataAvaliable.option_en ||
          ReservationData.optionname[i] == OfferDataAvaliable.option_ar) {
        o = 'Yes';
        optionofferstate=ApplicationLocalizations.of(context).translate("One") +' '+ ReservationData.optionname[i] + ApplicationLocalizations.of(context).translate("Option_Free");
      } else {
        o = 'No';
        optionofferstate=ApplicationLocalizations.of(context).translate("No_Option_Offer");
      }

      OptionsReservation option2 = new OptionsReservation(
          ReservationData.optionname[i],
          ReservationData.optioncount[i],
          ReservationData.optionprice[i],
          o);
      option.add(option2);
      print("nn" + option2.optionnameen);
      print("" + option.length.toString());
    }
    return option;}
  Widget build(BuildContext context) {
  return Container(child: Options(),);
  }
  Widget Options() {
    if (ReservationData.optionname.length >= 1) {

        return Container(
            margin: EdgeInsets.all(5),
            width:double.maxFinite,
            child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                color: Colors.white,
                child: Wrap(direction: Axis.vertical, children: <Widget>[
                  Container(
                    width:MediaQuery.of(context).size.width/2,
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
                          future: OptionReservation(context),
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
                                  width: MediaQuery.of(context).size.width/2,
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
                    child: Container(width: MediaQuery.of(context).size.width/2,
                      child: ResrevationInfo(
                          ApplicationLocalizations.of(context).translate("Total_Option"),
                          Totaloption.toString()),
                    ),
                  ),

                  Container(padding: const EdgeInsets.all(5.0),
                    child: SafeArea(

                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          "" + optionofferstate,
                          style: TextStyle(fontSize: Size1.Font_size, color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                ])));
      }

      }
    }
