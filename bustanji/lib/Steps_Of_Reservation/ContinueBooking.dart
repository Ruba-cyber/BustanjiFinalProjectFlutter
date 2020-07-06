import 'dart:convert';

import 'package:devicepreview/AppTranslation/AppTranslation.dart';
import 'package:devicepreview/CustomDesign/CurveShape.dart';
import 'package:devicepreview/CustomDesign/Icons.dart';
import 'package:devicepreview/CustomTexts/CustomText.dart';
import 'package:devicepreview/Customer_Search/Dateandemail.dart';

import 'package:devicepreview/WidthAndHeighTWidget/Size_layout.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_country_picker/country.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';

import '../CustomerData.dart';
import '../DateSelected.dart';
import '../ReservationData.dart';
import '../Urls.dart';
import 'package:http/http.dart' as http;

import 'SecondStepChooseOptionAndInnsuranc.dart';
import 'TotalPrice.dart';


class ContinueBooking extends
StatefulWidget {
  @override
  _ContinueBookingState createState() => _ContinueBookingState();
}

class _ContinueBookingState extends State<ContinueBooking> {
Country country2=Country.JO;
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

Future<bool> _onWillPop() async {
  return (
      await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SecondStepChooseOptionAndInnsyranc(),
          )));

}

Future<String> Location() async {
  var url = await http.get(Urls.searchlocation);
  var user = json.decode(url.body);
  for (var i in user) {
    print(i["location_name_english"]);
    if (i["location_name_english"] == ReservationData.pickuploc||i["location_name_arabic"]==ReservationData.pickuploc) {
      locationTxt = i["tax_amount"];
      print(locationTxt);
      ReservationData.taxamount=locationTxt;
//print(ReservationData.taxamount);

    }
  }
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
            builder: (context) =>TotalPrice()),

        result: (Route<dynamic> route()) => false);
  }}

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
    
}

  Widget build(BuildContext context) {
numberphone();
    return WillPopScope(onWillPop: _onWillPop,
      child: Scaffold(
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
      Container(child:CurveShape(Icons.perm_identity,ApplicationLocalizations.of(context).translate("Continue_Booking"),),
      ),
      ])),
      SafeArea(
        child: Container(
        margin: EdgeInsets.only(top: 10, right: 5, left: 5),
        width: double.infinity,
        child: Form(
        key: formKey,
        child: Column(children: [
        Container(
        margin: EdgeInsets.only(
         top: Size1.margin_top, bottom: Size1.margin_bottom),
        decoration: new BoxDecoration(
        borderRadius:
        new BorderRadius.all(new Radius.circular(10.0)),
        color: Colors.grey[100],
        ),
          width: MediaQuery.of(context).size.width,
          height: Size1.height_of_container,
        child: FittedBox(fit: BoxFit.fitWidth,
          child: Row(children: <Widget>[
          Container(


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
            padding: EdgeInsets.only(left: 2,right: 2),
          child: InputText(CustomerData.firstname +' '+
          CustomerData.lastname)),
          ]),
        ),
        ),
            Container(  height: Size1.height_of_container,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.all(2),
              decoration: new BoxDecoration(
                borderRadius:
                new BorderRadius.all(new Radius.circular(10.0)),
                color: Colors.grey[100],
              ),
              child: FittedBox(fit: BoxFit.fitWidth,
                child: Row(children: <Widget>[
                  Container(



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
         Container(padding: EdgeInsets.only(left: 2,right: 2),
                    child: Nationality(CustomerData.nationality)),
                ]),
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: Size1.margin_top, bottom: Size1.margin_bottom),
                decoration: new BoxDecoration(
                  borderRadius:
                  new BorderRadius.all(new Radius.circular(10.0)),
                  color: Colors.grey[100],
                ),
                width: MediaQuery.of(context).size.width,
                    height: Size1.height_of_container,
                    child: FittedBox(fit: BoxFit.fitWidth,
                  child: Row(children: <Widget>[
                    Container(

                        decoration: new BoxDecoration(
                          borderRadius: new BorderRadius.all(
                              new Radius.circular(1.0)),
                          color: Colors.indigo[700],
                        ),

                        child: SetIcons(
                          Icons.email,
                          color: Colors.white,

                        )),
                  Container(padding: EdgeInsets.only(left: 2,right: 2),
                    child: WidgetEmailInput(CustomerData.Email),)]
                  ),
                )),

          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(
              top: Size1.margin_top,bottom:Size1.margin_bottom),
            decoration: new BoxDecoration(
              borderRadius:
              new BorderRadius.all(new Radius.circular(10.0)),
              color: Colors.grey[100],
            ),
            child: FittedBox(fit: BoxFit.fitWidth,
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
          ),

          Container(width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(
             top: Size1.margin_top, bottom: Size1.margin_bottom),
            decoration: new BoxDecoration(
              borderRadius:
              new BorderRadius.all(new Radius.circular(10.0)),
              color: Colors.grey[100],
            ),
            child: FittedBox(fit: BoxFit.fitWidth,
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
          ),

          Container(
            width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(
                  left: 5, right: 5, top: 10, bottom: 10),
              decoration: new BoxDecoration(
                color: Colors.grey[100],
                borderRadius: new BorderRadius.all(
                    new Radius.circular(10.0)),
              ),
              height: Size1.height_of_container,
              child: FittedBox(fit: BoxFit.fitWidth,
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
                       child: PhoneCode(),
                  ),
                  Container(
                    child: Phone(),
                  ),
                ]),
              )),
          Container(
            height: Size1.height_of_container,
            width: Size1.width_text,
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
                      fontSize: Size1.Font_size, color: Colors.white),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.all(Radius.circular(10.0)),
                )),
          )]))),
      )]))])))))),
    );
  }

  Widget InputText(String editvalue) {
    if (username == null) {
      textusername.text = editvalue;
    } else {
      textusername.text = username;
    }

    return Container(
      margin: EdgeInsets.only(left: 3,right: 3),
      width: Size1.width_text,
      child: Container(

        child: TextFormField(
          controller: textusername,
          validator: (val) => val.length < 1 ? 'Invaild ' : null,
          onFieldSubmitted: (val) => username = val,
          obscureText: false,
          style: TextStyle(fontSize: Size1.Font_size, color: Colors.grey[700]),
          decoration:
          const InputDecoration(border: InputBorder.none, filled: false),
        ),
      ),
    );
  }

  Widget Nationality(String edittxt) {
    if (country == null) {
      nationality.text = edittxt;
    } else {
      nationality.text = country;
    }
    return Container(
        width: Size1.width_text,
        child: Container(

          
            child: TextFormField(
              controller: nationality,
              validator: (val) => val.length < 1 ? 'Invaild ' : null,
              onFieldSubmitted: (val) => country = val,
              obscureText: false,
              style: TextStyle(fontSize: Size1.Font_size, color: Colors.grey[700]),
              decoration: const InputDecoration(
                  border: InputBorder.none, filled: false),
            )));
  }

  WidgetEmailInput(String editvalue) {
    if (email == null) {
      textemail.text = editvalue;
    } else {
      print(email);
      textemail.text = email;
    }
    return Container(
      width: Size1.width_text,
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        controller: textemail,
        validator: (val) =>
        !EmailValidator.validate(val, true) ? ApplicationLocalizations.of(context).translate("Invalid_Email") : null,
        obscureText: false,
        onFieldSubmitted: (val) => email = val,
        style: TextStyle(fontSize: Size1.Font_size, color: Colors.grey[700]),
        decoration:
        const InputDecoration(border: InputBorder.none, filled: false),
      ),
    );
  }
  Widget PhoneCode() {
    if (visiblitycode == false) {
      return Container(
          color: Colors.grey[100],
         // padding: EdgeInsets.only(top: 10, bottom: 10),
          child: CountryPicker(
            dense: false,
            showFlag: false,
            showDialingCode: true,
            //displays dialing code, false by default
            showName: false,
            //displays country name, true by default
            showCurrency: false,
            //eg. 'British pound'
            showCurrencyISO: false,
            //eg. 'GBP'
            onChanged: (Country country) {
              setState(() {
                country2 = country;
              });
            },
            selectedCountry: country2,
          ));
    }
  }

Widget Phone() {
  txt.text = _PhoneNumber;


    return Container(
      width: Size1.width_text,
      child: Container(
        padding: EdgeInsets.only(left:2, right: 2),
        child: FittedBox(

          child: Container(width: Size1.width_text,
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
  }



}


