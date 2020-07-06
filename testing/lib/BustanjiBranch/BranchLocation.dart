import 'dart:convert';
import 'package:language/AppTranslation/AppTranslation.dart';
import 'package:language/CustomerInfo/CustomerData.dart';
import 'package:language/Urls/BustanjiUrl.dart';

import 'BranchData.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'BranchDesign.dart';
class BranchLocation extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}
List< BranchData>branch=[];
Future<List<BranchData>>ContactusData1()async{
  var url = await http.get(BustanjiUrls.branchus);
  branch.clear();
  var Offers = json.decode(url.body);
  for (var u in Offers) {
    if(CustomerData.Language=="Arabic") {
      BranchData c1 = new BranchData(

          u["branch_name_arabic"], u["GPS_location"],
         u["address_arabic"]
      );
      branch.add(c1);
    }
    else{ BranchData c1 = new BranchData(

        u["branch_name_english"], u["GPS_location"],
        u["address_english"],

    );branch.add(c1);}


  }
  return branch;}
class _ContactUsState extends State<BranchLocation> {
  @override
  Widget build(BuildContext context) {


    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.indigo[900],
        ),
        body: SingleChildScrollView(
            child: Container(
                child: Material(
                    child: Column(children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 50),
                          child: Material(
                              elevation: 5.0,
                              borderRadius: BorderRadius.all(Radius.circular(20.0)),
                              color: Colors.white,
                              child: Container(
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.only(top: 30, bottom: 30),
                                          decoration: (BoxDecoration(

                                              borderRadius: BorderRadius.only())),
                                          width: MediaQuery.of(context).size.width,

                                          child: Column(children: <Widget>[

Container(padding:EdgeInsets.only(bottom:2),child: Text(     ApplicationLocalizations.of(context).translate("Welcome_Our_Branches")   ,
  style: (TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.indigo[900])),),),
                                        Container(  child: FutureBuilder(
                                            future: ContactusData1(),
                                            builder:
                                                (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                                              if (snapshot.data == null) {
                                                return Container(
                                                  child: Center(
                                                    child: Text(
                                                      ApplicationLocalizations.of(context).translate("Loading"),
                                                      style: TextStyle(fontSize: 20),
                                                    ),
                                                  ),
                                                );
                                              } else {

                                                print(snapshot.data.length);
                                                return ListView.builder(
                                                  physics: NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,

                                                  itemCount: snapshot.data.length,
                                                  itemBuilder: (BuildContext context, int index) {

                                                    return Wrap(children: <Widget>[
                                                      Container(
                                                      width: MediaQuery.of(context).size.width,

                                                      child: BranchDesign(snapshot,index),

                                                      padding:
                                                      EdgeInsets.symmetric(horizontal: 0, vertical:5),
                                                    ),],

                                                    );
                                                  },
                                                );
                                              }
                                            }))]))]))))])))));

  }
}
