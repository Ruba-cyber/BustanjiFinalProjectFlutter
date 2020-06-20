
import 'package:flutter/material.dart';
import 'package:language/AppTranslation/AppTranslation.dart';
import 'package:language/CustomerInfo/CustomerData.dart';
import 'package:language/OffersData/OfferData.dart';
import 'package:language/Reservation/ReservationData.dart';



class ChooseCar extends StatelessWidget {
  AsyncSnapshot snapshot;
  int index;
  String warningmessage, price, offer,coin;
  bool visiblecolorred = false,
      visiblecolorgreen = false,
      visiblecolorblue = false,
      visiblecoloewhite,
      visiblecolorblack,
      visiblecoloryellow,
      visiblecolorgrey,
      visiblecolorgold;

  ChooseCar(this.snapshot, this.index, this.warningmessage, this.offer) {}

  void setcolors() {
    if (snapshot.data[index].red == "1") {
      //  print('its red');
      visiblecolorred = true;
    } else {
      visiblecolorred = false;
    }
    if (snapshot.data[index].green == "1") {
      print('its green');
      //  visiblecolorgreen = true;
    } else {
      visiblecolorgreen = false;
    }
    if (snapshot.data[index].blue == "1") {
      ///  print('its blue');
      visiblecolorblue = true;
    } else {
      visiblecolorblue = false;
    }
    if (snapshot.data[index].white == "1") {
      //  print('its white');
      visiblecoloewhite = true;
    } else {
      visiblecoloewhite = false;
    }
    if (snapshot.data[index].sliver == "1") {
      //  print('its grey');
      visiblecolorgrey = true;
    } else {
      visiblecolorgrey = false;
    }
    if (snapshot.data[index].gold == "1") {
      //   print('its gold');
      visiblecolorgold = true;
    } else {
      visiblecolorgold = false;
    }
    if (snapshot.data[index].black == "1") {
      //   print('its black');
      visiblecolorblack = true;
    } else {
      visiblecolorblack = false;
    }
    if (snapshot.data[index].yellow == "1") {
      //  print('its yellow');
      visiblecoloryellow = true;
    } else {
      visiblecoloryellow = false;
    }
  }

  void setPrice() {
    price = snapshot.data[index].price;
    if (CustomerData.CustomerType == 'Guest') {
      //     print(snapshot.data[index].price);
      price = snapshot.data[index].price;
    }

    switch(OfferData.coin){
      case("JD"): ReservationData.coin='JD';coin='JD' ;  price = snapshot.data[index].price;break;
      case("USD"):ReservationData.coin='USD';coin="USD";price=snapshot.data[index].dollar_price;break;
      case("EUR"):ReservationData.coin='EUR';coin="EUR";price=snapshot.data[index].euro_price;break;
      default: ReservationData.coin=coin;coin='JD' ;  price = snapshot.data[index].price;break;
    }}

