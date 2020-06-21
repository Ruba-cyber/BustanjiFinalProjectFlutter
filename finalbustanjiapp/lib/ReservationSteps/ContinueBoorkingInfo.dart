import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:language/AppTranslation/AppTranslation.dart';
import 'package:language/CustomDesign/CurveShape.dart';
import 'package:language/CustomDesign/Icons.dart';
import 'package:language/CustomText/CustomTexts.dart';

import 'package:language/CustomerInfo/CustomerData.dart';

//import 'package:flutter_country_picker/flutter_country_picker.dart';
import 'package:http/http.dart' as http;
import 'package:email_validator/email_validator.dart';
import 'package:language/Reservation/ReservationData.dart';
import 'package:language/Urls/BustanjiUrl.dart';

import 'SecondStepChooseOptionAndInnsuranc.dart';
import 'TotalPriceAndFinalStepsForReservation.dart';


class ContinueBoorkingInfo extends StatefulWidget {
  @override
  _ContinueBoorkingInfoState createState() => _ContinueBoorkingInfoState();
}

class _ContinueBoorkingInfoState extends State<ContinueBoorkingInfo> {
  final formKey = GlobalKey<FormState>();
  //Country country2 = Country.JO;

  FocusNode _focusNodeDriver = new FocusNode();
  FocusNode _focusNodePass = new FocusNode();
  var txt = TextEditingController(),
      textusername = TextEditingController(),
      nationality = TextEditingController(),
      textemail = TextEditingController();
  String date = CustomerData.birhdate;

  final teDriverteDriverLicense = TextEditingController();
  final tePassport = TextEditingController();
  final tePassword = TextEditingController();
  String _PhoneNumber,
      countrycode,
      username,

      email,
      passport = '',
      locationTxt,
      orinetation,
      country;
  bool visiblitycode = true;

