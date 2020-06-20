
import 'dart:async';
import 'dart:convert';


import 'package:flutter/material.dart';


import 'package:http/http.dart' as http;
import 'package:language/AppTranslation/AppTranslation.dart';
import 'package:language/CustomerInfo/CustomerData.dart';
import 'package:language/Login/Login.dart';
import 'package:language/OffersData/OfferData.dart';
import 'package:language/OffersData/OfferDataAvaliable.dart';
import 'package:language/Reservation/ReservationData.dart';
import 'package:language/Urls/BustanjiUrl.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  String Peroidofoffer;
  void initState() {
    // TODO: implement initState
    super.initState();
    anim(this.context);

  }

  List<String>images=[];
  Future<String> loadJsonImages() async {
    var url = await http.get(BustanjiUrls.urlimagesboutus);
    var user = json.decode(url.body);
    for (var u in user) {
      ReservationData.imageaboutus.add(u["image_link"]);
    }}
  void anim(BuildContext context){loadJsonImages();
  Future.delayed(Duration(seconds: 3), () {OfferData.coin=ApplicationLocalizations.of(context).translate("Currency");
  checkaccount();});}
  Future<String> checkaccount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString("email");
    var save = prefs.getString("Save");


    if (save == "true") {
      CustomerData.Email = prefs.getString("email");
      CustomerData.firstname = prefs.getString("firstname");
      CustomerData.lastname = prefs.getString("Lastname");
      CustomerData.Country = prefs.getString("country");
      CustomerData.phonenumber = prefs.getString("phone");
      CustomerData.city = prefs.getString("city");
      CustomerData.nationality = prefs.getString("nationality");
      CustomerData.gender = prefs.getString("gender");
      CustomerData.customerid = prefs.getString("customerid");
      CustomerData.Address = prefs.getString("Address");
      CustomerData.birhdate=prefs.getString("Birthdate");

    }else{
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                Login(),
          ));
    };
    offerData();}

  Future<Null> offerData() async {
    print("Dd");
    var url =
    await http.get(BustanjiUrls.offername);
    var user = json.decode(url.body);
    print("off"+user['offername']);
    OfferDataAvaliable.offername = user['offername'];
    if (OfferDataAvaliable.offername == null) {
    } else {
      print("There is Offer");
      DataOffer();
    }
  }

  Future<Null> DataOffer() async {
    String offername1='';
    var url =
    await http.get(BustanjiUrls.searchoffer);
    var user = json.decode(url.body);
    OfferDataAvaliable.offer_name_english = user[0]['offer_name_english'];
    OfferDataAvaliable.offer_name_arabic = user[0]['offer_name_arabic'];
    OfferDataAvaliable.category_id = user[0]['category_id'];
    OfferDataAvaliable.from_date = user[0]['from_date'];
    OfferDataAvaliable.to_date = user[0]['to_date'];
    if(CustomerData.Language=="Arabic"){user[0]['offer_name_arabic'];}
    else{offername1=user[0]['offer_name_english'];}
    switch (OfferDataAvaliable.offername) {
      case ("timeOffer"):
        OfferDataAvaliable.price = user[0]['price'];
        OfferDataAvaliable.dollar_price = user[0]['dollar_price'];
        OfferDataAvaliable.euro_price = user[0]['euro_price'];
        print(OfferDataAvaliable.offer_name_english);
        Peroidofoffer = offername1 +
            ' from ' +
            OfferDataAvaliable.from_date +
            ' to\n ' +
            OfferDataAvaliable.to_date +
            ''
                ' get Specail Price';

        OfferDataAvaliable.offersperooid = Peroidofoffer;
        break;
      case ("daysOffer"):
        OfferDataAvaliable.offerdaycount = user[0]['num_days'];
        OfferDataAvaliable.offerdayofree = user[0]['num_free_days'];
        OfferDataAvaliable.price = user[0]['price'];
        OfferDataAvaliable.dollar_price = user[0]['dollar_price'];
        OfferDataAvaliable.euro_price = user[0]['euro_price'];
        print(OfferDataAvaliable.offer_name_english);
        Peroidofoffer = offername1 +
            ' from ' +
            OfferDataAvaliable.from_date +
            ' to\n ' +
            OfferDataAvaliable.to_date +
            '';
        break;

      case ("fuelOffer"):
        OfferDataAvaliable.price = user[0]['price'];
        OfferDataAvaliable.dollar_price = user[0]['dollar_price'];
        OfferDataAvaliable.euro_price = user[0]['euro_price'];
        print(OfferDataAvaliable.offer_name_english);
        Peroidofoffer = OfferDataAvaliable.offer_name_english +
            ' from ' +
            OfferDataAvaliable.from_date +
            ' to\n ' +
            OfferDataAvaliable.to_date +
            ''
                ' get Specail Price';

        OfferDataAvaliable.offersperooid = Peroidofoffer;
        break;

      case ("discountOffer"):
        print("Discount Offer");
        OfferDataAvaliable.offerDiscount = user[0]['discount_rate'];
        OfferDataAvaliable.price = user[0]['price'];
        OfferDataAvaliable.dollar_price = user[0]['dollar_price'];
        OfferDataAvaliable.euro_price = user[0]['euro_price'];

        print(OfferDataAvaliable.offer_name_english);
        Peroidofoffer = OfferDataAvaliable.offer_name_english +
            ' from ' +
            OfferDataAvaliable.from_date +
            ' to\n ' +
            OfferDataAvaliable.to_date +
            '';
        print(OfferDataAvaliable.offerDiscount);
        OfferDataAvaliable.offersperooid = Peroidofoffer;
        break;

      case ('optionOffer'):
        OfferDataAvaliable.optionid=user[0]['option_id'];
        OfferDataAvaliable.price = user[0]['price'];
        OfferDataAvaliable.dollar_price = user[0]['dollar_price'];
        OfferDataAvaliable.euro_price = user[0]['euro_price'];
        option();
        break;
    }}
  Future<String>option()async{
    var url = BustanjiUrls.optionoffername;

    http.Response response = await http
        .post(url, body: {'option_id': OfferDataAvaliable.optionid});
    var user = json.decode(response.body);
    OfferDataAvaliable.option_ar=user[0]['option_name_arabic'];
    OfferDataAvaliable.option_en=user[0]['option_name_english'];
//print(user[0]['option_name_english']);

    Peroidofoffer = OfferDataAvaliable.offer_name_english +

        ' from ' +
        OfferDataAvaliable.from_date +
        ' to\n ' +
        OfferDataAvaliable.to_date +
        '';




  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(margin: EdgeInsets.only(top:
        100), child: Column(children: <Widget>[
          Center(
            child: Container(
              child: Image.network(
                "https://www.yarubhost.com/images/companylogo.png",
                height: 200,),
            ),
          ),
          Container(
              child: Center(
                child: CircularProgressIndicator(
                    value: null,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.indigo)),
              )
          )
        ],

        ),));
  }}