  AlertDialogShow(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text('Warning'),
              content: Text(warningmessage),
              actions: <Widget>[
                Row(children: <Widget>[
                  MaterialButton(
                      elevation: 5.0,
                      onPressed: () {
                        Navigator.of(context).pop();
//                        Navigator.push(
//                            context,
//                            MaterialPageRoute(
//                              builder: (context) => HomePage(),
//                            ));
                      },
                      child: Text("ok")),
                  MaterialButton(
                    elevation: 5.0,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Cancel"),
                  )
                ])
              ]);
        });
  }

  @override
  Widget build(BuildContext context) {
//  showDialog(context: cont)ext,builder: (context){
//    return AlertDialog();
//  });

    setcolors();
    setPrice();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
          margin: EdgeInsets.only(left: 5, right: 5),
          child: Material(
              elevation: 5.0,
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              color: Colors.white,
              child: Row(children: <Widget>[
                Container(
                  child: Column(children: <Widget>[
                    Container(
                        padding: EdgeInsets.only(bottom: 10, top: 10, left: 10),
                        child: Image.network(
                          snapshot.data[index].car_image,
                          width: MediaQuery.of(context).size.width / 2.4,
                          height: 120,
                        )),
                    Container(
                        child: Row(children: <Widget>[
                          Container(
                            //padding: (EdgeInsets.all(2)),
                            child: Row(children: <Widget>[
                              Container(
                                width: 40,
                                padding: EdgeInsets.all(2),
                                child: Icon(Icons.person),
                              ),
                              Container(
                                width: 30,
                                padding: EdgeInsets.all(5),
                                child: Text(snapshot.data[index].passenger),
                              ),
                            ]),
                          ),
                          Container(
                            child: Row(children: <Widget>[
                              Container(
                                width: 40,
                                padding: EdgeInsets.all(2),
                                child: Image.network(
                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRAnSdWWPCYXS1jmDaF_VhIPJR81UVTCZFNL1H3yByIAxd4vwx7"),
                              ),
                              Container(
                                width: 30,
                                padding: EdgeInsets.all(5),
                                child: Text(snapshot.data[index].luggage),
                              ),
                            ]),
                          ),
                        ])),
                    Container(
                      child: Row(children: <Widget>[
                        Container(
                          width: 40,
                          padding: EdgeInsets.all(2),
                          child: Image.network(
                              "https://3.imimg.com/data3/VT/QG/GLADMIN-140882/car-door-250x250.jpg"),
                        ),
                        Container(
                          width: 20,
                          padding: EdgeInsets.all(5),
                          child: Text(snapshot.data[index].doors),
                        ),
                        Container(
                          width: 80,
                          padding: EdgeInsets.only(left: 20),
                          child: Text(snapshot.data[index].car_year),
                        ),
                      ]),
                    ),
                  ]),
                ),
                Container(
                    child: Column(children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left:30, right: 30, top: 10),
                        child: Text(
                          snapshot.data[index].car_model_english,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left:30, right: 30, top: 5,bottom: 5),
                        child: Text(
                          snapshot.data[index].transmission,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ),
                      Container(
                        padding:
                        EdgeInsets.only(top: 0, left: 20, bottom: 10, right: 20),

                        child: Row(
                          children: <Widget>[
                            Offstage(

                                offstage: visiblecolorred,
                                child: Padding(
                                  padding:  EdgeInsets.only(left: 2,right: 2),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(), color: Colors.red[500]),
                                    width: 30,
                                    height: 20,
                                  ),
                                )),
                            Offstage(

                                offstage: visiblecolorblue,
                                child: Container(
                                  padding: EdgeInsets.only(left: 2,right: 2),
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                    color: Colors.blue,
                                  ),
                                  width: 30,
                                  height: 20,
                                )),
                            Offstage(

                              offstage: visiblecolorgreen,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 2,right: 2),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                    color: Colors.green,
                                  ),
                                  width: 30,
                                  height: 20,
                                ),
                              ),
                            ),
                            Offstage(

                                offstage:visiblecolorblack,
                                child: Container(
                                    width: 30,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      border: Border.all(),
                                      color: Colors.black,
                                    ))),

                            //,padding: EdgeInsets.only(left: 50,right: 10,top: 10)),
                          ],
                        ),
                      ),
                      Container(
                        padding:
                        EdgeInsets.only(top: 0, left: 20, bottom: 10, right: 20),

                        child: Row(
                          children: <Widget>[
                            Offstage(

                                offstage: visiblecolorgrey,
                                child: Padding(
                                  padding:  EdgeInsets.only(left: 2,right: 2),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(), color: Colors.grey),
                                    width: 30,
                                    height: 20,
                                  ),
                                )),
                            Offstage(

                                offstage: visiblecoloryellow,
                                child: Container(
                                  padding: EdgeInsets.only(left: 2,right: 2),
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                    color: Colors.yellow,
                                  ),
                                  width: 30,
                                  height: 20,
                                )),
                            Offstage(

                              offstage: visiblecoloewhite,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 2,right: 2),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                    color: Colors.white,
                                  ),
                                  width: 30,
                                  height: 20,
                                ),
                              ),
                            ),
                            Offstage(

                                offstage: visiblecolorgold,
                                child: Container(
                                    width: 30,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      border: Border.all(),
                                      color: Colors.orangeAccent,
                                    ))),

                            //,padding: EdgeInsets.only(left: 50,right: 10,top: 10)),
                          ],

                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(0),
                        child: Text(
                          price+' '+coin,
                          style: TextStyle(fontSize: 20, color: Colors.black,fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        child: FlatButton(
                          onPressed: () {
                            if (CustomerData.CustomerType == 'Guest') {
                              AlertDialogShow(context);
                            } else {
                              ReservationData.imagecar =
                                  snapshot.data[index].car_image;
                              ReservationData.passager =
                                  snapshot.data[index].passenger;
                              ReservationData.bag = snapshot.data[index].luggage;
                              ReservationData.door = snapshot.data[index].doors;
                              ReservationData.imagecar =
                                  snapshot.data[index].car_image;
                              ReservationData.transmission =
                                  snapshot.data[index].transmission;
                              ReservationData.year = snapshot.data[index].car_year;
                              ReservationData.cartype = snapshot.data[index].car_model_english;
                              ReservationData.colorsliver = visiblecolorgold;
                              ReservationData.colorgrey = visiblecolorgrey;
                              ReservationData.colorblue = visiblecolorblue;
                              ReservationData.colorgreen = visiblecolorgreen;
                              ReservationData.colorred = visiblecolorred;
                              ReservationData.colorblack = visiblecolorblack;
                              ReservationData.colorwhite = visiblecoloewhite;
                              ReservationData.coloryellow = visiblecoloryellow;
                              ReservationData.price = price;
                              ReservationData.groupid=snapshot.data[index].groupid;
                              ReservationData.coin=coin;

//
//                              Navigator.pushReplacement(
//                                  context,
//                                  MaterialPageRoute(
//                                      builder: (context) =>
//                                      new MakeBooking(offer)),
//                                  result: (Route<dynamic> route()) => false);
                            }



                          },
                          child: Text(
                            ApplicationLocalizations.of(context).translate("Reserve"),
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                        ),
                      ),
                    ])),
              ]))),
    );
  }
  Widget colorred(){
    if(visiblecolorred==true){
      return   Container(
          width: 30,
          height: 20,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(),
              color: Colors.red[500],
            ),
          ));
    }}

  Widget colorblue(){
    if(visiblecolorblue==true){
      return   Container(
          width: 30,
          height: 20,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(),
              color: Colors.blue[500],
            ),
          ));
    }
  }
  Widget colorblack(){
    if(visiblecolorblack==true){
      return   Container(
          width: 30,
          height: 20,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(),
              color: Colors.black,
            ),
          ));
    }
    Widget colorgreen() {
      if (visiblecolorgreen == true) {
        return Container(
            width: 30,
            height: 20,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(),
                color: Colors.red[500],
              ),
            ));
      }
    }}}