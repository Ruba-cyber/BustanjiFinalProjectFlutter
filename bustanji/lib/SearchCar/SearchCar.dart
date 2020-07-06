
import 'package:devicepreview/AppTranslation/AppTranslation.dart';
import 'package:devicepreview/HomePage/HomePage.dart';
import 'package:devicepreview/Offers/OffersData.dart';
import 'package:devicepreview/WidthAndHeighTWidget/Size_layout.dart';
import'package:devicepreview/Login/Login.dart';
import 'package:flutter/material.dart';

import '../CustomerData.dart';
import '../ReservationData.dart';
import '../Urls.dart';
import 'SearchDesign.dart';

class SearchCar extends StatefulWidget {
  @override
  _SearhCarState createState() => _SearhCarState();
}

class _SearhCarState extends State<SearchCar> {

  @override
  _SearhCarState() {}
  Future<bool> _onWillPop() async {
    if (CustomerData.CustomerType == "Customer") {
      return (
        await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => new HomePage(),
            )));
    }
    else{return (
        await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => new Login(),
            )));}}

  Widget build(BuildContext context) {

  return new WillPopScope(onWillPop: _onWillPop,
    child:  new Scaffold(resizeToAvoidBottomInset: false,
    appBar: (
   AppBar(  backgroundColor: Colors.indigo[900],
      title:
      SafeArea(

          child: Container(
            child: Container(width: double.infinity,
              child: FittedBox(fit: BoxFit.scaleDown,
                child: Row(children: <Widget>[
          Container(width:Size1.width_text,
            child: Text(ApplicationLocalizations.of(context).translate("Currency"),
                style: TextStyle(color: Colors.white),),),

            Container(width:Size1.width_text,
              margin:EdgeInsets.only(left: 10,right: 10),
              padding:EdgeInsets.only(left: 30,right: 30),
                decoration: BoxDecoration(
                border: Border.all(),
                color: Colors.white,
            ),
            child: new DropdownButton<String>(
            isDense: true,

            hint: FittedBox(fit: BoxFit.scaleDown,
              child: new Text(
              OffersData.coin  ,
                textAlign:TextAlign.center,
                style: TextStyle(color: Colors.black,fontSize: Size1.Font_size),),
            ),

            onChanged: (String newValue) {

            setState(() {
                OffersData.coin= newValue;



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
            ),

          ),
        ),

   ) ),

    body: (
        Container(child:SearchDesign()))),
  );
     // Container(child: AllCar())));

    // Not necessary for Option 1
  }
}

