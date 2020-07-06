import 'package:devicepreview/AppTranslation/AppTranslation.dart';
import 'package:devicepreview/SearchCar/SearchCar.dart';
import 'package:devicepreview/WidthAndHeighTWidget/Size_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../ReservationData.dart';
import 'Airport.dart';

class CarDesignForTotal extends StatefulWidget {
  @override
  _CarDesignState createState() => _CarDesignState();
}

class _CarDesignState extends State<CarDesignForTotal> {
  @override
  Widget build(BuildContext context) {

    return Container(
      width:double.infinity,
        margin:
        EdgeInsets.only(top: 30, left: 5, right: 5),
        child: Material(
            elevation: 5.0,
            borderRadius:
            BorderRadius.all(Radius.circular(10.0)),
            color: Colors.white,
            child: FittedBox(
              child: SafeArea(
                child: Row(children: <Widget>[
                  Container(margin: EdgeInsets.only(left:10,right: 10),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                      Container(
                          padding: EdgeInsets.only(
                              bottom: 10, top: 10, left: 10),
                          child: Image.network(
                            ReservationData.imagecar,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width /
                                3.4,
                            height:  MediaQuery
                                .of(context)
                                .size
                                .width /
                                6.4,
                          )),
                      Container(
                          child: FittedBox(
                            child: Row(children: <Widget>[
                              Container(
                                //padding: (EdgeInsets.all(2)),
                                child: Row(children: <Widget>[
                                  Container(
                                    width: Size1.size_icon,
                                    padding: EdgeInsets.all(2),
                                    child: Icon(Icons.person),
                                  ),
                                  Container(
                                    width: Size1.size_icon,
                                    padding: EdgeInsets.all(5),
                                    child: Text(
                                        ReservationData.passager),
                                  ),
                                ]),
                              ),
                              Container(
                                child: Row(children: <Widget>[
                                  Container(
                                    width: Size1.size_icon,
                                    padding: EdgeInsets.all(2),
                                    child: Image.network(
                                        "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRAnSdWWPCYXS1jmDaF_VhIPJR81UVTCZFNL1H3yByIAxd4vwx7"),
                                  ),
                                  Container(
                                    width: Size1.size_icon,
                                    padding: EdgeInsets.all(5),
                                    child:
                                    Text(ReservationData.bag),
                                  ),
                                ]),
                              ),
                            ]),
                          )),
                      Container(
                        child: Row(children: <Widget>[
                          Container(
                            width: Size1.size_icon,
                            padding: EdgeInsets.all(2),
                            child: Image.network(
                                "https://3.imimg.com/data3/VT/QG/GLADMIN-140882/car-door-250x250.jpg"),
                          ),
                          Container(
                            width: 20,
                            padding: EdgeInsets.all(5),
                            child: Text(ReservationData.door),
                          ),
                          Container(
                            width: 80,
                            padding:
                            EdgeInsets.only(left: 15, right: 15),
                            child: Text(ReservationData.year),
                          ),
                        ]),
                      ),
                    ]),
                  ),
                  Container(
                      child: Column(children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                              left: 10, right: 10, top: 10),
                          child: Text(
                            ReservationData.cartype,
                            style: TextStyle(
                                fontSize: Size1.Font_size,
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: 0, right: 10, top: 0),
                          child: Text(
                            ReservationData.transmission,
                            style: TextStyle(
                                fontSize: Size1.Font_size,
                                color: Colors.black),
                          ),
                        ),

                        Container(
                          padding: EdgeInsets.only(
                              top: 5,
                              left: 20,
                              bottom: 5,
                              right: 20),
                          child: Container(

                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: 30,
                                    height: 20,
                                    child: Offstage(
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            left: 2, right: 2),
                                        decoration: BoxDecoration(
                                          border: Border.all(),
                                          color: Colors.red[500],
                                        ),
                                      ),
                                      offstage:
                                      ReservationData.colorred,
                                    ),
                                  ),
                                  Container(
                                      padding: EdgeInsets.only(left: 2, right: 2),
                                      child: Offstage(
                                          offstage: ReservationData
                                              .colorblue,
                                          child: (Container(
                                            padding: EdgeInsets.only(
                                                left: 2, right: 2),
                                            decoration: BoxDecoration(
                                              border: Border.all(),
                                              color: Colors.blue,
                                            ),
                                            width: 30,
                                            height: 20,
                                          )))),

                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 2, right: 2),
                                    child: Offstage(
                                        offstage:
                                        ReservationData.colorgreen,
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              left: 2, right: 2),
                                          decoration: BoxDecoration(
                                            border: Border.all(),
                                            color: Colors.green,
                                          ),
                                          width: 30,
                                          height: 20,
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 2, right: 2),
                                    child: Offstage(
                                      offstage:
                                      ReservationData.colorblack,
                                      child: Container(padding: EdgeInsets.only(
                                          left: 2, right: 2),
                                        decoration: BoxDecoration(
                                          border: Border.all(),
                                          color: Colors.black,
                                        ),
                                        width: 30,
                                        height: 20,
                                      ),
                                    ),
                                  ),
                                  //,padding: EdgeInsets.only(left: 50,right: 10,top: 10)),
                                ],
                              ),
                            ),
                          ),
                         //,),

                        Container(
                          padding: EdgeInsets.all(0),
                          child: Text(
                            ReservationData.price +' '+ReservationData.coin,

                            style: TextStyle(
                                fontSize: Size1.Font_size,
                                color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                        ),

                        Container(
                          child: FlatButton(
                            onPressed: () {
                              ReservationData.caryear =  ApplicationLocalizations.of(context).translate("All");
                              ReservationData.carcategory = ApplicationLocalizations.of(context).translate("All");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SearchCar()));
//                                    if (CustomerData.CustomerType == 'Guest') {
//                                      AlertDialogShow(context);
//                                    } else {
//                                      if (offer == 'Offers') {
//                                        Navigator.pushReplacement(
//                                            context,
//                                            MaterialPageRoute(
//                                                builder: (context) => new MakeBooking(offer)),
//                                            result: (Route<dynamic> route())C => false);
                              // }
                              //      }
                            },


                      ),)]))
                ]),
              ),
            )));
  }
}

