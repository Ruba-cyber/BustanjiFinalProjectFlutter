import 'dart:convert';

import 'package:devicepreview/AppTranslation/AppTranslation.dart';
import 'package:devicepreview/CustomDesign/CurveShape.dart';
import 'package:devicepreview/CustomDesign/Icons.dart';
import 'package:devicepreview/CustomTexts/CustomText.dart';
import 'package:devicepreview/Customer_Search/Dateandemail.dart';
import 'package:devicepreview/HomePage/HomePage.dart';

import 'package:devicepreview/WidthAndHeighTWidget/Size_layout.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_country_picker/country.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../CustomerData.dart';
import '../DateSelected.dart';
import '../ReservationData.dart';
import '../Urls.dart';
import 'package:http/http.dart' as http;

class MyProfile extends StatefulWidget {
  @override
  _MyProfile createState() => _MyProfile();
}

class _MyProfile extends State<MyProfile> {
  Country country2 = Country.JO, country = Country.JO;
  String city, _PhoneNumber, countrycode;
  FocusNode _focusNodePass = new FocusNode();
  var txt = TextEditingController(),
      textcity = TextEditingController(),
      Address = TextEditingController(),
      textusername = TextEditingController(),
      nationality = TextEditingController(),
      textemail = TextEditingController(),
      Phone_Text = TextEditingController();
  String date = CustomerData.birhdate;
  final teDriverteDriverLicense = TextEditingController();
  final tePassport = TextEditingController();
  final tePassword = TextEditingController();

  String username, lastname, email, address = '', Customer_Country;

  bool visiblitycode = true, visible_country = true;
  void _submitCommand() {
    if (username != null) {
      CustomerData.firstname = username;
    }
    if (country2 != null) {
      CustomerData.phonenumber =
          country2.dialingCode.toString() + '-' + _PhoneNumber;
    }
    if (lastname != null) {
      CustomerData.firstname = username;
    }

    if (country != null) {
      CustomerData.Country = country.name.toString();
    }
    if (city != null) {
      CustomerData.city = city;
    }

    if (address != null) {
      CustomerData.Address = address;
    }
    print(CustomerData.city);
    print(CustomerData.Country);
    print(CustomerData.Address);
    print(CustomerData.lastname);

    customerinfoupdate();
  }

  Future<String> customerinfoupdate() async {

    var url = Urls.updatepersonal;
    http.Response response = await http.post(url, body: {
      'firstname1': CustomerData.firstname,
      'lastname1': CustomerData.lastname,
      'email1': CustomerData.Email,
      'address1': CustomerData.Address,
      'city1': CustomerData.city,
      'country1': CustomerData.Country,
      'phone1': CustomerData.phonenumber,
      'customerId1': CustomerData.customerid,
    });
    var user = json.decode(response.body);

    if (user['message'] == 'success') {
      Fluttertoast.showToast(
          msg:ApplicationLocalizations.of(context).translate("") ,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    }



  Future<bool> _onWillPop() async {
    return (await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        )));
  }

