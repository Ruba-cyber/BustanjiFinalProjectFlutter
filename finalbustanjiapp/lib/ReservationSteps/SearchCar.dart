import 'package:flutter/material.dart';
import 'package:language/AppTranslation/AppTranslation.dart';
import 'package:language/OffersData/OfferData.dart';
import 'package:language/Reservation/ReservationData.dart';

import 'SearchDesign.dart';

class SearchCar extends StatefulWidget {
  @override
  _SearhCarState createState() => _SearhCarState();
}

class _SearhCarState extends State<SearchCar> {

  @override
  _SearhCarState() {}



  Widget build(BuildContext context) {

  return Scaffold(resizeToAvoidBottomInset: false,
  appBar: AppBar(  backgroundColor: Colors.indigo[900],
  title: Container(
    child: Container(
      child: Row(children: <Widget>[
  Container(
    child: Text( ApplicationLocalizations.of(context).translate("Currency"),
      style: TextStyle(color: Colors.white),),),

    Container(margin:EdgeInsets.only(left: 20),padding:EdgeInsets.only(left: 30,right: 10),
      decoration: BoxDecoration(
      border: Border.all(),
      color: Colors.white,
    ),
    child: new DropdownButton<String>(
    isDense: true,

    hint: new Text(
    OfferData.coin  ,textAlign:TextAlign.center,style: TextStyle(color: Colors.black),),

    onChanged: (String newValue) {

    setState(() {
      OfferData.coin= newValue;



    });


    },
    items: ReservationData.Coins.map((  item) {
    return new DropdownMenuItem<String>(
    value: item.toString(),
    child: new Text(item.toString(),
    ),
    );
    }).toList(),
    ),
    ),

  ]),
    ),

  )),

  body: (
      Container(child:SearchDesign())));
     // Container(child: AllCar())));

    // Not necessary for Option 1
  }
}

