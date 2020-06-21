import 'dart:convert';


import 'package:fluttertoast/fluttertoast.dart';
import 'package:language/AppTranslation/AppTranslation.dart';
import 'package:language/CustomerInfo/CustomerData.dart';
import 'package:language/MyBooking/InnsuranceReservationsData.dart';
import 'package:language/MyBooking/OptionsReservation.dart';

import 'package:language/OffersData/OfferData.dart';
import 'package:language/OffersData/OfferDataAvaliable.dart';
import 'package:language/Reservation/ReservationData.dart';
import 'package:language/ReservationInformationDesign/Airport.dart';
import 'package:language/ReservationInformationDesign/CarDesignForTotal.dart';
import 'package:language/ReservationInformationDesign/Options.dart';
import 'package:language/ReservationInformationDesign/ReservationInfo.dart';
import 'package:language/ReservationInformationDesign/TotalDesign.dart';
import 'package:language/ReservationSteps/FeedBack.dart';
import 'package:language/Urls/BustanjiUrl.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../CheckBox.dart';


class TotalPriceAndFinalStepsForReservation extends StatefulWidget {
  @override
  _TotalPriceAndFinalStepsFoState createState() =>
      _TotalPriceAndFinalStepsFoState();
}

class _TotalPriceAndFinalStepsFoState
    extends State<TotalPriceAndFinalStepsForReservation> {
  @override
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
      Fluttertoast.showToast(
          msg: "Please Agree  The conditional Terms",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      UploadData();
    }
  }

  @override
  void Total() {
    Totaloption = 0;
    TotalInssurance = 0;
    tax = double.parse(ReservationData.taxamount);
    print(tax);
    print("Options");
    for (var i = 0; i < ReservationData.optionname.length; i++) {
      String price1 = ReservationData.optionprice[i];
      double p = double.parse(price1.toString());
      double c = double.parse(ReservationData.optioncount[i].toString());
      print(c * p);
      print(ReservationData.optionname[i]);

      Totaloption = Totaloption + (c * p);
    }
    print(Totaloption);
    print("Innsurance");
    for (var i = 0; i < ReservationData.inssuracelistname.length; i++) {
      print(ReservationData.inssuranceprice[i]);
      print(ReservationData.inssuracelistname[i]);

      double p = double.parse(ReservationData.inssuranceprice[i]);
      TotalInssurance = TotalInssurance + p;
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
    if (ReservationData.resstatus == "Offers") {
      Offers();
    } else {
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
        days = ReservationData.ReservationDaysCount;
        double discountrate = double.parse(OfferDataAvaliable.offerDiscount);

        TotalDays = (sum * days) * discountrate;
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
      offername = 'No offer';
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
      ReservationData.NumberFlight = " No ";
      ReservationData.Flightime = '0:0000';
    }
    var data = BustanjiUrls.MakeReservation;
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
        o = 'Yes';
      } else {
        o = 'No';
      }

      OptionsReservation option2 = new OptionsReservation(
          ReservationData.optionname[i],
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
        var data = BustanjiUrls.makeoption;

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
        var data = BustanjiUrls.makeinnsurace;

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
    return Scaffold(
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
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
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
                                     ":",
                                    ApplicationLocalizations.of(context).translate("Pickup_date") +
                                     "," +
                                        ApplicationLocalizations.of(context).translate("Pickup_time"))),
                         Container(
                             child: ResrevationInfo(
                                    ApplicationLocalizations.of(context).translate("Pickup_date") +
                                     " && " +
                                        ApplicationLocalizations.of(context).translate("Pickup_time") +
                                     ":",
                                 ReservationData.pickupdate +" ,"+

                                     ReservationData.pickupdate )),
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
                        child: Options(TotalInssurance.toString()),
                      ),
              Container(child: TotalDesign(TotalDays.toString(),TotalTaxAfterTax.toString()),),

              Container(
                width: 380,
                padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                child: FittedBox(
                  child: Row(children: <Widget>[
                    Container(
                      child: CheckBox("Agree"),
                    ),
                    Container(
                      width: 350,
                      child: Text(
                          ApplicationLocalizations.of(context).translate("Agree"),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ]),
                ),
              ),
              Container(
                  height: 50,
                  width: 200,
              margin: EdgeInsets.only(top: 10, bottom: 10),
              child: RaisedButton(
                  onPressed: () {
                    _submitCommanD();
                  },

//                    if(email.text==''){ print ("Vaild Email");}else{print(email.text);}},
                  color: Colors.indigo[900],
                  child: Text(
                      ApplicationLocalizations.of(context).translate("Reserve"),
                    style: TextStyle(
                        fontSize: 20, color: Colors.white),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.all(Radius.circular(10.0)),
                  )),
            ),
            ]))))
    )
    );
  }


  }

