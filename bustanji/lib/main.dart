
import 'package:device_preview/device_preview.dart';
import 'package:devicepreview/ContactUs/ContactUS.dart';
import 'package:devicepreview/SplashScreen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'AppTranslation/AppTranslation.dart';

import 'CustomerData.dart';

import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';




import 'AppTranslation/Application.dart';


import 'dart:ui'as ui;

import 'Emergency/Emergency.dart';
import 'Route/CustomRoute.dart';
import 'WidthAndHeighTWidget/Size_layout.dart';

Future<Null> main() async {//runApp(LocalisedApp());
 runApp(
   DevicePreview( areSettingsEnabled: false,
     usePreferences: true,
     enabled: !kReleaseMode,
    builder: (context) => LocalisedApp(),
  ));



}

class LocalisedApp extends StatefulWidget {
  @override
  LocalisedAppState createState() {
    return new LocalisedAppState();
  }

  static void setLocale(BuildContext context, Locale chooselanguage) {
    LocalisedAppState localisedAppState = context.findAncestorStateOfType();
    localisedAppState.setLocal(chooselanguage);
  }
}
class LocalisedAppState extends State<LocalisedApp> {
  ApplicationLocalizations _newLocaleDelegate;
  Locale locale;
  @override
  void initState() {
    super.initState();
    checksavelanguage();


  }

  void checksavelanguage()async{
    print("CheckLanguage");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String Languagecode=prefs.getString("Language");
  if(Languagecode==null){
    print  ("null");
  }
    Locale langauge;
    switch(Languagecode){
      case("en"):locale=Locale("en","US");
      CustomerData.Language="English";
      break;
      case("ar"):locale=Locale("ar","SA");
      CustomerData.Language="Arabic";break;
      default: String l=ui.window.locale.languageCode;
      print("De"+l);
      if(l=="ar"){CustomerData.Language="Arabic";locale=Locale("ar","SA");}
      else{CustomerData.Language="English";
      locale=Locale("en","US");}
      break;


      break;





    }  print("Language"+CustomerData.Language);
    LocalisedApp.setLocale(context,langauge);
  }
  void setLocal(Locale l){
    print("Locale "+l.countryCode);
    setState(() {
      locale=l;
    });
  }
  @override
  Widget build(BuildContext context) {

    Size1 s=new Size1(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
    home: SplashScreen(),
      locale: locale,
      localizationsDelegates: [
        ApplicationLocalizations.delegate,
        //provides localised strings
      GlobalMaterialLocalizations.delegate,
        //provides RTL support
        GlobalWidgetsLocalizations.delegate,
      ],
      onGenerateRoute: CustomRouter.all,
      initialRoute: '/',

      supportedLocales: [
        const Locale("en", ""),
        const Locale("ar", ""),
      ],

//        localeResolutionCallback: (devicelocale,supportlocales){
//          for( var locale in supportlocales ){if(locale.languageCode==devicelocale.languageCode
//             ){
//            return devicelocale;
//          }}
//          return supportlocales.first;


    );
  }


}