  void numberphone() {
    print(ReservationData.pickuploc);

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
    return WillPopScope(
        onWillPop: _onWillPop,
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
                            child: Column(children: <Widget>[
                          Container(
                            child: CurveShape(
                              Icons.perm_identity,
                              ApplicationLocalizations.of(context)
                                  .translate("Continue_Booking"),
                            ),
                          ),
                        ])),
                        SafeArea(
                            child: Container(
                                margin:
                                    EdgeInsets.only(top: 10, right: 5, left: 5),
                                width: MediaQuery.of(context).size.width,
                                child: Form(
                                    key: formKey,
                                    child: Column(children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: Size1.margin_top,
                                            bottom: Size1.margin_bottom),
                                        decoration: new BoxDecoration(
                                          borderRadius: new BorderRadius.all(
                                              new Radius.circular(10.0)),
                                          color: Colors.grey[100],
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: Size1.height_of_container,
                                        child: FittedBox(
                                          fit: BoxFit.fitWidth,
                                          child: Row(children: <Widget>[
                                            Container(
                                              child: Container(
                                                decoration: new BoxDecoration(
                                                  borderRadius: new BorderRadius
                                                          .all(
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
                                                padding: EdgeInsets.only(
                                                    left: 2, right: 2),
                                                child: ChangeFirstName(
                                                    CustomerData.firstname)),
                                          ]),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: Size1.margin_top,
                                            bottom: Size1.margin_bottom),
                                        decoration: new BoxDecoration(
                                          borderRadius: new BorderRadius.all(
                                              new Radius.circular(10.0)),
                                          color: Colors.grey[100],
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: Size1.height_of_container,
                                        child: FittedBox(
                                          fit: BoxFit.fitWidth,
                                          child: Row(children: <Widget>[
                                            Container(
                                              child: Container(
                                                decoration: new BoxDecoration(
                                                  borderRadius: new BorderRadius
                                                          .all(
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
                                                padding: EdgeInsets.only(
                                                    left: 2, right: 2),
                                                child: ChangeLastName(
                                                    CustomerData.lastname)),
                                          ]),
                                        ),
                                      ),
                                      Container(
                                          margin: EdgeInsets.only(
                                              top: Size1.margin_top,
                                              bottom: Size1.margin_bottom),
                                          decoration: new BoxDecoration(
                                            borderRadius: new BorderRadius.all(
                                                new Radius.circular(10.0)),
                                            color: Colors.grey[100],
                                          ),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: Size1.height_of_container,
                                          child: FittedBox(
                                            fit: BoxFit.fitWidth,
                                            child: Row(children: <Widget>[
                                              Container(
                                                  decoration: new BoxDecoration(
                                                    borderRadius:
                                                        new BorderRadius.all(
                                                            new Radius.circular(
                                                                1.0)),
                                                    color: Colors.indigo[700],
                                                  ),
                                                  child: SetIcons(
                                                    Icons.email,
                                                    color: Colors.white,
                                                  )),
                                              Container(
                                                padding: EdgeInsets.only(
                                                    left: 2, right: 2),
                                                child: Text(
                                                  CustomerData.Email,
                                                  style: TextStyle(
                                                      fontSize: Size1.Font_size,
                                                      color: Colors.grey[600]),
                                                ),
                                              )
                                            ]),
                                          )),
                                      Container(
                                        height: Size1.height_of_container,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        margin: EdgeInsets.all(2),
                                        decoration: new BoxDecoration(
                                          borderRadius: new BorderRadius.all(
                                              new Radius.circular(10.0)),
                                          color: Colors.grey[100],
                                        ),
                                        child: FittedBox(
                                          fit: BoxFit.fitWidth,
                                          child: Row(children: <Widget>[
                                            Container(
                                              child: Container(
                                                decoration: new BoxDecoration(
                                                  borderRadius: new BorderRadius
                                                          .all(
                                                      new Radius.circular(1.0)),
                                                  color: Colors.indigo[700],
                                                ),
                                                child: SetIcons(
                                                  Icons.location_city,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            Container(
                                                padding: EdgeInsets.only(
                                                    left: 2, right: 2),
                                                child: ChangeAddress(
                                                    CustomerData.Address)),
                                          ]),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        margin: EdgeInsets.only(
                                            top: Size1.margin_top,
                                            bottom: Size1.margin_bottom),
                                        decoration: new BoxDecoration(
                                          borderRadius: new BorderRadius.all(
                                              new Radius.circular(10.0)),
                                          color: Colors.grey[100],
                                        ),
                                        child: FittedBox(
                                            fit: BoxFit.fitWidth,
                                            child: Row(children: <Widget>[
                                              Container(
                                                decoration: new BoxDecoration(
                                                  borderRadius: new BorderRadius
                                                          .all(
                                                      new Radius.circular(1.0)),
                                                  color: Colors.indigo[700],
                                                ),
                                                child: SetIcons(
                                                  Icons.language,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Container(
                                                child: ChangeCity(),
                                              ),

//
//

//
//                                                          Container(
//                                                            height:
//                                                            Size1
//                                                                .height_of_container,
//                                                            width: Size1
//                                                                .width_text,
//                                                            margin: EdgeInsets
//                                                                .fromLTRB(
//                                                                10, 10, 10, 10),
//                                                            child: RaisedButton(
//                                                                onPressed: () {
//                                                                  _submitCommand();
//
//                                                                  // animationButton();
//                                                                },
//
////                    if(email.text==''){ print ("Vaild Email");}else{print(email.text);}},
//                                                                color: Colors
//                                                                    .indigo[900],
//                                                                child: Text(
//                                                                  ApplicationLocalizations
//                                                                      .of(
//                                                                      context)
//                                                                      .translate(
//                                                                      "Continue"),
//                                                                  style: TextStyle(
//                                                                      fontSize:
//                                                                      Size1
//                                                                          .Font_size,
//                                                                      color: Colors
//                                                                          .white),
//                                                                ),
//                                                                shape:
//                                                                RoundedRectangleBorder(
//                                                                  borderRadius:
//                                                                  BorderRadius
//                                                                      .all(
//                                                                      Radius
//                                                                          .circular(
//                                                                          10.0)),
//                                                                )),
//                                                          )
//                                                        ]))),
//                                          ]))))
//                            ]))
//                      ])))))),);
                                            ])),
                                      ),
                                      Container(
                                        width:double.infinity,
                                        margin: EdgeInsets.only(
                                            top: Size1.margin_top,
                                            bottom: Size1.margin_bottom),
                                        decoration: new BoxDecoration(
                                          borderRadius: new BorderRadius.all(
                                              new Radius.circular(10.0)),
                                          color: Colors.grey[100],
                                        ),
                                        child: FittedBox(
                                          fit: BoxFit.fitWidth,
                                          child: Row(children: <Widget>[
                                            Container(
                                              child: SetIcons(
                                                Icons.language,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Visibility(
                                              visible: visible_country,
                                              child: Container(
                                                width: Size1.width_text,
                                                padding: EdgeInsets.only(
                                                    left: 5, right: 5),
                                                child: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      visible_country = false;
                                                    });
                                                  },
                                                  child: Text(
                                                      CustomerData.Country),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: ChangeCountry(
                                                  CustomerData.Country),
                                            ),
                                          ]),
                                        ),
                                      ),
                                      Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          margin: EdgeInsets.only(
                                              top: Size1.margin_top,
                                              bottom: Size1.margin_bottom),
                                          decoration: new BoxDecoration(
                                            borderRadius: new BorderRadius.all(
                                                new Radius.circular(10.0)),
                                            color: Colors.grey[100],
                                          ),
                                          child: FittedBox(
                                              fit: BoxFit.fitWidth,
                                              child: Row(children: <Widget>[
                                                Container(
                                                  child: SetIcons(
                                                    Icons.language,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Container(
                                                  child: ChangeCity(),
                                                ),
                                              ]))),
                                      Container(
                                          width:
                                              double.infinity,
                                          margin: EdgeInsets.only(
                                              top: Size1.margin_top,
                                              bottom: Size1.margin_bottom),
                                          decoration: new BoxDecoration(
                                            borderRadius: new BorderRadius.all(
                                                new Radius.circular(10.0)),
                                            color: Colors.grey[100],
                                          ),
                                          child: FittedBox(
                                              fit: BoxFit.fitWidth,
                                              child: Row(children: <Widget>[
                                                Container(
                                                  child: SetIcons(
                                                    Icons.phone,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Visibility(
                                                    visible: visiblitycode,
                                                    child: Container(width: 60,height:40,
                                                      padding: EdgeInsets.only(top: 10,bottom: 10,left: 5,right: 5),
                                                      color: Colors.grey[300],
                                                      child: InkWell(onTap: (){setState(() {
                                                        visiblitycode=false;
                                                      });},
                                                          child: Padding(padding: EdgeInsets.only(left: 2,right: 2),
                                                            child: Text(
                                                        "" + countrycode,
                                                        style: TextStyle(
                                                              fontSize: Size1
                                                                  .Font_size),
                                                      ),
                                                          )),
                                                    )),
                                         Container(child: PhoneCode(),) ,
                                              Container(child: Phone(),)]))),
                                      Container(
                                        height: Size1.height_of_container,
                                        margin: EdgeInsets.only(bottom: Size1.margin_top, top: Size1.margin_bottom),
                                        width:Size1.width_text,
                                        child: RaisedButton(
                                            onPressed: () {
                                              _submitCommand();
                                              // isshowing = true;
                                              // animationButton();
                                            },

//                    if(emaiRl.text==''){ print ("Vaild Email");}else{print(email.text);}},
                                            color: Colors.indigo[900],
                                            child: Text(
                                              ApplicationLocalizations.of(context).translate
                                                ("Continue"),
                                              style: TextStyle(
                                                  fontSize: Size1.Font_size, color: Colors.white),
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.all(Radius.circular(10.0)),
                                            )),
                                      ), ]))))
                      ]))
                    ])))))));
  }

  Widget ChangeCity() {
    if (city == null) {
      textcity.text = CustomerData.city;
    } else {
      textcity.text = city;
    }

    return Container(
      margin: EdgeInsets.only(left: 5, right: 5),
      width: Size1.width_text,
      child: Container(
        child: TextFormField(
          controller: textcity,
          validator: (val) => val.length < 1 ? 'Invaild ' : null,
          onFieldSubmitted: (val) => city = val,
          obscureText: false,
          style: TextStyle(fontSize: Size1.Font_size, color: Colors.grey[700]),
          decoration:
              const InputDecoration(border: InputBorder.none, filled: false),
        ),
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

  Widget ChangeFirstName(String editvalue) {
    if (username == null) {
      textusername.text = editvalue;
    } else {
      textusername.text = username;
    }

    return Container(
      margin: EdgeInsets.only(left: 3, right: 3),
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

  Widget ChangeLastName(String editvalue) {
    if (username == null) {
      teLastName.text = editvalue;
    } else {
      teLastName.text = username;
    }

    return Container(
      margin: EdgeInsets.only(left: 3, right: 3),
      width: Size1.width_text,
      child: Container(
        child: TextFormField(
          controller: teLastName,
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

  Widget ChangeAddress(String edittxt) {
    if (address == null) {
      Address.text = edittxt;
    } else {
      Address.text = edittxt;
    }
    return Container(
        width: Size1.width_text,
        child: Container(
            padding: EdgeInsets.only(left: 2, right: 2),
            child: TextFormField(
              controller: Address,
              validator: (val) => val.length < 1 ? 'Invaild ' : null,
              onFieldSubmitted: (val) => address = val,
              obscureText: false,
              style:
                  TextStyle(fontSize: Size1.Font_size, color: Colors.grey[700]),
              decoration: const InputDecoration(
                  border: InputBorder.none, filled: false),
            )));
  }

  Widget ChangeCountry(String index) {
    if (visible_country == false) {
      return Container(
          width: Size1.width_text,
          padding: EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
          child: CountryPicker(
            showFlag: true,

            selectedCountry: country,
            showDialingCode: false,

            //displays dialing code, false by default
            showName: true,
            //displays country name, true by default
            showCurrency: false,
            //eg. 'British pound'
            showCurrencyISO: false,
            //eg. 'GBP'
            onChanged: (Country country) {
              setState(() {
                country = country;
              });
            },
          ));
    }}

    Widget Phone() {
      Phone_Text.text = _PhoneNumber;

      return Container(
        width: Size1.width_text,
        child: Container(
          padding: EdgeInsets.only(left: 2, right: 2),
          child: FittedBox(
            child: Container(
              width: Size1.width_text,
              child: TextFormField(
                controller: Phone_Text,
                validator: (val) =>
                    val.length < 9 ? 'Invaild Phone Number ' : null,
                onSaved: (val) => _PhoneNumber = val,
                obscureText: false,
                keyboardType: TextInputType.phone,
                style: TextStyle(
                    fontSize: Size1.Font_size, color: Colors.grey[700]),
                decoration: const InputDecoration(
                    border: InputBorder.none, hintText: "Phone", filled: false),
              ),
            ),
          ),
        ),
      );
    }
  }

