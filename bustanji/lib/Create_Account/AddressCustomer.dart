import 'dart:convert';

import 'package:devicepreview/AppTranslation/AppTranslation.dart';
import 'package:devicepreview/CustomDesign/CurveShape.dart';
import 'package:devicepreview/CustomDesign/Icons.dart';
import 'package:devicepreview/CustomTexts/CustomText.dart';
import 'package:devicepreview/CustomTexts/CutomPhoneText.dart';
import 'package:devicepreview/Login/Login.dart';
import 'package:devicepreview/WidthAndHeighTWidget/Size_layout.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_country_picker/flutter_country_picker.dart';

import '../CheckBox.dart';
import '../CustomerData.dart';

import '';
import '../CheckBox.dart';
import '../CustomerData.dart';
import 'package:http/http.dart' as http;

import '../Urls.dart';
import 'CreateAccount.dart';

class AddressCustomer extends StatefulWidget {
  @override
  AddressCustiomerstate createState() => AddressCustiomerstate();
}

class AddressCustiomerstate extends State<AddressCustomer> {
  String city, phone, CustomerPH = '', PhoneNumber;
  String orinteation;

  final tephone = TextEditingController();
  FocusNode _focusPhone = new FocusNode();

  final teddress = TextEditingController();
  final tecity = TextEditingController();

  // final tephone=TextEditingController();
  FocusNode _focusNode = new FocusNode();
  FocusNode _focusCity = new FocusNode();
  FocusNode _focusAddress = new FocusNode();
  Country country1 = Country.JO, country2 = Country.JO;
  bool isshowing = false;
  double fieldwidth = 300, height = 70;
  final button = new GlobalKey();
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Animation animation;

  void _submitCommand() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();
      phone = country2.dialingCode.toString();

      CustomerPH = phone + '-' + tephone.text;
      print(CustomerPH);
      print(city);

      // print(country2.name.toString());
      print(CustomerData.birhdate);
      print(phone);
      CustomerPH = phone + '-' + tephone.text;

      if (CustomerData.checkagreemment == false) {
        Fluttertoast.showToast(
            msg: ApplicationLocalizations.of(context).translate("Agreement"),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        LoginDatabase();
      }
    }
  }

  // Email & password matched our validation rules
  // and are saved to _email and _password fields.
  // _loginCommand();

  Future<List> LoginDatabase() async {
    print(CustomerData.firstname);

    var url = Urls.createaccount;
    http.Response response = await http.post(url, body: {
      'firstname': CustomerData.firstname,
      'lastname': CustomerData.lastname,
      'email': CustomerData.Email,
      'password': CustomerData.Password,
      'address': teddress.text,
      'city': tecity.text,
      'address': teddress.text,
      'country': country1.name,
      'phone': CustomerPH,
      'nationality': CustomerData.nationality,
      'birthdate': CustomerData.birhdate,
      'gender': CustomerData.gender,
    });

    var user = json.decode(response.body);

    if (user['message'] == 'success') {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Login(),
          ));
    }
