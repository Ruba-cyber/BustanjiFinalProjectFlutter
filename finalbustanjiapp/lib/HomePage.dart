import 'package:flutter/material.dart';



import 'package:http/http.dart' as http;
import 'package:language/AppTranslation/AppTranslation.dart';
import 'package:language/AppTranslation/Application.dart';

import 'package:language/NavigationDrawer/NavigationDrawer.dart';

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'CustomerInfo/CustomerData.dart';
import 'OffersData/Offer.dart';
import 'OffersData/OfferData.dart';
import 'Reservation/ReservationData.dart';
import 'SplashScreen/SpalshScreen.dart';
import 'Urls/BustanjiUrl.dart';
import 'main.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();



}
const String English='en',Arabic='ar';


class _HomePageState extends State<HomePage> {

  static final List<String> languagesList = application.supportedLanguages;
  static final List<String> languageCodesList =
      application.supportedLanguagesCodes;

  final Map<dynamic, dynamic> languagesMap = {
    languagesList[0]: languageCodesList[0],
    languagesList[1]: languageCodesList[1],
  };

  List<String> _myJson = [];
  String _mySelection,language;Locale _locale;
  void  ChooseLanguage(){

  }
  Future<bool> _onWillPop() async {
    return (
        await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            )));

  }
  Future<Locale>setLocale(String Languagecode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("Language", Languagecode);

    setLanguage(Languagecode);
  }
  Locale setLanguage(String Language){

  }
  Future<List<String>> Data() async {

    print(OfferData.coin);
    var url = await http.get(BustanjiUrls.getcoin);
    _myJson.clear();
    var coin = json.decode(url.body);
    for (var u in coin) {
      // print(coin[u]['shortcut']);
      _myJson.add(u['shortcut']);
      print(u['shortcut']);



      setState(() {
        OfferData.coin=''+OfferData.coin;

      });}
    ReservationData.Coins.clear();
    for(int i=0;i<_myJson.length;i++){
      ReservationData.Coins.add(_myJson[i]);
    }}

  void onLocaleChange(Locale locale) async {
    Locale chooselanguage;
    switch(locale.languageCode){
      case("en"):chooselanguage=Locale('en','US');
      CustomerData.Language="English";
      break;
      case("ar"):chooselanguage=Locale('ar','SA');
      CustomerData.Language="Arabic";break;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("Language",chooselanguage.languageCode);
    LocalisedApp.setLocale(context,chooselanguage);
  }
  void _select(String language) {
    print("dd " + language);
    setState(() {
      CustomerData.Language = language;
      print(CustomerData.Language);
      onLocaleChange(Locale(languagesMap[language]));
    });
  }
  AlertDialogShow(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text(ApplicationLocalizations.of(context).translate("Restart_App") ),
              content: Text(ApplicationLocalizations.of(context).translate("Restart_App_Warning")),
              actions: <Widget>[
                Row(children: <Widget>[
                  MaterialButton(
                      elevation: 5.0,
                      onPressed: () {

                        Navigator.of(context).pop();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SplashScreen(),
                            ));
                      },
                      child: Text(ApplicationLocalizations.of(context).translate("ok"))),
                  MaterialButton(
                    elevation: 5.0,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(ApplicationLocalizations.of(context).translate("Cancel")),
                  )
                ])]);});}

  @override
  Widget build(BuildContext context) {Data();
  return Scaffold(
      resizeToAvoidBottomInset: false,

      appBar: new AppBar(
        backgroundColor: Colors.indigo

        ,
        title:


    Container(margin:EdgeInsets.only(left: 20),padding:EdgeInsets.only(left: 30,right: 10),
    decoration: BoxDecoration(
    border: Border.all(),
    color: Colors.white,
    ),
          child: new DropdownButton<String>(
            isDense: true,
            hint: new Text(OfferData.coin,style: TextStyle(color: Colors.black),),


            onChanged: (String newValue) {

              setState(() {

                OfferData.coin = newValue;
                print (_mySelection);


              });


            },
            items: _myJson.map((  item) {
              return new DropdownMenuItem<String>(
                value: item.toString(),
                child: new Text(item.toString(),
                ),
              );
            }).toList(),
          ),
        ),



        actions: <Widget>[
          PopupMenuButton<String>(
            // overflow menu
            onSelected: _select,
            icon: new Icon(Icons.language, color: Colors.white),
            itemBuilder: (BuildContext context) {
              return languagesList
                  .map<PopupMenuItem<String>>((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),




      // Not necessary for Option 1
      drawer: Container(child: NavigationDrawer(),),


      body: Container( child: Container(child: Offer())));


  }
}