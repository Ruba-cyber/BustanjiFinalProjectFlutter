import 'package:devicepreview/NavGuest/NavigationDrawer.dart';
import 'package:flutter/material.dart';



import 'package:http/http.dart' as http;
import 'package:devicepreview/AppTranslation/AppTranslation.dart';
import 'package:devicepreview/Steps_Of_Reservation/ChooseCar.dart';

import 'package:devicepreview/WidthAndHeighTWidget/Size_layout.dart';
import '../CustomerData.dart';

import '../SplashScreen.dart';
import '../Urls.dart';

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


import '../ReservationData.dart';

import '../main.dart';
import 'package:devicepreview/Offers/OffersData.dart';
import 'package:devicepreview/AppTranslation/AppTranslation.dart';
import 'package:devicepreview/AppTranslation/Application.dart';
import 'package:devicepreview/Offers/Offer.dart';
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
              builder: (context) => new HomePage(),
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

    print(OffersData.coin);
    var url = await http.get(Urls.getcoin);
    _myJson.clear();
    var coin = json.decode(url.body);
    for (var u in coin) {
      // print(coin[u]['shortcut']);
      _myJson.add(u['shortcut']);
      print(u['shortcut']);



      setState(() {
        OffersData.coin=''+OffersData.coin;

      });}
    ReservationData.Coins.clear();
    for(int i=0;i<_myJson.length;i++){
      ReservationData.Coins.add(_myJson[i]);
    }}


  void onLocaleChange(Locale locale) async {
    Locale chooselanguage; print("Langau"+locale.languageCode);
    switch(locale.languageCode){
      case("en"):chooselanguage=Locale('en','US');
      LocalisedApp.setLocale(context,chooselanguage);

      CustomerData.Language="English";
      break;
      case("ar"):chooselanguage=Locale('ar','SA');
      CustomerData.Language="Arabic";
      LocalisedApp.setLocale(context,chooselanguage);break;

    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("Language",chooselanguage.languageCode);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LocalisedApp(),
        ));

  }


  void _select(String language) {
    AlertDialogWarning(context,language);


  }


  AlertDialogWarning(BuildContext context, String l) {
    return showDialog(
        context: context,
        builder: (context) {
          return FittedBox(
            child: Column(children: [
              AlertDialog(
                  title: Text(ApplicationLocalizations.of(context)
                      .translate("Restart_App"),style: (TextStyle(fontSize: Size1.Font_size)),),
                  content: Text(ApplicationLocalizations.of(context)
                      .translate("Restart_Warning_Message"),style: TextStyle(fontSize: Size1.Font_size),),
                  actions: <Widget>[
                    Row(children: <Widget>[
                      MaterialButton(
                          elevation: 5.0,
                          onPressed: () {
                            onLocaleChange(Locale(languagesMap[l]));
                            Navigator.of(context).pop();

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>SplashScreen (),
                                ));
                          },
                          child: Text(ApplicationLocalizations.of(context)
                              .translate("ok"))),
                      MaterialButton(
                          elevation: 5.0,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            (ApplicationLocalizations.of(context)
                                .translate("Cancel")),
                          ))
                    ])
                  ]),
            ]),
          );
        });


  }




  @override
  Widget build(BuildContext context) {Data();
  return WillPopScope(onWillPop: _onWillPop,
    child: Scaffold(
        resizeToAvoidBottomInset: false,

      appBar: AppBar(  backgroundColor: Colors.indigo[900],
          title: SafeArea(
            child: Container(
              margin:EdgeInsets.all(10),
              child: Container(width: MediaQuery.of(context).size.width/2,
                height: Size1.height_of_container/4,


                //padding:EdgeInsets.only(left: 30,right: 30,top: 2,bottom: 2),

                child: FittedBox(
                  child: Row(children: <Widget>[



                    Container(

                      decoration: BoxDecoration(
                        border: Border.all(),
                        color: Colors.white,
                      ),
                      child: new DropdownButton<String>(
                        isDense: false,

                        hint: FittedBox(fit: BoxFit.fitWidth,
                          child: Container(padding: EdgeInsets.only(left: 5,right: 5,),
                            width:Size1.title,
                            child: new
                            Text(
                              OffersData.coin  ,textAlign:TextAlign.center,
                              style: TextStyle(color: Colors.black,fontSize: Size1.Font_size),),
                          ),
                        ),

                        onChanged: (String newValue) {

                          setState(() {
                            OffersData.coin= newValue;



                          });


                        },
                        items: ReservationData.Coins.map((  item) {
                          return new DropdownMenuItem<String>(
                            value: item.toString(),
                            child: new Text(item.toString(),
                            ),
                          );
                        }).toList(),
                      ),
                    ),

                  ]),
                ),
              ),

            ),
          ),


      actions: <Widget>[
            PopupMenuButton<String>(
              // overflow menu
              onSelected: _select,
              icon:new Icon(Icons.language, color: Colors.white),
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
        drawer: Container(child: NavigationDrawer(),),



        // Not necessary for Option 1
      //  drawer: Container(child: NavigationDrawer(),),


        body: Container( child: Container(child: Offer()))),
  );


  }
}