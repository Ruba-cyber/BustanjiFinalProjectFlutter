import 'dart:convert';



import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'package:language/AppTranslation/AppTranslation.dart';
import 'package:language/CustomerInfo/CustomerData.dart';
import 'package:language/Reservation/ReservationData.dart';
import 'package:language/Urls/BustanjiUrl.dart';


class AboutUs extends StatefulWidget {
  @override
  MyAppState createState() {
    return MyAppState();
  }
}

class MyAppState extends State<AboutUs> {

  List<String> images = [];

  String mission='', vision='', aboutus='', goals='', services='';
  int index = 1;

  Future<String> loadJsonData() async {
    var url = await http.get(BustanjiUrls.companyinfo);
    var user = json.decode(url.body);
    if(CustomerData.Language=="Arabic"){
      print("Arabic");
      mission = user[0]["mission_arabic"];
      vision = user[0]["vision_arabic"];
      services = user[0]["services_arabic"];
      aboutus= user[0]["about_us_arabic"];
      goals = user[0]["goals_arabic"];}
    else{ mission = user[0]["mission"];
    vision = user[0]["vision"];
    services = user[0]["services"];
    goals = user[0]["goals"];
    aboutus= user[0]["about_us"];}}






  void initState() {
    super.initState();
     {  loadJsonData();}}

  CarouselSlider instance;
  var _current;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo[900],
        ),
        body: SingleChildScrollView(
            child: Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
              Container(
              margin: EdgeInsets.all(10),
              height: 300,
              child: Material(

                elevation: 10.0,
                child: CarouselSlider(
                  enlargeCenterPage: true,
                  autoPlay: true,
                  reverse: true,
                  initialPage: 0,
                  height: 300,
                  autoPlayInterval: Duration(seconds: 2),
                  onPageChanged: (index) {
                    setState(() {
                      _current = index;
                      index=_current;
                    });
                  },
                  items: ReservationData.imageaboutus.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        if(ReservationData.imageaboutus.length==0){
                          return Container(child: Center(child: Text(
                              ApplicationLocalizations.of(context).translate("Loading"),style: TextStyle(color: Colors.grey)),),);
                        }
                        else {
                          return Container(
                            child: Material(
                              elevation: 1.0,
                              child: Image.network(
                                i,
                                fit: BoxFit.fill,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                              ),
                            ),

                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              color: Colors.black12,
                            ),
                          );
                        }    },
                    );
                  }).toList(),
                ),),),
            Container(child: Row(crossAxisAlignment:CrossAxisAlignment.start,
              children: <Widget>[
                Container(width: 10,
                  height: 10,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
                  decoration: BoxDecoration(shape: BoxShape.circle,
                    color: _current == index ? Colors.indigo : Colors.grey,),),
                Container(width: 10,
                  height: 10,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
                  decoration: BoxDecoration(shape: BoxShape.circle,
                    color: _current == index ? Colors.indigo : Colors.grey,),),
                Container(width: 10,
                  height: 10,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
                  decoration: BoxDecoration(shape: BoxShape.circle,
                    color: _current == index ? Colors.indigo : Colors.grey,),),


              ],),),

    Container( padding: EdgeInsets.only( top:10,left: 30,right: 30,bottom: 10),

    child: Container(child: Text(
     ApplicationLocalizations.of(context).translate("AboutUs"), style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),),),),
            Container(padding: EdgeInsets.only(left: 30, right: 30),
              width: 500, child: Text(aboutus, style: TextStyle(fontSize: 18),),

            ),

             Container( padding: EdgeInsets.only(left: 30,right: 30,bottom: 10),
                 child: Text(
               ApplicationLocalizations.of(context).translate("Goals") , style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),
                textAlign: TextAlign.start,)),
                Container(padding: EdgeInsets.only(left: 30, right: 30),
                  width: 500,
                  child: Text(goals, style: TextStyle(fontSize: 18),textAlign: TextAlign.start,),

                ),
                    Container( padding: EdgeInsets.only(left: 30,right: 30,bottom: 10),

                          child: Container(child: Text(
                           ApplicationLocalizations.of(context).translate("Our_Services")       ,
                            style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),
                            textAlign: TextAlign.start,)),),
                    Container(padding: EdgeInsets.only(left: 30, right: 30),
                      width: 500,
                      child: Text(services, style: TextStyle(fontSize: 18),),

                    ),


          Container( padding: EdgeInsets.only(left: 30,right: 10,bottom: 10),
              child: Align(alignment: Alignment.centerLeft,
                child: Container(child: Text(
                  ApplicationLocalizations.of(context).translate("Our_Mission") , style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),
                  textAlign: TextAlign.start,)),)),
          Container(padding: EdgeInsets.only(left: 30, right: 30),
            width: 500,
            child: Text(mission, style: TextStyle(fontSize: 18),),

          ),

                    Container( padding: EdgeInsets.only(left: 30,right: 10,bottom: 10),

                          child: Container(child: Text(
                            ApplicationLocalizations.of(context).translate("Our_vision") , style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),
                            textAlign: TextAlign.left,)),),
                    Container(padding: EdgeInsets.only(left: 30, right: 30),
                      width: 500,
                      child: Text(vision, style: TextStyle(fontSize: 18),),

                    ),

                  ]))));
  }

}
