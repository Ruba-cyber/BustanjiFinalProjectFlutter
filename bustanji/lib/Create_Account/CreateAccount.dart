import 'dart:convert';
import 'package:devicepreview/AppTranslation/AppTranslation.dart';
import 'package:devicepreview/CustomDesign/CurveShape.dart';
import 'package:devicepreview/CustomDesign/Icons.dart';
import 'package:devicepreview/CustomTexts/CustomText.dart';
import 'package:devicepreview/CustomTexts/Custom_Email_Text.dart';
import 'package:devicepreview/CustomTexts/Custom_Password_Text.dart';
import 'package:devicepreview/Login/Login.dart';
import 'package:devicepreview/WidthAndHeighTWidget/Size_layout.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../CustomerData.dart';
import '../DateSelected.dart';

import '../Urls.dart';
import 'AddressCustomer.dart';
import 'GenderData.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccount createState() => _CreateAccount();
}

class _CreateAccount extends State<CreateAccount> {
  TextDirection textDirection;
  String error_password, error_renter_password;
  Country _Nationality = Country.JO;

  final teFirstName = TextEditingController();
  final teLastName = TextEditingController();
  final teEmail = TextEditingController();
  final teRenterPassword = TextEditingController();
  final tePassword = TextEditingController();
  FocusNode _focusNodeFirstName = new FocusNode();
  FocusNode _focusNodeLastName = new FocusNode();
  FocusNode _focusNodeEmail = new FocusNode();
  FocusNode _focusNodePass = new FocusNode();
  FocusNode _focusNodePassreter = new FocusNode();
  bool errorfirstname = false,
      errorlastname = false,
      erroremail = false,
      errorpassword = false,
      errorrenterpassword = false,
      birthdateerror = false;
  double fieldwidth = 500, height = 70;
  String email_error = '';
  final button = new GlobalKey();
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Animation animation;
  String orinetation;

