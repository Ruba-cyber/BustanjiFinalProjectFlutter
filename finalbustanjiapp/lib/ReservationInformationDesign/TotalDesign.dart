
import 'package:flutter/material.dart';
import 'package:language/AppTranslation/AppTranslation.dart';
import 'package:language/Reservation/ReservationData.dart';


class TotalDesign extends StatefulWidget {
  String TotalAfterTax,TotalBeforeTax;
  @override
  _State createState() => _State(this.TotalBeforeTax,this.TotalAfterTax);
  TotalDesign(this.TotalBeforeTax,this.TotalAfterTax);
}

class _State extends State<TotalDesign> {
  @override
  String TotalAfterTax,TotalBeforeTax;
  _State(this.TotalBeforeTax,this.TotalAfterTax);
  Widget build(BuildContext context) {
   return Container(
        margin: EdgeInsets.only(
            top: 10, bottom: 10, left: 5, right: 5),
        child: Material(
            elevation: 5.0,
            borderRadius:
            BorderRadius.all(Radius.circular(5.0)),
            color: Colors.white,
            child: Column(children: <Widget>[
              Container(width: MediaQuery.of(context).size.width,
                child: FittedBox(
                  child: Row(children: <Widget>[
                    Container(width:MediaQuery.of(context).size.width/1.5,
                      padding: EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                          left: 8,
                          right: 2),
                      child: Text(
                          ApplicationLocalizations.of(context).translate("Total_Before_Tax"),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(width: MediaQuery.of(context).size.width/1.5,
                      padding: EdgeInsets.only(
                          top: 5,
                          bottom: 5,
                          left: 2,
                          right: 2),
                      child: Text(
                        "" + TotalBeforeTax.toString() +'  ',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight:
                            FontWeight.normal),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                          left: 5,
                          right: 5),
                    ),
                  ]),
                ),
              ),
              Container(width: MediaQuery.of(context).size.width,
                  child: FittedBox(
                    child: Row(children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                            top: 5,
                            bottom: 5,
                            left: 5,
                            right: 2),
                        child: Container(width: MediaQuery.of(context).size.width/1.5,
                          child: Text(
                              ApplicationLocalizations.of(context).translate("Total_After_Tax"),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(width: MediaQuery.of(context).size.width/1.5,
                        padding: EdgeInsets.only(
                            top: 10,
                            bottom: 10,
                            left: 0,
                            right: 0),
                        child: Text(
                          "" + TotalAfterTax.toString() +' '+ReservationData.coin,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ]),
                  )),
            ])));
  }
}

