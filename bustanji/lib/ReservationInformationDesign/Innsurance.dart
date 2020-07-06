
import 'package:devicepreview/AppTranslation/AppTranslation.dart';
import 'package:devicepreview/WidthAndHeighTWidget/Size_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:devicepreview/Options/OptionData.dart';
import '../OfferDataAvaliable.dart';
import '../ReservationData.dart';
import 'InnsuranceReservationsData.dart';
import 'OptionsReservation.dart';
import 'ReservationInfo.dart';

class InnsuranceDesign  extends StatefulWidget {
  String TotalOption;
  InnsuranceDesign(this.TotalOption);
  @override

  _State createState() => _State(this.TotalOption);
}

class _State extends State<InnsuranceDesign> {
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
  Future<List<InnsuranceReservationData>> InnssuranceData2() async {
    List<InnsuranceReservationData> innsurance = [];
    String o = '';
    for (int i = 0; i < ReservationData.inssuracelistname.length; i++) {
      InnsuranceReservationData innsuranceData = new InnsuranceReservationData(
          ReservationData.inssuracelistname[i],

          ReservationData.inssuranceprice[i]);

      innsurance.add(innsuranceData);

    }
    return innsurance;
  }

  Widget build(BuildContext context) {
    return Container(child: Innsurance(),);
  }
  Widget Innsurance() {
    if (ReservationData.inssuracelistname.length >= 1) {

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
                              ApplicationLocalizations.of(context).translate("Innsurance_Name"),
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
                        future: InnssuranceData2(),
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
                                                            .innsurance_en,
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
                                    );
                                  },
                                ));
                          }
                        })),
                FittedBox(fit:BoxFit.fitWidth,
                  child: Container(width: MediaQuery.of(context).size.width/2,
                    child: ResrevationInfo(
                        ApplicationLocalizations.of(context).translate("Total_Innsurance"),
                        Totaloption.toString()),
                  ),
                ),

              ])));
    }

  }
}
