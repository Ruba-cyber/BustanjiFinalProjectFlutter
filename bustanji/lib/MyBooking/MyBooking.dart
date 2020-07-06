import 'package:devicepreview/AppTranslation/AppTranslation.dart';
import 'package:devicepreview/WidthAndHeighTWidget/Size_layout.dart';
import 'package:flutter/material.dart';


import '../CustomerData.dart';
import '../ReservationData.dart';
import '../Urls.dart';
import 'ContractList.dart';
import 'MyReservation.dart';

import 'package:http/http.dart' as http;
class MyBooking extends StatefulWidget {
  @override
  _MyBookingState createState() => _MyBookingState();
}
class _MyBookingState extends State<MyBooking>  with SingleTickerProviderStateMixin {
  TabController tabController;
  double rating = 0,
      rating1 = 0,
      rating2 = 0;

  @override
  void initState() {
    // TODO: implement initState 
    super.initState();

    tabController = new TabController(length: 2, vsync: this);
  }//      return showDialog(context: context,
//          builder: (BuildContext context) {
//            return AlertDialog(title: Text('Rating Application'),
//                content: Container(
//
//                  child: Container(
//                      margin: EdgeInsets.all(10), color: Colors.white,
//
//                      child: Wrap(children: <Widget>[
//                        Container(width: 300,
//                          child: Text(" Rate The Quality of Company Services",
//                            style: TextStyle(
//                                fontSize: 18, color: Colors.black),),
//                        ),
//
//                       Container(width: 300,
//                          child: Text(
//                            " Rate The Quality of Car ", style: TextStyle(
//                              fontSize: 18, color: Colors.black),),
//                          margin: EdgeInsets.only(bottom: 5),),
//                        SmoothStarRating(
//                          rating: rating1,
//                          size: 35,
//                          filledIconData: Icons.star,
//                          halfFilledIconData: Icons.star_half,
//                          defaultIconData: Icons.star_border,
//                          starCount: 5,
//                          allowHalfRating: false,
//                          spacing: 2.0,
//                          onRatingChanged: (value) {
//                            print(value);
//                            setState(() {
//                              rating1 = value;
//                            });
//                          },
//                        ),
//                        Container(width: 300,
//                          child: Text(" Rating Employee", style: TextStyle(
//                              fontSize: 18, color: Colors.black),),
//                          margin: EdgeInsets.only(bottom: 5),),
//                        Container(
//                          child: SmoothStarRating(
//                            rating: rating2,
//                            size: 35,
//                            filledIconData: Icons.star,
//                            halfFilledIconData: Icons.star_half,
//                            defaultIconData: Icons.star_border,
//                            starCount: 5,
//                            allowHalfRating: false,
//                            spacing: 2.0,
//                            onRatingChanged: (value) {
//                              print(value);
//                              setState(() {
//                                rating2 = value;
//                              });
//                            },
//                          ),
//                        ),
//                        Container(child: Row(children: <Widget>[
//                          Container(child: FlatButton(
//                              onPressed: (){}, child: Text("Ok")),),
//                          Container(child: FlatButton(
//                              onPressed: (){}, child: Text("Cancel")),),
//                        ],),)
//                      ])),));


//    Container(margin: EdgeInsets.all(10), color: Colors.white,
//
//        child: Wrap(children: <Widget>[
//          Container(width: 300,
//            child: Text(" Rate The Quality of Customer Service",
//              style: TextStyle(fontSize: 18, color: Colors.black),),
//            margin: EdgeInsets.only(bottom: 5),),
//          SmoothStarRating(
//            rating: rating,
//            size: 35,
//            filledIconData: Icons.star,
//            halfFilledIconData: Icons.star_half,
//            defaultIconData: Icons.star_border,
//            starCount: 5,
//            allowHalfRating: false,
//            spacing: 2.0,
//            onRatingChanged: (value) {
//              print(value);
//              setState(() {
//                rating = value;
//              });
//            },
//          ),
//          Container(width: 300,
//            child: Text(" Rate The Quality of Customer Service",
//              style: TextStyle(fontSize: 18, color: Colors.black),),
//            margin: EdgeInsets.only(bottom: 5),),
//          SmoothStarRating(
//            rating: rating1,
//            size: 35,
//            filledIconData: Icons.star,
//            halfFilledIconData: Icons.star_half,
//            defaultIconData: Icons.star_border,
//            starCount: 5,
//            allowHalfRating: false,
//            spacing: 2.0,
//            onRatingChanged: (value) {
//              print(value);
//              setState(() {
//                rating1 = value;
//              });
//            },
//          ),
//          Container(width: 300,
//            child: Text(" Rate The Quality of Customer Service",
//              style: TextStyle(fontSize: 18, color: Colors.black),),
//            margin: EdgeInsets.only(bottom: 5),),
//          Container(
//            child: SmoothStarRating(
//              rating: rating2,
//              size: 35,
//              filledIconData: Icons.star,
//              halfFilledIconData: Icons.star_half,
//              defaultIconData: Icons.star_border,
//              starCount: 5,
//              allowHalfRating: false,
//              spacing: 2.0,
//              onRatingChanged: (value) {
//                print(value);
//                setState(() {
//                  rating2 = value;
//                });
//              },
//            ),
//          ),
//          Container(child: Row(children: <Widget>[
//            Container(child: FlatButton(onPressed: null, child: Text("Ok")),),
//            Container(
//              child: FlatButton(onPressed: null, child: Text("Cancel")),),
//          ],),)
//        ]));



  Future<String> FeedBackRating(var stars) async {
    var data = Urls.completefeedback;

    print(CustomerData.customerid);
    print(stars);
    print(ReservationData.resid.toString());
    http.Response response = await http.post(data, body: {
      'reservation_id': ReservationData.resid.toString(),
      "application_stars": stars.toString(),
      "customer_id": CustomerData.customerid
    });
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: 
      Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: new AppBar(
            title: new Text(""),

            backgroundColor: Colors.indigo[900],
            bottom:
            new TabBar(controller: tabController, tabs: <Tab>[

             new Tab(
                      child: SafeArea(
                        child: FittedBox(

                          child: Container(
                            child: Text(ApplicationLocalizations.of(context).translate("Reservation"),
                                style: TextStyle(color: Colors.white, fontSize:Size1.Font_size)),
                          ),
                        ),
                      )),

              new Tab(child:
              SafeArea(
                child:
                FittedBox(
                  child: Text(ApplicationLocalizations.of(context).translate("Contracts"),
                      style: TextStyle(color: Colors.white, fontSize: Size1.Font_size)),
                ),
              )),
            ]),

          ),
          body: new TabBarView(
              controller: tabController,
              children: <Widget>[new MyReservation(), new ContractList()]
          ) ),
    );


  }


  }
