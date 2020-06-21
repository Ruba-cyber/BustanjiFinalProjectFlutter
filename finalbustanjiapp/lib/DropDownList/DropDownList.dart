import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:language/AppTranslation/AppTranslation.dart';
import 'package:language/Reservation/ReservationData.dart';

import 'package:http/http.dart' as http;
import 'package:language/Urls/BustanjiUrl.dart';
class DropDownList extends StatefulWidget {
  List<String> _location = [];
  String texhint;

  @override
  DropDownList(this.texhint, this._location) {}

  _DropDownListState createState() =>
      _DropDownListState(this.texhint, this._location);
}
class _DropDownListState extends State<DropDownList> {

  String text,texthint;

  List<String> list;TextDirection textDirection;

  _DropDownListState(this.text, this.list) {texthint=text;}

  Future<String> Location(String pickuploction) async {
    var url = await http.get(BustanjiUrls.searchlocation);
    var user = json.decode(url.body);
    print("yd");
    print(user);
    for (var i in user) {

      print(i["location_name_english"]);
      if (i["location_name_english"]==pickuploction ||i["location_name_arabic"]== pickuploction) {

        String type=i["type"];
        if(type=="1"){
          print("Airport");
          setState(() {
            ReservationData.Airport=true;

          });}
        else{setState(() {
          ReservationData.Airport=false;

        });}}}}
  Future<String> ReturnLocation(String pickuploction) async {
    var url = await http.get(BustanjiUrls.searchlocation);
    var user = json.decode(url.body);
    print("yd");
    print(user);
    for (var i in user) {

      print(i["location_name_english"]);
      if (i["location_name_english"]==pickuploction|| i["location_name_arabic"] == pickuploction) {

        String type=i["type"];
        if(type=="1"){
          print("Airport");
          setState(() {
            ReservationData.ReturnLocationAirport=true;

          });}
        else{setState(() {
          ReservationData.ReturnLocationAirport=false;

        });}}}}
  @override
  Widget build(BuildContext context) {





      child: new DropdownButton<String>(
        isDense: true,
        hint: Container(
          child: FittedBox(fit: BoxFit.contain,
            child: Container(width: 100,height: 30,

              child: new Text(
                text,style: TextStyle(
                color: Colors.grey[700],fontSize: 17,),
                textDirection:textDirection,
              ),
            ),
          ),
        ),





        onChanged: (String newValue) {

          setState(() {

            if (texthint == ApplicationLocalizations.of(context).translate("PickupLoc")) {
              ReservationData.pickuploc = newValue;
              Location(newValue);
              text=newValue;
            } else {

              if (texthint ==    ApplicationLocalizations.of(context).translate("returnloc")) {
                ReservationData.returnlocation = newValue;
                print( ReservationData.returnlocation);
                ReturnLocation(newValue);
                text=newValue;
              }
            }
          });
        },
        items: list.map((item) {
          return new DropdownMenuItem<String>(
            value: item.toString(),
            child: new Text(
              item.toString(),
            ),
          );
        }).toList(),


    );
  }
}