  Future<DateTime> DateTime2(BuildContext context) async {
    final DateTime dateTime = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1920),
        lastDate: DateTime(DateTime.now().year + 2));

    if (dateTime != null) {
      setState(() {
        date = dateTime.year.toString() +
            '-' +
            dateTime.month.toString() +
            '-' +
            dateTime.day.toString();
      });
    }
  }
  Future<bool> _onWillPop() async {
    return (
        await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SecondStepChooseOptionAndInnsyranc(),
            )));

  }

  void _submitCommand() {
    //Location();
    print(locationTxt);
    ReservationData.taxamount = locationTxt;
    final form = formKey.currentState;

    if (form.validate()) {
      print('V');
      form.save();
      CustomerData.lisence = teDriverteDriverLicense.text;
      CustomerData.passport = tePassport.text;


    if (country != null) {
      CustomerData.nationality = country;
    }
    //CustomerData.phonenumber =
        //country2.dialingCode.toString() + '-' + _PhoneNumber;
    if (username != null) {
      CustomerData.firstname = username;
    }
    if (email != null) {
      CustomerData.Email = email;
    }

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => TotalPriceAndFinalStepsForReservation()),
        result: (Route<dynamic> route()) => false);
  }}

  Future<String> Location() async {
    var url = await http.get(BustanjiUrls.searchlocation);
    var user = json.decode(url.body);
    for (var i in user) {
      print(i["location_name_english"]);
      if (i["location_name_english"] ==ReservationData.pickuploc||i["location_name_arabic"]) {
        locationTxt = i["tax_amount"];
        //print(locationTxt);
        //    ReservationData.taxamount=locationTxt;
//print(ReservationData.taxamount);

      }
    }
  }

  void numberphone() {
    print(ReservationData.pickuploc);
    Location();
    var splitnumphone = CustomerData.phonenumber.split("-");
    print(splitnumphone);
    var splitcountry = CustomerData.Country;
    _PhoneNumber = splitnumphone[1];
    countrycode = splitnumphone[0];
    String d = splitcountry[0].toUpperCase() + splitcountry[1].toUpperCase();
    print(d);
    //  country2 = Country.findByIsoCode(d);
  }

  @override
  Widget build(BuildContext context) {
    numberphone();
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      print("protaie");
      orinetation = "Protat";
    } else {
      orinetation = "Landscape";
      print("Landscape");
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(""),
          backgroundColor: Colors.indigo[900],
        ),
        resizeToAvoidBottomInset: false,
        body: (SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 80),
            child: Material(
              elevation: 5.0,
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              color: Colors.white,
              child: Container(
                  child: Column(children: <Widget>[
                Container(
                    child: Column(children: <Widget>[
                  Container(
                      child: Column(
                    children: <Widget>[
                      Container(child:CurveShape(Icons.perm_identity,   ApplicationLocalizations.of(context).translate("Continue_Booking"),),
                  ),
                ])),
                Container(
                  margin: EdgeInsets.only(top: 10, right: 5, left: 5),
                  width: MediaQuery.of(context).size.width,
                  child: Form(
                      key: formKey,
                      child: Column(children: [
                        Container(
                          margin: EdgeInsets.only(
                              left: 5, right: 5, top: 10, bottom: 10),
                          decoration: new BoxDecoration(
                            borderRadius:
                                new BorderRadius.all(new Radius.circular(10.0)),
                            color: Colors.grey[100],
                          ),
                          child: Row(children: <Widget>[
                            Container(
                              height: 50,

                              child: Container(
                                decoration: new BoxDecoration(
                                  borderRadius: new BorderRadius.all(
                                      new Radius.circular(1.0)),
                                  color: Colors.indigo[700],
                                ),
                                child: SetIcons(
                                  Icons.perm_identity,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Container(
                                child: InputText(CustomerData.firstname +
                                    ' ' +
                                    CustomerData.lastname)),
                          ]),
                        ),
                        Container(
                          margin: EdgeInsets.all(5),
                          decoration: new BoxDecoration(
                            borderRadius:
                                new BorderRadius.all(new Radius.circular(10.0)),
                            color: Colors.grey[100],
                          ),
                          child: Row(children: <Widget>[
                            Container(
                              height: 50,

                              child: Container(
                                decoration: new BoxDecoration(
                                  borderRadius: new BorderRadius.all(
                                      new Radius.circular(1.0)),
                                  color: Colors.indigo[700],
                                ),
                                child: SetIcons(
                                Icons.language,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Container(
                                child: CountryWidget(CustomerData.nationality)),
                          ]),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5, bottom: 5, right: 5),
                          decoration: new BoxDecoration(
                            borderRadius:
                                new BorderRadius.all(new Radius.circular(10.0)),
                            color: Colors.grey[100],
                          ),
                          width: MediaQuery.of(context).size.width,
                          child: Row(children: <Widget>[
                            Container(
                                margin: EdgeInsets.only(left: 5, right: 5),
                                decoration: new BoxDecoration(
                                  borderRadius: new BorderRadius.all(
                                      new Radius.circular(1.0)),
                                  color: Colors.indigo[700],
                                ),

                                  child: SetIcons(
                                    Icons.email,
                                    color: Colors.white,

                                )),
                            Container(

                              child: WidgetEmailInput(CustomerData.Email),
                            ),
                          ]),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: 5, right: 5, top: 5, bottom: 10),
                          decoration: new BoxDecoration(
                            borderRadius:
                                new BorderRadius.all(new Radius.circular(10.0)),
                            color: Colors.grey[100],
                          ),
                          child: Row(children: <Widget>[
                            Container(
                                decoration: new BoxDecoration(
                                  borderRadius: new BorderRadius.all(
                                      new Radius.circular(1.0)),
                                  color: Colors.indigo[700],
                                ),

                                  child: SetIcons(
                                    Icons.content_paste,
                                    color: Colors.white,
                                  ),
                                ),
                            Container(
                              child: InkWell(
                                child: new CustomText(
                                  inputBoxController:teDriverteDriverLicense ,
                                  focusNod: _focusNodeDriver,
                                  textSize: 12.0,
                                  textFont: "Nexa_Bold",
                                ).textFieldWithOutPrefix(
                                      ApplicationLocalizations.of(context).translate("DriverLicense"),
                                      ApplicationLocalizations.of(context).translate("Please_Enter_Driver_License"),context),
                              ),
                            ),      
                          ]),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: 5, right: 5, top: 5, bottom: 10),
                          decoration: new BoxDecoration(
                            borderRadius:
                                new BorderRadius.all(new Radius.circular(10.0)),
                            color: Colors.grey[100],
                          ),
                          child: Row(children: <Widget>[
                            Container(

                                  child: SetIcons(
                                    Icons.content_paste,
                                    color: Colors.white,

                                )),
                            Container(
                              child: InkWell(
                                child: new CustomText(
                                  inputBoxController:tePassport ,
                                  focusNod: _focusNodePass,
                                  textSize: 12.0,
                                  textFont: "Nexa_Bold",
                                ).textFieldWithOutPrefix(
                                      ApplicationLocalizations.of(context).translate("PassportLicense"),
                                      ApplicationLocalizations.of(context).translate("Please_Enter_Driver_License"),context),
                              ),
                            ),

                          ]),
                        ),
                        Container(
                            margin: EdgeInsets.only(
                                left: 5, right: 5, top: 10, bottom: 10),
                            decoration: new BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: new BorderRadius.all(
                                  new Radius.circular(10.0)),
                            ),
                            height: 50,
                            child: Row(children: <Widget>[
                              Container(
                                decoration: new BoxDecoration(
                                    color: Colors.indigo[700],
                                    borderRadius: new BorderRadius.all(
                                        new Radius.circular(1.0))),

                                child: SetIcons(
                                  Icons.phone,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                              Container(color: Colors.grey[200]
                                ,padding:
                                EdgeInsets.only(left: 5,
                                    right:5,top: 8,bottom: 8 ),
                                child: Visibility(
                                  visible: visiblitycode,
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        visiblitycode = false;
                                      });
                                    },
                                    child: Container(color: Colors.grey[200],
                                        width: 50,
                                        padding: EdgeInsets.all(5),
                                        child: Text("" + countrycode,
                                            style: (TextStyle(fontSize: 17)))),
                                  ),
                                ),
                              ),
                              Container(
                            //    child: PhoneCode(),
                              ),
                              Container(
                                child: Phone(),
                              ),
                            ])),
                        Container(
                          height: 50,
                          width: 300,
                          margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: RaisedButton(
                              onPressed: () {
                                _submitCommand();

                                // animationButton();
                              },

//                    if(email.text==''){ print ("Vaild Email");}else{print(email.text);}},
                              color: Colors.indigo[900],
                              child: Text(
                                  ApplicationLocalizations.of(context).translate("Continue"),
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              )),
                        )
                      ])),
                )
              ])),
            ]))))));
  }

