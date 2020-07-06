import 'dart:convert';


import 'package:devicepreview/AppTranslation/AppTranslation.dart';
import 'package:devicepreview/ReservationInformationDesign/Airport.dart';
import 'package:devicepreview/ReservationInformationDesign/CarDesignForTotal.dart';
import 'package:devicepreview/ReservationInformationDesign/Innsurance.dart';
import 'package:devicepreview/ReservationInformationDesign/InnsuranceReservationsData.dart';
import 'package:devicepreview/ReservationInformationDesign/Options.dart';
import 'package:devicepreview/ReservationInformationDesign/OptionsReservation.dart';
import 'package:devicepreview/ReservationInformationDesign/ReservationInfo.dart';
import 'package:devicepreview/WidthAndHeighTWidget/Size_layout.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../CheckBox.dart';
import '../CustomerData.dart';
import '../OfferDataAvaliable.dart';
import '../ReservationData.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Urls.dart';
import 'FeedBack.dart';
import 'SecondStepChooseOptionAndInnsuranc.dart';

class TotalPrice extends StatefulWidget {
  @override
  _TotalPriceAndFinalStepsFoState createState() =>
      _TotalPriceAndFinalStepsFoState();
}

class _TotalPriceAndFinalStepsFoState
    extends State<TotalPrice> {
  @override
  bool agreement=false;
  double sum = 0,
      Totaloption = 0,
      tax,
      TotalDays = 0,
      TotalTaxAfterTax,
      TotalInssurance = 0,
      carprice;
  String offername;
  String locationTxt = "0",
      optionofferstate = 'No Option Offer ';
  int days = 0;
  List<OptionsReservation> optionReservation = [];

  void _submitCommanD() {
    print(ReservationData.UpdateReservation);

    if (CustomerData.checkagreemment == false) {
      setState(() {
        agreement=true;
      });

    } else {
      UploadData();
    }
  }
  Future<bool> _onWillPop() async {
    return (
        await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => new  SecondStepChooseOptionAndInnsyranc(),
            )));

  }
  @override
  void Total() {
    Totaloption = 0;
    TotalInssurance = 0;
    // tax = double.parse(ReservationData.taxamount);
    //print(tax);
    print("Options");
    for (var i = 0; i < ReservationData.optionname.length; i++) {
      String price1 = ReservationData.optionprice[i];
      double p = double.parse(price1.toString());
      double c = double.parse(ReservationData.optioncount[i].toString());
      print(c * p);
      print(ReservationData.optionname[i]);

      Totaloption = Totaloption + (c * p);
    }
    print(Totaloption);print("Innsurance");
    for (var i = 0; i < ReservationData.inssuracelistname.length; i++) {
      print(ReservationData.inssuranceprice[i]);
      print(ReservationData.inssuracelistname[i]);

      double p = double.parse(ReservationData.inssuranceprice[i]);      TotalInssurance = TotalInssurance + p;
    }
    tax = double.parse(ReservationData.taxamount);
    //ReservationData.inn=TotalInssurance;
    print(TotalInssurance);
    String price = ReservationData.price.toString();
    print(price);
    carprice = double.parse(price);

    sum = TotalInssurance + Totaloption + carprice;
    print("SUM");
    print(sum);
    print(ReservationData.resstatus);
    //if (ReservationData.resstatus == "Offers") {
    //  Offers();
    //} else {
    print("Reservation without Offer");
    days = ReservationData.ReservationDaysCount;
    TotalDays = sum * days;
    print(TotalDays);
    double tax2 = (tax * TotalDays) + TotalDays;
    TotalTaxAfterTax = num.parse(tax2.toStringAsFixed(2));
    TotalDays = sum * days;
    TotalDays = num.parse(TotalDays.toStringAsFixed(2));

    print(TotalDays);

  }

  void Offers() {
    switch (OfferDataAvaliable.offername) {
      case ("daysOffer"):
        days = ReservationData.totaldaysfree;
        print(days);
        TotalDays = sum * days;
        TotalDays = num.parse(TotalDays.toStringAsFixed(2));
        TotalTaxAfterTax = (TotalDays * tax) + TotalDays;
        TotalTaxAfterTax = TotalTaxAfterTax.roundToDouble();
        print("Sum Days Free");
        print(TotalDays);
        print(TotalTaxAfterTax);
        break;
      case ("fuelOffer"):
        days = ReservationData.ReservationDaysCount;
        print(days);
        TotalDays = sum * days;
        TotalDays = num.parse(TotalDays.toStringAsFixed(2));
        TotalTaxAfterTax = (TotalDays * tax) + TotalDays;
        TotalTaxAfterTax = num.parse(TotalTaxAfterTax.toStringAsFixed(2));
        print("Fuel Offer Free");
        print(TotalDays);
        print(TotalTaxAfterTax);
        break;
      case ("timeOffer"):
        days = ReservationData.ReservationDaysCount;
        print(days);
        TotalDays = sum * days;
        TotalDays = num.parse(TotalDays.toStringAsFixed(2));

        TotalTaxAfterTax = (TotalDays * tax) + TotalDays;
        TotalTaxAfterTax = num.parse(TotalTaxAfterTax.toStringAsFixed(2));
        print("Fuel Offer Free");
        print(TotalDays);
        print(TotalTaxAfterTax);
        break;

      case ("discountOffer"):
        sum=0;
        days = ReservationData.ReservationDaysCount;
        double discountrate = double.parse(OfferDataAvaliable.offerDiscount);
        sum = TotalInssurance + Totaloption + (carprice);
        TotalDays = (sum * days) ;
        TotalDays = num.parse(TotalDays.toStringAsFixed(2));

        TotalTaxAfterTax = (TotalDays * tax) + TotalDays;
        TotalTaxAfterTax = num.parse(TotalTaxAfterTax.toStringAsFixed(2));
        print("Discount Offer Free");
        print(TotalDays);
        print(TotalTaxAfterTax);

        break;
      case ("optionOffer"):
        Totaloption = 0;

        TotalDays = 0;
        days = ReservationData.ReservationDaysCount;
        double p = 0;
        int c = 0;
        for (var i = 0; i < ReservationData.optionname.length; i++) {
          print(ReservationData.optionname.length);

          p = double.parse(ReservationData.optionprice[i].toString());
          c = int.parse(ReservationData.optioncount[i].toString());
          if (ReservationData.optionname[i] == OfferDataAvaliable.option_ar ||
              ReservationData.optionname[i] == OfferDataAvaliable.option_en) {
            print("Found");

            Totaloption += (c - 1) * p;
          } else {
            print("ss");
            Totaloption = Totaloption + (c * p);
          }
        }
        print(Totaloption);
        print(days);
        TotalDays = (Totaloption + TotalInssurance + carprice) * days;
        TotalDays = num.parse(TotalDays.toStringAsFixed(2));

        TotalTaxAfterTax = (TotalDays * tax) + TotalDays;
        print("Sum");
        print(TotalDays);
        TotalTaxAfterTax = num.parse(TotalTaxAfterTax.toStringAsFixed(2));
        break;
    }
  }

  Future UploadData() async {
    String optionstatus = '',
        coin = '',
        innsurancestatue = '';

    if (OfferDataAvaliable.offername == null) {
      offername = 'normal';
    } else {
      offername = OfferDataAvaliable.offername;
    }

    if (ReservationData.optionname.length > 0) {
      optionstatus = '1';
    } else {
      optionstatus = '0';
    }
    if (ReservationData.inssuracelistname.length > 0) {
      innsurancestatue = '1';
    } else {
      innsurancestatue = '0';
    }
    print(ReservationData.groupid);
    if (ReservationData.Airport == true) {
      print("Flight" + ReservationData.returndate);
    } else {
      ReservationData.FlightDate = '0000-00-00';
      ReservationData.NumberFlight = "No";
      ReservationData.Flightime = '0:0000';
    }
    var data = Urls.MakeReservation;
    http.Response response = await http.post(data, body: {
      'pickupLocation': ReservationData.pickuploc,
      'returnLocation': ReservationData.returnlocation,
      'pickupDate': ReservationData.pickupdate,
      'pickupTime': ReservationData.pickuptime,
      'returnTime': ReservationData.returntime,
      'groupId': ReservationData.groupid,
      'driverLicenceNumber': CustomerData.lisence,
      'BirthDate': CustomerData.birhdate,
      'returnDate': ReservationData.returndate,
      'phoneNumber': CustomerData.phonenumber,
      'nationality': CustomerData.nationality,
      'email': CustomerData.Email,
      'reservationStaus': 'not show',
      'flightDate': ReservationData.FlightDate,
      'flightNumber': ReservationData.NumberFlight,
      'flightTime': ReservationData.Flightime,
      'customerType': '1',
      'customerId': CustomerData.customerid,
      'confirmation': '0',
      'priceBeforeTax': TotalDays.toString(),
      'priceAfterTax': TotalTaxAfterTax.toString(),
      'Name': CustomerData.firstname + ' ' + CustomerData.lastname,
      'options_status': optionstatus.toString(),
      'insurance_status': innsurancestatue.toString(),
      'option_count': ReservationData.optionname.length.toString(),
      'insurance_count': ReservationData.inssuracelistname.length.toString(),
      'offer_name': offername,
      'car_price_per_day': ReservationData.price,
      'passportNationalNumber': CustomerData.passport,
      'coin': ReservationData.coin,
      'free_days':OfferDataAvaliable.offerdayofree,
    });
    var C = json.decode(response.body);
    print(((C[0]["reservation_id"])));

    ReservationData.resid = (C[0]["reservation_id"]);
    Option();
    Innsurance();
  }

  Future<List<InnsuranceReservationData>> InnssuranceData2() async {
    List<InnsuranceReservationData> innsurance = [];
    String o = '';
    for (int i = 0; i < ReservationData.inssuracelistname.length; i++) {
      InnsuranceReservationData innsuranceData = new InnsuranceReservationData(
          ReservationData.inssuracelistname[i],

          ReservationData.inssuranceprice[i]);
      innsurance.add(innsuranceData);
    }
    return innsurance;
  }

  Future<List<OptionsReservation>> OptionReservation() async {
    List<OptionsReservation> option = [];
    String o = '';
    for (int i = 0; i < ReservationData.optionname.length; i++) {
      if (ReservationData.optionname[i] == OfferDataAvaliable.option_en ||
          ReservationData.optionname[i] == OfferDataAvaliable.option_ar) {
        o = 'yes';
      } else {
        o = 'no';
      }

      OptionsReservation option2 = new OptionsReservation(

          ReservationData.optionname[i],
          ReservationData.optioncount[i],
          ReservationData.optionprice[i],
          o);
      option.add(option2);
      print("nn" + option2.optionnameen);
      print("" + option.length.toString());
    }
    return option;
  }

  Future<String> Option() async {
    String o = '';
    if (ReservationData.optionname.length > 0) {
      for (int i = 0; i < ReservationData.optionname.length; i++) {
        if (ReservationData.optionname[i] == OfferDataAvaliable.option_en ||
            ReservationData.optionname[i] == OfferDataAvaliable.option_ar) {
          o = 'yes';
        } else {
          o = 'no';
        }
        var data = Urls.makeoption;

        http.Response response = await http.post(data, body: {
          'reservation_id': ReservationData.resid.toString(),
          'optionPrice': ReservationData.optionprice[i],
          'quantity': ReservationData.optioncount[i],
          'option_offer': o,
          'optionName': ReservationData.optionname[i],
        });
      }
    }
  }

  Future<String> Innsurance() async {
    if (ReservationData.inssuracelistname.length > 0) {
      for (int i = 0; i < ReservationData.inssuracelistname.length; i++) {
        var data = Urls.makeinnsurace;

        http.Response response = await http.post(data, body: {
          'reservation_id': ReservationData.resid.toString(),
          'InsurancePrice': ReservationData.inssuranceprice[i],
          'InsuranceName': ReservationData.inssuracelistname[i],
        });
        print("Enter d");
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => new FeedBackAndresNumber()),
            result: (Route<dynamic> route()) => false);
        ReservationData.inssuracelistname.clear();
        ReservationData.inssuranceprice.clear();
        ReservationData.optionname.clear();
        ReservationData.optionprice.clear();
        ReservationData.optioncount.clear();
      }
    } else {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => new FeedBackAndresNumber()),
          result: (Route<dynamic> route()) => false);
      ReservationData.inssuracelistname.clear();
      ReservationData.inssuranceprice.clear();
      ReservationData.optionname.clear();
      ReservationData.optionprice.clear();
      ReservationData.optioncount.clear();
    }
  }

  Widget build(BuildContext context) {
    Total();
    return  new WillPopScope(onWillPop: _onWillPop,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.indigo[900],
          ),
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
              child: Container(
                  margin: EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 5),
                  child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      color: Colors.white,
                      child: Container(
                          margin: EdgeInsets.only(
                              top: 10, bottom: 20, right: 5, left: 5),
                          width:double.infinity,
                          child:SafeArea(
                            child: Column(children: <Widget>[
                              Container(child: Container(child: Material(elevation: 5.0,borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                child:Column(children: <Widget>[ Container(
                                  child: ResrevationInfo(
                                      ApplicationLocalizations.of(context).translate("PickupLoc"),
                                      ReservationData.pickuploc),
                                ),
                                  Container(
                                    child: ResrevationInfo(
                                        ApplicationLocalizations.of(context).translate("returnloc"),
                                        ReservationData.returnlocation),
                                  ),
                                  Container(
                                      child: ResrevationInfo(
                                        ApplicationLocalizations.of(context).translate("Pickup_date") +
                                            " && " +
                                            ApplicationLocalizations.of(context).translate("Pickup_time") +
                                            ":",ReservationData.pickupdate+''+ReservationData.pickuptime,

                                      )),
                                  Container(
                                      child: ResrevationInfo(
                                          ApplicationLocalizations.of(context).translate("Return_date") +
                                              " && " +
                                              ApplicationLocalizations.of(context).translate("Return_Time") +
                                              ":",
                                          ReservationData.returndate +" ,"+

                                              ReservationData.returntime )),
                                  Container(
                                    child: Airport(),

                                  ),],) ,))),


                              Container(
                                child: CarDesignForTotal(),
                              ),
                              Container(
                                child: Options(Totaloption.toString()),
                              ),
                              Container(
                                child: InnsuranceDesign(TotalInssurance.toString()),
                              ),
                              //Container(child: TotalDesign(TotalDays.toString(),TotalTaxAfterTax.toString()),),
    Container(child: Container(
      width:double.infinity,
        margin: EdgeInsets.only(top: 30,left: 30,right: 30),
        child: Material(elevation: 5.0,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
    child:SafeArea(
      child: Column(children: <Widget>[ Container(
      child: ResrevationInfo(
      ApplicationLocalizations.of(context).translate("Total_Before_Tax"),
 ""+":"+TotalDays.toString()),
      ),
      Container(
      child: ResrevationInfo(
      ApplicationLocalizations.of(context).translate("Total_After_Tax"),
       ""+":"+TotalTaxAfterTax.toString()),
      ),]),
    )))),
                              Container(
                                width: MediaQuery.of(context).size.width/1.3,
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                                child: FittedBox(
                                  child: Row(children: <Widget>[
                                    Container(
                                      child: CheckBox("Agree"),
                                    ),
                                    SafeArea(
                                      child: Container(
                                        width:Size1.width_text,
                                        child: Text(
                                          ApplicationLocalizations.of(context).translate("Agreement"),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize:Size1.Font_size,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Container(child: Visibility( visible:agreement,child: (Icon(Icons.error,color: Colors.red,))),) ]),
                                ),
                              ),
                              Container(
                                height: Size1.height_of_button,
                                width: Size1.width_text,
                                margin: EdgeInsets.only(top: 30, bottom: 30),
                                child: RaisedButton(
                                    onPressed: () {
                                      _submitCommanD();
                                    },

//                    if(email.text==''){ print ("Vaild Email");}else{print(email.text);}},
                                    color: Colors.indigo[900],
                                    child: Text(
                                      ApplicationLocalizations.of(context).translate("Reserve"),
                                      style: TextStyle(
                                          fontSize: Size1.Font_size, color: Colors.white),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                    )),
                              ),

                            ]),
                          ))))
          )
      ),
    );
  }


}