  void _submitCommand() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();
      print("firstname" + teFirstName.text);
      if (teFirstName.text ==
          ApplicationLocalizations.of(context).translate("First_Name")) {
        print("d:");
        setState(() {
          errorfirstname = true;
        });
      }
      if (CustomerData.birhdate != null &&
          tePassword != null &&
          teRenterPassword != null) {
        checkEmail();
      } else {
        if (tePassword != teRenterPassword) {
          error_password = ApplicationLocalizations.of(context)
              .translate("Mismatch_Password");
          Fluttertoast.showToast(
              msg: error_renter_password,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: Size1.Font_size);
        }
        if (tePassword == null) {
          error_password = ApplicationLocalizations.of(context)
              .translate("Invalid_Password");
          Fluttertoast.showToast(
              msg: error_password,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: Size1.Font_size);
        } else if (teRenterPassword == null) {
          error_renter_password = ApplicationLocalizations.of(context)
              .translate("Invalid_Password");
          Fluttertoast.showToast(
              msg: error_renter_password,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: Size1.Font_size);
        }

        if (CustomerData.birhdate == null) {}
        if (teEmail.text == null) {
          setState(() {
            erroremail = true;
            email_error =
                ApplicationLocalizations.of(context).translate("Email_Invalid");
            Fluttertoast.showToast(
                msg: email_error,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0);
          });
        }
//        if (_Nationality == null) {
//          Fluttertoast.showToast(
//              msg: "Please Choose Your Nationality",
//              toastLength: Toast.LENGTH_SHORT,
//              gravity: ToastGravity.BOTTOM,
//              backgroundColor: Colors.black,
//              textColor: Colors.white,
//              fontSize: 16.0);
        //  }
      }
    }
  }

  // CheckInfo();}

  // Email & password matched our validation rules
  // and are saved to _email and _password fields.
  // _loginCommand();
  Future<bool> _onWillPop() async {
    return (Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Login(),
        )));
  }

  Future<List> checkEmail() async {
    var url = Urls.checkemail;

    http.Response response =
        await http.post(url, body: {'email': teEmail.text});
    var user = json.decode(response.body);
    print(user);
    if (user['message'] == 'success') {
      setState(() {
        erroremail = true;
        email_error =
            ApplicationLocalizations.of(context).translate("Email_Found");
        Fluttertoast.showToast(
            msg: "" + email_error,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: Size1.Font_size);
        //  }
      });
    } else {
      print("Sucess");
      CustomerData.firstname = teFirstName.text;
      CustomerData.lastname = teLastName.text;
      CustomerData.Email = teEmail.text;
      CustomerData.Password = tePassword.text;

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddressCustomer(),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      print("protaie");
      orinetation = "Protat";
    } else {
      orinetation = "Landscape";
      print("Landscape");
    }

    return new WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                "",
                textDirection: textDirection,
              ),
              backgroundColor: Colors.indigo[900],
            ),
            resizeToAvoidBottomInset: false,
            body: (SingleChildScrollView(
                child: Container(
                  width: double.maxFinite,
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 80),
                    child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        color: Colors.grey[100],
                        child: Container(
                            child: Column(children: <Widget>[
                          Container(
                              child: Column(children: <Widget>[
                            Container(
                                child: Column(children: <Widget>[
                              Container(
                                child: Container(
                                    child: CurveShape(
                                  Icons.person,
                                  ApplicationLocalizations.of(context)
                                      .translate("Create_Account"),
                                )),
                              ),
                            ])),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 2, right: 2, top: 10, bottom: 10),
                              child: Form(
                                key: formKey,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: Size1.margin_top, bottom:Size1.margin_bottom),
                                        decoration: new BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius: new BorderRadius.all(
                                              new Radius.circular(10.0)),
                                        ),
                                      ),

                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 5,
                                            right: 5,
                                            top: Size1.margin_top,
                                            bottom: Size1.margin_bottom),
                                        decoration: new BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius: new BorderRadius.all(
                                              new Radius.circular(10.0)),
                                        ),
                                        height: Size1.height_of_container,
                                        width:
                                          double.infinity,
                                        child: FittedBox(
                                          fit: BoxFit.fitWidth,
                                          child: Row(children: <Widget>[
                                            Container(
                                              child:
                                                  SetIcons(Icons.perm_identity),
                                            ),
                                            Container(width: Size1.width_text,
                                                child: InkWell(
                                              onTap: () {},
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: InkWell(
                                                  child: Container(
                                                    child: new CustomText(
                                                      inputBoxController:
                                                          teFirstName,
                                                      focusNod:
                                                          _focusNodeFirstName,
                                                      textSize: 12.0,
                                                      textFont: "Nexa_Bold",
                                                    ).textFieldWithOutPrefix(
                                                        ApplicationLocalizations
                                                                .of(context)
                                                            .translate(
                                                                "First_Name"),
                                                        ApplicationLocalizations
                                                                .of(context)
                                                            .translate(
                                                                "Invaild_Name"),
                                                        context),
                                                  ),
                                                ),
                                              ),
                                            )),
                                          ]),
                                        ),
                                      ),

                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 5,
                                            right: 5,
                                            top: Size1.margin_top,
                                            bottom: Size1.margin_bottom),
                                        decoration: new BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius: new BorderRadius.all(
                                              new Radius.circular(10.0)),
                                        ),
                                        height: Size1.height_of_container,
                                        width:
                                          double.infinity,
                                        child: FittedBox(
                                          fit: BoxFit.fitWidth,
                                          child: Row(children: <Widget>[
                                            Container(
                                              child:
                                                  SetIcons(Icons.perm_identity),
                                            ),
                                            Container(
                                                child: InkWell(
                                              onTap: () {},
                                              child: Container(
                                                width: Size1.width_text,
                                                child: InkWell(
                                                  child: Container(
                                                    child: new CustomText(
                                                      inputBoxController:
                                                          teLastName,
                                                      focusNod:
                                                          _focusNodeLastName,
                                                      textSize: 12.0,
                                                      textFont: "Nexa_Bold",
                                                    ).textFieldWithOutPrefix(
                                                        ApplicationLocalizations
                                                                .of(context)
                                                            .translate(
                                                                "Last_Name"),
                                                        ApplicationLocalizations
                                                                .of(context)
                                                            .translate(
                                                                "Invaild_Name"),
                                                        context),
                                                  ),
                                                ),
                                              ),
                                            )),
                                          ]),
                                        ),
                                      ),

                                      Container(
                                          width:
                                            double.infinity,
                                          margin: EdgeInsets.only(
                                              left: 5,
                                              right: 5,
                                              top: Size1.margin_top,
                                              bottom: Size1.margin_bottom),
                                          decoration: new BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius: new BorderRadius.all(
                                                new Radius.circular(10.0)),
                                          ),
                                          height: Size1.height_of_container,
                                          child: FittedBox(
                                            fit: BoxFit.fitWidth,
                                            child: Row(children: <Widget>[
                                              Container(
                                                decoration: new BoxDecoration(
                                                  color: Colors.indigo[700],
                                                  borderRadius: new BorderRadius
                                                          .all(
                                                      new Radius.circular(1)),
                                                ),
                                                child: SetIcons(
                                                  Icons.language,
                                                ),
                                              ),
                                              Container(
                                                child: Nationality(),
                                              )
                                            ]),
                                          )),
                                      //
                                      Container(


                                        child: GenderData(),
                                      ),
                                      Container(
                                          width:
                                              double.infinity,
                                          child: DateSelected(
                                            ApplicationLocalizations.of(context)
                                                .translate("Birth_date"),
                                          )),

                                      Container(
                                          margin: EdgeInsets.only(
                                              left: 5,
                                              right: 5,
                                              top: Size1.margin_top,
                                              bottom: Size1.margin_bottom),
                                          decoration: new BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius: new BorderRadius.all(
                                                new Radius.circular(10.0)),
                                          ),
                                          width:
                                            double.infinity,
                                          height: Size1.height_of_container,
                                          child: FittedBox(
                                            fit: BoxFit.fitWidth,
                                            child: Row(children: <Widget>[
                                              Container(
                                                child: SetIcons(
                                                  Icons.email,
                                                ),
                                              ),
                                              Container(
                                                width:Size1.width_text,
                                                child: InkWell(
                                                  child: new CustomEmailText(
                                                    inputBoxController: teEmail,
                                                    focusNod: _focusNodeEmail,
                                                    textSize: 12.0,
                                                    textFont: "Nexa_Bold",
                                                  ).textFieldWithOutPrefix(
                                                      ApplicationLocalizations
                                                              .of(context)
                                                          .translate("Email2"),
                                                      ApplicationLocalizations
                                                              .of(context)
                                                          .translate("" +
                                                              email_error)),
                                                ),
                                              ),
                                            ]),
                                          )),

                                      Container(
                                          width:
                                            double.infinity,
                                          margin: EdgeInsets.only(
                                              left: 5,
                                              right: 5,
                                              top: Size1.margin_top,
                                              bottom: Size1.margin_bottom),
                                          decoration: new BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius: new BorderRadius.all(
                                                new Radius.circular(10.0)),
                                          ),
                                          height: Size1.height_of_container,
                                          child: FittedBox(
                                            fit: BoxFit.fitWidth,
                                            child: Row(children: <Widget>[
                                              Container(
                                                child: SetIcons(
                                                  Icons.lock,
                                                ),
                                              ),
                                              Container(
                                               width: Size1.width_text,
                                                child: InkWell(
                                                  child: new CustomPasswordText(
                                                    inputBoxController:
                                                        tePassword,
                                                    focusNod: _focusNodePass,
                                                    textSize: 12.0,
                                                    textFont: "Nexa_Bold",
                                                  ).textFieldWithOutPrefix(
                                                    ApplicationLocalizations.of(
                                                            context)
                                                        .translate("Password"),
                                                    error_password,
                                                  ),
                                                ),
                                              ),
                                            ]),
                                          )),
                                      //

                                      Container(
                                          margin: EdgeInsets.only(
                                              left: 5,
                                              right: 5,
                                              top: Size1.margin_top,
                                              bottom: Size1.margin_bottom),
                                          decoration: new BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius: new BorderRadius.all(
                                                new Radius.circular(10.0)),
                                          ),
                                          height: Size1.height_of_container,
                                          width:double.infinity,

                                          child: FittedBox(
                                            fit: BoxFit.fitWidth,
                                            child: Row(children: <Widget>[
                                              Container(
                                                child: SetIcons(
                                                  Icons.lock,
                                                ),
                                              ),
                                              Container(
                                                width:Size1.width_text,
                                                child: InkWell(
                                                  child: new CustomPasswordText(
                                                    inputBoxController:
                                                        teRenterPassword,
                                                    focusNod:
                                                        _focusNodePassreter,
                                                    textSize: 12.0,
                                                    textFont: "Nexa_Bold",
                                                  ).textFieldWithOutPrefix(
                                                      ApplicationLocalizations
                                                              .of(context)
                                                          .translate(
                                                              "Renter_Paasword"),
                                                      error_renter_password),
                                                ),
                                              ),
                                            ]),
                                          )),
                                      //

                                      Center(
                                        child: Container(
                                          key: button,
                                          height: Size1.height_of_container,
                                          width: fieldwidth,
                                          margin: EdgeInsets.only(
                                              left: 25,
                                              top: Size1.margin_top,
                                              right: 25,
                                              bottom: Size1.margin_bottom),
                                          child: RaisedButton(
                                              onPressed: () {
                                                _submitCommand();

                                                // animationButton();
                                              },

//                    if(email.text==''){ print ("Vaild Email");}else{print(email.text);}},
                                              color: Colors.indigo[900],
                                              child: Text(
                                                ApplicationLocalizations.of(
                                                        context)
                                                    .translate("Continue"),
                                                style: TextStyle(
                                                    fontSize: Size1.Font_size,
                                                    color: Colors.white),
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
                                              )),
                                        ),
                                      ),
                                    ]),
                              ),
                            )
                          ])),
                        ]))))))));

//
//
  }

  Widget Nationality() {
    return Container(
        width: Size1.width_text,
        padding: EdgeInsets.only(top: 8, bottom: 8, left: 5, right: 5),
        child: CountryPicker(
          dense: false,
          showFlag: true,
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
              _Nationality = country;
              print(country);
            });
          },
          selectedCountry: _Nationality,
        ));
  }
}
