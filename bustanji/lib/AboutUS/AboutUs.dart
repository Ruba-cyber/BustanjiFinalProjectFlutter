import 'dart:convert';

import 'package:devicepreview/AppTranslation/AppTranslation.dart';
import 'package:devicepreview/WidthAndHeighTWidget/Size_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;

import '../CustomerData.dart';
import '../ReservationData.dart';
import '../Urls.dart';

class AboutUs extends StatefulWidget {
  @override
  MyAppState createState() {
    return MyAppState();
  }
}

class MyAppState extends State<AboutUs> {
  List<String> images = [];

  String mission = '', vision = '', aboutus = '', goals = '', services = '';
  int index = 1;

  Future<String> loadJsonData() async {
    var url = await http.get(Urls.companyinfo);
    var user = json.decode(url.body);
    if (CustomerData.Language == "Arabic") {
      print("Arabic");
      mission = user[0]["mission_arabic"];
      vision = user[0]["vision_arabic"];
      services = user[0]["services_arabic"];
      aboutus = user[0]["about_us_arabic"];
      goals = user[0]["goals_arabic"];
    } else {
      mission = user[0]["mission"];
      vision = user[0]["vision"];
      services = user[0]["services"];
      goals = user[0]["goals"];
      aboutus = user[0]["about_us"];
    }
  }

  void initState() {
    super.initState();
    {
      loadJsonData();
    }
  }

  CarouselSlider instance;
  var _current;

  @override
  Widget build(BuildContext context) {
    print("Width"+Size1.width_About_us.toString());
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo[900],
        ),
        body: SingleChildScrollView(
            child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
              Container(
                margin: EdgeInsets.all(5),
                height:Size1.image_slider_height,
                child: Material(
                  elevation: 10.0,
                  child: CarouselSlider(
                    enlargeCenterPage: true,
                    autoPlay: true,
                    reverse: true,
                    initialPage: 0,
                    height: Size1.image_slider_height,
                    autoPlayInterval: Duration(seconds: 2),
                    onPageChanged: (index) {
                      setState(() {
                        _current = index;
                        index = _current;
                      });
                    },
                    items: ReservationData.imageaboutus.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          if (ReservationData.imageaboutus.length == 0) {
                            return Container(
                              child: Center(
                                child: Text(
                                    ApplicationLocalizations.of(context)
                                        .translate("Loading"),
                                    style: TextStyle(color: Colors.grey),),
                              ),
                            );
                          } else {
                            return Container(
                              child: Material(
                                elevation: 1.0,
                                child: Image.network(
                                  i,
                                  fit: BoxFit.fill,
                                  width: MediaQuery.of(context).size.width,
                                  height: Size1.image_slider_height,
                                ),
                              ),
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(
                                color: Colors.black12,
                              ),
                            );
                          }
                        },
                      );
                    }).toList(),
                  ),
                ),
              ),
              Center(

                  child: Container(margin: EdgeInsets.only(top: 20),
                    width: MediaQuery.of(context).size.width,
                    child: Wrap(
                      direction: Axis.horizontal,
                      children: <Widget>[
                        Container(
                          width: Size1.size_icon,
                          height: Size1.size_icon,
                          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _current == index ? Colors.indigo : Colors.grey,
                          ),
                        ),
                        Container(
                          width: Size1.size_icon,
                          height: Size1.size_icon,
                          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _current == index ? Colors.indigo : Colors.grey,
                          ),
                        ),
                        Container(
                          width: Size1.size_icon,
                          height: Size1.size_icon,
                          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _current == index ? Colors.indigo : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
              ),
              Container(
                padding:
                    EdgeInsets.only(top: 10, left: 30, right: 30, bottom: 10),
                child: Container(width: Size1.title,
                  child: FittedBox(
                    child: Text(
                      ApplicationLocalizations.of(context).translate("AboutUs"),
                      style: TextStyle(
                          fontSize: Size1.Font_size, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Container(width:MediaQuery.of(context).size.width,


                child: FittedBox(
                  child: Container(width: Size1.width_About_us,padding: EdgeInsets.only(left: 30,right: 30),
                    child: Text(
                      aboutus,
                      style: TextStyle(fontSize: Size1.Font_size,),
                    ),
                  ),
                ),
              ),
              Container(width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(left: 30, right: 30, bottom: 10),
                  child: FittedBox(
                    child: Container(width: Size1.title,
                      child: Text(
                        ApplicationLocalizations.of(context).translate("Goals"),
                        style: TextStyle(
                            fontSize: Size1.Font_size, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  )),
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                width: MediaQuery.of(context).size.width,
                child: Container(

                  child: FittedBox(
                    child: Container(width:Size1.width_About_us,
                      child: Text(
                        goals,
                        style: TextStyle(fontSize: Size1.Font_size),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 30, right: 30, bottom: 10,top: 10),
                child: Container(width: Size1.title,
                    child: Text(
                  ApplicationLocalizations.of(context)
                      .translate("Our_Services"),
                  style: TextStyle(
                      fontSize: Size1.Font_size, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                )),
              ),
              Container(
                padding: EdgeInsets.only(left: 30, right: 30),
                width: MediaQuery.of(context).size.width,
                child: FittedBox(
                  child: Container(width: Size1.width_About_us,
                    child: Text(
                      services,
                      style: TextStyle(fontSize: Size1.Font_size),
                    ),
                  ),
                ),
              ),
              Container(
                  padding: EdgeInsets.only(left: 30, right: 30, bottom: 10),
                    child: Container(
                      width: Size1.title,

                        child:
                        FittedBox(
                          child: Text(
                      ApplicationLocalizations.of(context)
                            .translate("Our_Mission"),
                      style: TextStyle(
                            fontSize: Size1.Font_size,
                            fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                    ),
                        )),
                  ),
              Container(
                padding: EdgeInsets.only(left: 30, right: 30),
                width:Size1.width_About_us,
                child: Text(
                  mission,
                  style: TextStyle(fontSize: Size1.Font_size),
                ),
              ),
              Container(                width: MediaQuery.of(context).size.width,

                padding: EdgeInsets.only(left: 30, right: 30, bottom: 10),
                child:  FittedBox(

                    child: Text(
                  ApplicationLocalizations.of(context).translate("Our_vision"),
                  style: TextStyle(
                      fontSize: Size1.Font_size, fontWeight: FontWeight.bold),

                )),
              ),
              FittedBox(
                child: Container(width:MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(left: 30, right: 30),
              
                  child: FittedBox(
                    child: Container(    width: Size1.width_About_us,
                      child: Text(
                        vision,
                        style: TextStyle(fontSize: Size1.Font_size),
                      ),
                    ),
                  ),
                ),
              ),
            ]))));
  }
}
