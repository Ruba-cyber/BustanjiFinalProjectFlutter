import 'dart:async';
import 'dart:io' ;
import 'package:devicepreview/HomePage/HomePage.dart';
import 'package:devicepreview/AboutUS/AboutUs.dart';
import 'package:devicepreview/BustanjiBranch/BranchLocation.dart';
import 'package:devicepreview/Customer_Search/CustomerBooikingsearch.dart';
import 'package:devicepreview/Login/Login.dart';
import 'package:devicepreview/SearchCar/SearchCar.dart';
import 'package:flutter/material.dart';
import 'package:devicepreview/Emergency/Emergency.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import'AppTranslation/AppTranslation.dart';
import 'CustomerData.dart';
import 'OfferDataAvaliable.dart';
import 'Offers/OffersData.dart';
import 'ReservationData.dart';
import 'Urls.dart';
import 'package:http/http.dart' as http;

import 'WidthAndHeighTWidget/Size_layout.dart';
import 'main.dart';

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
Coin();

  }


  @override

  void checksavelanguage()async{
    print("CheckLanguage");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String Languagecode=prefs.getString("Language");
    print("Save "+Languagecode);
    Locale langauge;
    switch(Languagecode){
      case("en"):langauge=Locale("en","US");
      CustomerData.Language="English";
      break;
      case("ar"):langauge=Locale("ar","SA");
      CustomerData.Language="Arabic";

      break;





    }  print("Language"+CustomerData.Language);
    LocalisedApp.setLocale(context,langauge);
  }
    Future<List<String>> Coin() async {
List<String>coinlist=[];
      print(OffersData.coin);
      var url = await http.get(Urls.getcoin);
      coinlist.clear();
      var coin = json.decode(url.body);
      for (var u in coin) {
        // print(coin[u]['shortcut']);
        coinlist.add(u['shortcut']);
        print(u['shortcut']);



        setState(() {
          OffersData.coin=''+OffersData.coin;

        });}
      ReservationData.Coins.clear();
      for(int i=0;i<coinlist.length;i++){
        ReservationData.Coins.add(coinlist[i]);
      }}




    List<String>images=[];
  Future<String> loadJsonImages() async {
    var url = await http.get(Urls.urlimagesboutus);
    var user = json.decode(url.body);
    for (var u in user) {
      ReservationData.imageaboutus.add(u["image_link"]);
    }}
  void anim(BuildContext context){loadJsonImages();
  Future.delayed(Duration(seconds: 3), () {
    OffersData.coin=ApplicationLocalizations.of(context).translate("Currency");

    checkaccount();});}
  Future<String> checkaccount() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

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
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                HomePage(),
          ));
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

    var url =
    await http.get(Urls.offername);
    var user = json.decode(url.body);
    print("off"+user['offername']);
    OfferDataAvaliable.offername = user['offername'];
    if (OfferDataAvaliable.offername == null) {
    } else {
      print("There is Offer");

    }
DataOffer();
  }

  Future<Null> DataOffer() async {
print(CustomerData.Language);
    String offername1='';

    var url =
    await http.get(Urls.searchoffer);
    var user = json.decode(url.body);
    OfferDataAvaliable.offer_name_english = user[0]['offer_name_english'];
    OfferDataAvaliable.offer_name_arabic = user[0]['offer_name_arabic'];
    OfferDataAvaliable.category_id = user[0]['category_id'];
    OfferDataAvaliable.from_date = user[0]['from_date'];
    OfferDataAvaliable.to_date = user[0]['to_date'];

    if(CustomerData.Language=="Arabic"){
      setState(() {
      offername1= OfferDataAvaliable.offer_name_arabic +''+ApplicationLocalizations.of(context).translate("From") +' '+
          OfferDataAvaliable.from_date +' '+  ApplicationLocalizations.of(context).translate("To")+OfferDataAvaliable.to_date;

      OfferDataAvaliable.offersperooid=offername1;

    });}

    else{ setState(() {
      offername1= OfferDataAvaliable.offer_name_english +' '+ApplicationLocalizations.of(context).translate("From") +' '+
          OfferDataAvaliable.from_date +''+OfferDataAvaliable.to_date;
          ApplicationLocalizations.of(context).translate("To");
      OfferDataAvaliable.offersperooid=offername1;});}

    switch (OfferDataAvaliable.offername) {
      case ("timeOffer"):
        OfferDataAvaliable.price = user[0]['price'];
        OfferDataAvaliable.dollar_price = user[0]['dollar_price'];
        OfferDataAvaliable.euro_price = user[0]['euro_price'];
        print(OfferDataAvaliable.offer_name_english);
        Peroidofoffer = offername1 ;


        OfferDataAvaliable.offersperooid = Peroidofoffer;
        break;
      case ("daysOffer"):
        OfferDataAvaliable.offerdaycount = user[0]['num_days'];
        OfferDataAvaliable.offerdayofree = user[0]['num_free_days'];
        OfferDataAvaliable.price = user[0]['price'];
        OfferDataAvaliable.dollar_price = user[0]['dollar_price'];
        OfferDataAvaliable.euro_price = user[0]['euro_price'];
        print(OfferDataAvaliable.offer_name_english);
        Peroidofoffer = offername1 ;

        break;

      case ("fuelOffer"):
        OfferDataAvaliable.price = user[0]['price'];
        OfferDataAvaliable.dollar_price = user[0]['dollar_price'];
        OfferDataAvaliable.euro_price = user[0]['euro_price'];
        print(OfferDataAvaliable.offer_name_english);
        Peroidofoffer = offername1;


        OfferDataAvaliable.offersperooid = Peroidofoffer;
        break;

      case ("discountOffer"):
        print("Discount Offer");
        OfferDataAvaliable.offerDiscount = user[0]['discount_rate'];
        OfferDataAvaliable.price = user[0]['price'];
        OfferDataAvaliable.dollar_price = user[0]['dollar_price'];
        OfferDataAvaliable.euro_price = user[0]['euro_price'];
        print(OfferDataAvaliable.offer_name_english);
        double discountrate = double.parse(OfferDataAvaliable.offerDiscount);
        double carprice=double.parse(OfferDataAvaliable.price);
        double sum=carprice *discountrate;
        sum=num.parse(sum.toStringAsFixed(2));
        OfferDataAvaliable.price=sum.toString();
        Peroidofoffer = offername1;
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
    var url = Urls.optionoffername;

    http.Response response = await http
        .post(url, body: {'option_id': OfferDataAvaliable.optionid});
    var user = json.decode(response.body);
    OfferDataAvaliable.option_ar=user[0]['option_name_arabic'];
    OfferDataAvaliable.option_en=user[0]['option_name_english'];
//print(user[0]['option_name_english']);






  }

  @override
  Widget build(BuildContext context) {
   // Size1 size= new Size1(context);

    return Scaffold(
      resizeToAvoidBottomPadding: false,
        body: Container(margin: EdgeInsets.all(50),
          child: FittedBox(
            child: Column(

              children: <Widget>[
            Container(
              child: FittedBox(fit:BoxFit.scaleDown,
                child: Center(
                  child: Container(margin: EdgeInsets.all(100),
                    child: Image.network(
                      "https://www.yarubhost.com/images/companylogo.png",
                      height: Size1.height_splash_Screen,width: Size1.width_splash_Screen,),
                  ),
                ),
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

        ),
          ),));
  }
}
