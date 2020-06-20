import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ApplicationLocalizations {
  final Locale appLocale;

  ApplicationLocalizations(this.appLocale);

  static ApplicationLocalizations of(BuildContext context) {
    return Localizations.of<ApplicationLocalizations>(context, ApplicationLocalizations);
  }

  Map<String, String> _localizedStrings;

  Future<bool> load() async {
    // Load JSON file from the "language" folder
    String jsonString =
    await rootBundle.loadString(  "assets/locale/localization_${appLocale.languageCode}.json");
    Map<String, dynamic> jsonLanguageMap = json.decode(jsonString);
    _localizedStrings = jsonLanguageMap.map((key, value) {
      return MapEntry(key, value.toString());
    });
    return true;
  }

  // called from every widget which needs a localized text
  String translate(String jsonkey) {
    return _localizedStrings[jsonkey];
  }


  static const LocalizationsDelegate<ApplicationLocalizations>delegate= AppTranslationsDelegate();}
class AppTranslationsDelegate extends LocalizationsDelegate<ApplicationLocalizations> {


  const   AppTranslationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en','ar'].contains(locale.languageCode);
  }
  @override
  Future<ApplicationLocalizations> load(Locale locale) async{
    ApplicationLocalizations appTranslations= new ApplicationLocalizations(locale);
    await appTranslations.load();
    return appTranslations;
  }

  @override
  bool shouldReload(LocalizationsDelegate<ApplicationLocalizations> old) {
    return false;
  }
}