//  Widget PhoneCode() {
//    if (visiblitycode == false) {
//      return Container(
//          color: Colors.grey[100],
//          padding: EdgeInsets.only(top: 10, bottom: 10),
//          child: CountryPicker(
//            dense: false,
//            showFlag: false,
//            showDialingCode: true,
//            //displays dialing code, false by default
//            showName: false,
//            //displays country name, true by default
//            showCurrency: false,
//            //eg. 'British pound'
//            showCurrencyISO: false,
//            //eg. 'GBP'
//            onChanged: (Country country) {
//              setState(() {
//                country2 = country;
//              });
//            },
//            selectedCountry: country2,
//          ));
//    }
//  }

  Widget Phone() {
    txt.text = _PhoneNumber;

    if (orinetation == "Landscape") {
      return Container(
        width: MediaQuery.of(context).size.width / 1.56,
        child: Container(
          padding: EdgeInsets.only(left:2,bottom: 10, top: 10, right: 2),
          child: FittedBox(
            
            child: Container(width: MediaQuery.of(context).size.width/2,
              child: TextFormField(
                controller: txt,
                validator: (val) => val.length < 9 ? 'Invaild Phone Number ' : null,
                onSaved: (val) => _PhoneNumber = val,
                obscureText: false,
                keyboardType: TextInputType.phone,
                style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                decoration: const InputDecoration(
                    border: InputBorder.none, hintText: "Phone", filled: false),
              ),
            ),
          ),
        ),
      );
    } else {
      return Container(
        width: MediaQuery.of(context).size.width / 1.75,
        child: Container(
          padding: EdgeInsets.only(bottom: 10, top: 10, right: 2,left: 2),
          child: Container(width: 300,
            child: TextFormField(
              controller: txt,
              validator: (val) => val.length < 9 ? 'Invaild Phone Number ' : null,
              onSaved: (val) => _PhoneNumber = val,
              obscureText: false,
              keyboardType: TextInputType.phone,
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
              decoration:
                  const InputDecoration(border: InputBorder.none, filled: false),
            ),
          ),
        ),
      );
    }
  }

  Widget InputText(String editvalue) {
    if (username == null) {
      textusername.text = editvalue;
    } else {
      textusername.text = username;
    }

    return Container(
      margin: EdgeInsets.only(left: 3,right: 3),
      width: MediaQuery.of(context).size.width / 1.6,
      child: Container(
        margin: EdgeInsets.only(top: 2, bottom: 2),
        child: TextFormField(
          controller: textusername,
          validator: (val) => val.length < 1 ? 'Invaild ' : null,
          onFieldSubmitted: (val) => username = val,
          obscureText: false,
          style: TextStyle(fontSize: 18, color: Colors.grey[700]),
          decoration:
              const InputDecoration(border: InputBorder.none, filled: false),
        ),
      ),
    );
  }

  WidgetEmailInput(String editvalue) {
    if (email == null) {
      textemail.text = editvalue;
    } else {
      print(email);
      textemail.text = email;
    }
    return Container(
      width: MediaQuery.of(context).size.width / 1.5,
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        controller: textemail,
        validator: (val) =>
            !EmailValidator.validate(val, true) ? 'Not a valid email.' : null,
        obscureText: false,
        onFieldSubmitted: (val) => email = val,
        style: TextStyle(fontSize: 18, color: Colors.grey[700]),
        decoration:
            const InputDecoration(border: InputBorder.none, filled: false),
      ),
    );
  }

  Widget CountryWidget(String edittxt) {
    if (country == null) {
      nationality.text = edittxt;
    } else {
      nationality.text = country;
    }
    return Container(
        width: MediaQuery.of(context).size.width / 1.4,
        child: Container(
            margin: EdgeInsets.only(left: 2, right: 2),
            padding: EdgeInsets.only(top: 2, bottom: 2,left: 2,right: 2),
            child: TextFormField(
              controller: nationality,
              validator: (val) => val.length < 1 ? 'Invaild ' : null,
              onFieldSubmitted: (val) => country = val,
              obscureText: false,
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
              decoration: const InputDecoration(
                  border: InputBorder.none, filled: false),
            )));
  }
}
