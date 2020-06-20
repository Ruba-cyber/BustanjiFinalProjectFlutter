import 'package:flutter/material.dart';

import 'AppTranslation/AppTranslation.dart';


import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';


import 'AppTranslation/Application.dart';




import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'Login/Login.dart';
import 'SplashScreen/SpalshScreen.dart';

Future<Null> main() async {
  runApp(new LocalisedApp());
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

  }

  void setLocal(Locale l){
    setState(() {
      locale=l;
    });
  }
  @override
  Widget build(BuildContext context) {
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


//        onGenerateRoute: CustomRouter.all,
//        initialRoute: '/',initialRoute

        supportedLocales: [
          const Locale("en", "US"),
          const Locale("ar", "SA"),
        ],
        localeResolutionCallback: (devicelocale,supportlocales){
          for( var locale in supportlocales ){if(locale.languageCode==devicelocale.languageCode && locale.countryCode==devicelocale.countryCode){
            return devicelocale;
          }}
          return supportlocales.first;
        }
    );
  }

  void onLocaleChange(Locale locale) {
    setState(() {
      //   _newLocaleDelegate = AppTranslationsDelegate();
    });
  }
}