//if(checkemail=="1"){
//      _loginCommand();
  }

  Future<bool> _onWillPop() async {
    return (Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CreateAccount(),
        )));
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      orinteation == "portrait";
    } else {
      orinteation = "Landscape";
    }
    return new WillPopScope(
        onWillPop: _onWillPop,
        child: new Scaffold(
            appBar: new AppBar(
              backgroundColor: Colors.indigo[900],
              title: new Text(""),
            ),
            resizeToAvoidBottomInset: false,
            body: (
                SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 80),
                child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    color: Colors.white,
                    child: Container(
                      width: double.infinity,
                        child: Column(children: <Widget>[
                      Container(
                          child: Column(children: <Widget>[
                        Container(
                            child: Column(children: <Widget>[
                          Container(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                Container(
                                    child: Container(
                                        child: CurveShape(
                                            Icons.add_location,
                                            ApplicationLocalizations.of(context)
                                                .translate(
                                                    "Address_Detials")))),
                                Padding(
                                    padding: EdgeInsets.all(0),
                                    child: Form(
                                        key: formKey,
                                        child: Column(children: [
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
                                                  SetIcons(Icons.location_city),
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
                                                              teddress,
                                                              focusNod:
                                                              _focusAddress,
                                                              textSize: 12.0,
                                                              textFont: "Nexa_Bold",
                                                            ).textFieldWithOutPrefix(
                                                                ApplicationLocalizations
                                                                    .of(context)
                                                                    .translate(
                                                                    "Address"),
                                                                ApplicationLocalizations
                                                                    .of(context)
                                                                    .translate(
                                                                    "Address"),
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
                                                  SetIcons(Icons.location_city),
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
                                                              teddress,
                                                              focusNod:
                                                              _focusCity,
                                                              textSize: 12.0,
                                                              textFont: "Nexa_Bold",
                                                            ).textFieldWithOutPrefix(
                                                                ApplicationLocalizations
                                                                    .of(context)
                                                                    .translate(
                                                                    "Address"),
                                                                ApplicationLocalizations
                                                                    .of(context)
                                                                    .translate(
                                                                    "Address"),
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
                                                    child: Country1(),
                                                  )
                                                ]),
                                              )),
                                          //
                                          Container(

                                              width:
                                              double.infinity,
                                              margin: EdgeInsets.only(
                                                  left: 5,
                                                  right: 5,
                                                  top: Size1.margin_top,
                                                  bottom: Size1.margin_bottom),
                                              decoration: new BoxDecoration(
                                                color: Colors.grey[100],
                                                borderRadius: new BorderRadius
                                                        .all(
                                                    new Radius.circular(10.0)),
                                              ),

                                              height: Size1.height_of_container,
                                              child: FittedBox(fit: BoxFit.scaleDown,
                                                child: Row(children: <Widget>[
                                                  Container(
                                                    child:
                                                        SetIcons(Icons.phone),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(left: 2,right: 2),
                                                    width:Size1.phonecode,
                                                    child: Phone_Code(),
                                                  ),
                                                  Container(
                                                    child: Phone(),
                                                  ),
                                                ]),
                                              )),
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            padding: EdgeInsets.fromLTRB(
                                                0, 10, 0, 5),
                                            child: FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: Row(children: <Widget>[
                                                Container(
                                                  child: CheckBox("Agree"),
                                                ),
                                                Container(
                                                  width: Size1.width_text,
                                                  child: Text(
                                                    ApplicationLocalizations.of(
                                                            context)
                                                        .translate("Agreement"),
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize:
                                                            Size1.Font_size,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ]),
                                            ),
                                          ),
                                          Container(
                                              height: Size1.height_of_container,
                                              width: Size1.width_text,
                                              margin: EdgeInsets.only(
                                                  top: 10, bottom: 10),
                                              child: RaisedButton(
                                                  onPressed: () {
                                                    _submitCommand();

                                                    //_submitCommanD();
                                                    // isshowing = true;
                                                    // animationButton();
                                                  },

//                    if(email.text==''){ print ("Vaild Email");}else{print(email.text);}},
                                                  color: Colors.indigo[900],
                                                  child: Text(
                                                    ApplicationLocalizations.of(
                                                            context)
                                                        .translate("Create"),
                                                    style: TextStyle(
                                                        fontSize:
                                                            Size1.Font_size,
                                                        color: Colors.white),
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10.0)),
                                                  )))
                                        ])))
                              ]))
                        ]))
                      ]))
                    ])))))));
  }
  Widget Country1() {
    return Container(
        width:Size1.width_text,
        padding: EdgeInsets.only(top: Size1.margin_top,
            bottom: Size1.margin_bottom, left: 5, right: 5),
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
              country1 = country;
              print(country);
            });
          },
          selectedCountry: country1,
        ));
//  }
  }

  Widget Phone() {
    return Container(

      width:Size1.width_text,
      padding: EdgeInsets.only(left: 5, right: 5),
      child: Container(
        child: InkWell(
          child: Container(
            child: new CustomPhoneText(
              inputBoxController: tephone,
              focusNod: _focusPhone,
              textSize: 12.0,
              textFont: "Nexa_Bold",
            ).textFieldWithOutPrefix(
                ApplicationLocalizations.of(context).translate("Phone"),
                ApplicationLocalizations.of(context).translate("Phone")),
          ),
        ),
      ),
    );
  }

  Widget Phone_Code() {
    return Container(
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
          print(country);
        });
      },
      selectedCountry: country2,
    ));
  }
}
