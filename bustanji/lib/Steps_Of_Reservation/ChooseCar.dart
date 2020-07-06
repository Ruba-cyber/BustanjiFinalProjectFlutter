import 'package:flutter/material.dart';

import 'package:devicepreview/Offers/OffersData.dart';
import '../CustomerData.dart';
import '../OfferDataAvaliable.dart';
import '../ReservationData.dart';
import 'package:devicepreview/AppTranslation/AppTranslation.dart';
import 'package:devicepreview/WidthAndHeighTWidget/Size_layout.dart';
import 'package:devicepreview/MakeBooking/MakeBooking.dart';
class ChooseCar extends StatelessWidget {
  AsyncSnapshot snapshot;
  int index;
  double CarPrice_Euro = 0.0,
      CarPrice_Dollar = 0.0;
  String warningmessage, price, offer, coin;
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

    switch (OffersData.coin) {
      case ("JD"):
        ReservationData.coin = 'JD';
        coin = 'JD';
        price = snapshot.data[index].price;
        break;
      case ("USD"):
        ReservationData.coin = 'USD';
        coin = "USD";
        if (OfferDataAvaliable.offername == "discountOffer") {
          double discountrate = double.parse(OfferDataAvaliable.offerDiscount);
          double carprice = double.parse(OfferDataAvaliable.dollar_price);
          double Usd_Price = carprice * discountrate;
          Usd_Price = num.parse(Usd_Price.toStringAsFixed(2));
          price = Usd_Price.toString();
        }
        price = snapshot.data[index].dollar_price;
        break;
      case ("EUR"):
        ReservationData.coin = 'EUR';
        coin = "EUR";
        if (OfferDataAvaliable.offername == "discountOffer") {
          double discountrate = double.parse(OfferDataAvaliable.offerDiscount);
          double carprice = double.parse(OfferDataAvaliable.euro_price);
          double sum_Euro = carprice * discountrate;
          sum_Euro = num.parse(sum_Euro.toStringAsFixed(2));
          price = sum_Euro.toString();
        } else {
          price = snapshot.data[index].euro_price;
        }
        break;
      default:
        ReservationData.coin = 'JD';
        coin = 'JD';
        price = snapshot.data[index].price;
        break;
    }
  }

  AlertDialogShow(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return Container(width: MediaQuery
              .of(context)
              .size
              .width / 2,
            height: MediaQuery
                .of(context)
                .size
                .height / 2,
            child: AlertDialog(
                title: Text('Warning'),
                content: Text(warningmessage),
                actions: <Widget>[
                  FittedBox(
                    child:
                    SafeArea(
                      child: Row(children: <Widget>[
                        MaterialButton(
                            elevation: 5.0,
                            onPressed: () {
//                        Navigator.of(context).pop();
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
                      ]),
                    ),
                  )
                ]),
          );
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
      body: SafeArea(
        child: Container(
            width: double.infinity,child: CarDesign(context),),),);

  }

  Widget CarDesign(BuildContext context) {
    return Container(
        width: double.infinity * 2,
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
              Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.only(
                              bottom: 10, top: 10, left: 10),
                          child: Image.network(
                            snapshot.data[index].car_image,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width /
                                3.4,
                            height: MediaQuery
                                .of(context)
                                .size
                                .width /
                                6.4,
                          )),
                      Container(margin: EdgeInsets.only(left: 10, right: 10),
                          child:
                          FittedBox(fit: BoxFit.scaleDown,

                            child: Row(children: <Widget>[
                              Container(
                                //padding: (EdgeInsets.all(2)),
                                child: FittedBox(fit: BoxFit.scaleDown,
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
                                          snapshot.data[index].passenger),
                                    ),
                                  ]),
                                ),
                              ),
                              Container(
                                child: Row(children: <Widget>[
                                  Container(

                                    padding: EdgeInsets.all(4),
                                    child: Image.network(
                                      "https://encrypted-tbn0.gstatic.com/"
                                          "images?q=tbn%3AANd9GcRAnSdWWPCYXS1jmDaF_VhIPJR81UVTCZFNL1H3yByIAxd4vwx7",
                                      width: Size1.size_icon,),
                                  ),
                                  Container(
                                    width: Size1.size_icon,
                                    padding: EdgeInsets.all(5),
                                    child:
                                    Text(snapshot.data[index].luggage),
                                  ),
                                ]),
                              ),
                            ]),
                          )),

                      Container(margin: EdgeInsets.only(left: 10, right: 10),
                        child: Row(children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(2),
                            child: Image.network(
                              "https://3.imimg.com/data3/VT/QG/GLADMIN-140882/car-door-250x250.jpg",
                              width: Size1.size_icon * 5,),
                            width: Size1.size_icon,),
                          Container(
                            width: Size1.size_icon,
                            padding: EdgeInsets.all(5),
                            child: Text(snapshot.data[index].doors,
                                style: TextStyle(fontSize: Size1.Font_size,)),
                          ),
                          Container(
                            width: 80,
                            padding: EdgeInsets.only(left: 15, right: 15),
                            child: Text(
                              snapshot.data[index].car_year,
                              style: TextStyle(fontSize: Size1.Font_size),
                            ),
                          ),
                        ]),
                      ),

                    ]),
              ),
              Container(margin: EdgeInsets.only(left: 30, right: 30),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        Container(
                          padding: EdgeInsets.only(
                              left: 10, right: 10, top: 10),
                          child: Text(
                            snapshot.data[index].car_model_english,
                            style: TextStyle(
                                fontSize: Size1.Font_size,
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: 10, right: 10, top: 0),
                          child: Text(
                            snapshot.data[index].transmission,
                            style: TextStyle(
                                fontSize: Size1.Font_size,
                                color: Colors.black),
                          ),
                        ),

                        Container(
                          padding: EdgeInsets.only(
                              top: 5,
                              left: 0,
                              bottom: 5,
                              right: 0),
                          child: Container(
                            child: Flexible(
                              child: Row(mainAxisAlignment: MainAxisAlignment
                                  .start,
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
                                      visiblecolorred,
                                    ),
                                  ),
                                  Container(
                                      padding: EdgeInsets.only(
                                          left: 2, right: 2),
                                      child: Offstage(
                                          offstage: visiblecolorblue,

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
                                        visiblecolorgreen,
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
                                      visiblecolorblack,
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
                        ), //,),
                        Container(
                          padding: EdgeInsets.only(
                              top: 5,
                              left: 20,
                              bottom: 5,
                              right: 20),
                          child: Container(

                            child: Flexible(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: 30,
                                    height: 20,
                                    child: Offstage(
                                      child: Container(padding: EdgeInsets.only(
                                          left: 2, right: 2),
                                        decoration: BoxDecoration(
                                          border: Border.all(),
                                          color: Colors.grey,
                                        ),
                                      ),
                                      offstage:
                                      visiblecolorgrey,
                                    ),
                                  ),
                                  Container(
                                      padding: EdgeInsets.only(left: 2, right: 2),
                                      child: Offstage(
                                          offstage: visiblecoloryellow,

                                          child: (Container(
                                            padding: EdgeInsets.only(
                                                left: 2, right: 2),
                                            decoration: BoxDecoration(
                                              border: Border.all(),
                                              color: Colors.yellow,
                                            ),
                                            width: 30,
                                            height: 20,
                                          )))),

                                  Offstage(
                                      offstage:
                                      visiblecoloewhite,
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            left: 2, right: 2),
                                        decoration: BoxDecoration(
                                          border: Border.all(),
                                          color: Colors.white,
                                        ),
                                        width: 30,
                                        height: 20,
                                      )),
                                  Offstage(
                                    offstage:
                                    visiblecolorgrey,
                                    child: Container(
                                      padding: EdgeInsets.only(left: 2, right: 2),
                                      decoration: BoxDecoration(
                                        border: Border.all(),
                                        color: Colors.orangeAccent,
                                      ),
                                      width: 30,
                                      height: 20,
                                    ),
                                  ),
                                  //,padding: EdgeInsets.only(left: 50,right: 10,top: 10)),
                                ],
                              ),
                            ),
                          ),
                        ),
                        //,),
                        Center(
                          child: Container(
                            padding: EdgeInsets.all(20),
                            child: Text(
                           price+ ' '+coin,
                              style: TextStyle(
                                  fontSize: Size1.Font_size,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
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
                                ReservationData.bag =
                                    snapshot.data[index].luggage;
                                ReservationData.door =
                                    snapshot.data[index].doors;
                                ReservationData.imagecar =
                                    snapshot.data[index].car_image;
                                ReservationData.transmission =
                                    snapshot.data[index].transmission;
                                ReservationData.year =
                                    snapshot.data[index].car_year;
                                ReservationData.cartype =
                                    snapshot.data[index].car_model_english;
                                ReservationData.colorsliver =
                                    visiblecolorgold;
                                ReservationData.colorgrey =
                                    visiblecolorgrey;
                                ReservationData.colorblue =
                                    visiblecolorblue;
                                ReservationData.colorgreen =
                                    visiblecolorgreen;
                                ReservationData.colorred = visiblecolorred;
                                ReservationData.colorblack =
                                    visiblecolorblack;
                                ReservationData.colorwhite =
                                    visiblecoloewhite;
                                ReservationData.coloryellow =
                                    visiblecoloryellow;
                                ReservationData.price = price;
                                ReservationData.groupid =
                                    snapshot.data[index].groupid;
                                ReservationData.coin = coin;


                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                        new MakeBooking(offer)));
                              }
                            },
                            child: Text(
                              ApplicationLocalizations.of(context)
                                  .translate("Reserve"),
                              style: TextStyle(fontSize: Size1.Font_size,
                                  color: Colors.black),
                            ),
                          ),
                        ),

                      ])),
            ]),
          ),
        )));
  }
}