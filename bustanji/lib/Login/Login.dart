import 'dart:convert';
import 'package:devicepreview/HomePage/HomePage.dart';
import 'package:devicepreview/AppTranslation/AppTranslation.dart';
import 'package:devicepreview/AppTranslation/Application.dart';
import 'package:devicepreview/Create_Account/CreateAccount.dart';
import 'package:devicepreview/CustomDesign/CurveShape.dart';
import 'package:devicepreview/CustomDesign/Icons.dart';
import 'package:devicepreview/CustomTexts/Custom_Email_Text.dart';
import 'package:devicepreview/CustomTexts/Custom_Password_Text.dart';
import 'package:devicepreview/NavGuest/NavGuest.dart';
import 'package:devicepreview/Offers/OfferAndAllcar.dart';
import 'package:devicepreview/WidthAndHeighTWidget/Size_layout.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../CheckBox.dart';
import '../CustomerData.dart';
import '../SplashScreen.dart';
import '../Urls.dart';
import '../main.dart';
import 'package:devicepreview/ForgetPassword/ForgetPassword.dart';

class Login extends StatefulWidget {
  @override
  _Login createState() => new _Login();
}

class _Login extends State<Login> {
  bool isshowing = false;
  double fieldwidth = Size1.width_of_button;
  final button = new GlobalKey();
  static final List<String> languagesList = application.supportedLanguages;
  static final List<String> languageCodesList =
      application.supportedLanguagesCodes;

  final Map<dynamic, dynamic> languagesMap = {
    languagesList[0]: languageCodesList[0],
    languagesList[1]: languageCodesList[1],
  };

  String label = languagesList[0];

  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  final teFirstName = TextEditingController();
  final teLastName = TextEditingController();
  final teEmail = TextEditingController();
  final tePassword = TextEditingController();
  FocusNode _focusNodeEmail = new FocusNode();
  FocusNode _focusNodePass = new FocusNode();

  @override
  void dispose() {
    teFirstName.dispose();
    teLastName.dispose();
    teEmail.dispose();
    tePassword.dispose();
    super.dispose();
  }

  void _submitCommand() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();
      setState(() {
        isshowing = true;
      });
      LoginDatabase();

      // Email & password matched our validation rules
      // and are saved to _email and _password fields.
      // _loginCommand();
    }
  }

  Future<List> LoginDatabase() async {
    var url = Urls.login;
    http.Response response = await http
        .post(url, body: {'email': teEmail.text, 'password': tePassword.text});
    var user = json.decode(response.body);
    if (user.length == 0) {
      print("Fail");
      setState(() {
        Fluttertoast.showToast(
            msg: ApplicationLocalizations.of(context).translate("Login_Error"),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
        isshowing = false;
      });
    } else {
      print("Sucess");
      CustomerData.Email = user[0]['email'];
      CustomerData.Password = "";
      CustomerData.firstname = user[0]['first_name'];
      CustomerData.lastname = user[0]['last_name'];
      CustomerData.Address = user[0]['address'];
      CustomerData.city = user[0]['city'];
      CustomerData.Country = user[0]['country'];
      CustomerData.phonenumber = user[0]['phone_number'];
      CustomerData.nationality = user[0]['nationality'];
      CustomerData.birhdate = user[0]['birth_date'];
      CustomerData.gender = user[0]['gender'];
      CustomerData.customerid = user[0]['customer_id'];
      CustomerData.CustomerType = 'Customer';
      if (CustomerData.saveaccount == false) {
        setState(() {
          isshowing = false;
        });

        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
              HomePage(),
            ));
      } else {
        save();
      }
    }
  }

  Future<String> save() async {
    if (CustomerData.saveaccount == true) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("email", CustomerData.Email);
      prefs.setString("password", CustomerData.Password);
      prefs.setString("firstname", CustomerData.firstname);
      prefs.setString("Lastname", CustomerData.lastname);
      prefs.setString("country", CustomerData.Country);
      prefs.setString("phone", CustomerData.phonenumber);
      prefs.setString("city", CustomerData.city);
      prefs.setString("Save", "true");
      prefs.setString("nationality", CustomerData.nationality);
      prefs.setString("gender", CustomerData.gender);
      prefs.setString("customerid", CustomerData.Customerid);
      prefs.setString("Address", CustomerData.Address);
      prefs.setString("customerid", CustomerData.customerid);
      prefs.setString("Birthdate", CustomerData.birhdate);
      //checkaccount(); }}}}

//      Navigator.push(
//          context,
//          MaterialPageRoute(
//            builder: (context) => HomePage(),
//          ));
    }
  }

  Future<bool> _onWillPop() async {
    return (await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Login(),
        )));
  }

  void onLocaleChange(Locale locale) async {
    Locale chooselanguage;
    print(locale.languageCode);
    switch (locale.languageCode) {
      case ("en"):
        chooselanguage = Locale('en', 'US');
        CustomerData.Language = "English";
        break;
      case ("ar"):
        chooselanguage = Locale('ar', 'SA');
        CustomerData.Language = "Arabic";
        break;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("Language", chooselanguage.languageCode);
    LocalisedApp.setLocale(context, chooselanguage);
    await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SplashScreen(),
        ));
  }

  void _select(String language) {
    AlertDialogWarning(context, language);
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
  Widget build(BuildContext context) {
    //provides localised strings

    return new WillPopScope(
        onWillPop: _onWillPop,
        child: new Scaffold(
            appBar: new AppBar(
              backgroundColor: Colors.indigo[900],
              actions: <Widget>[
                PopupMenuButton<String>(
                  // overflow menu
                  onSelected: _select,
                  icon: new Icon(Icons.language, color: Colors.white,size: Size1.size_icon,),
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
            drawer: Container(
              child: NavGuest(),
            ),
            body: SingleChildScrollView(
              child: Container(
                margin:
                    EdgeInsets.only(top: 10, bottom: 30, left: 10, right: 10),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  color: Colors.white,
                  child: Column(children: <Widget>[
                    Container(
                        child: CurveShape(
                      Icons.person,
                      ApplicationLocalizations.of(context).translate("Login"),
                    )),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 30, 10, 20),
                      child: Form(
                        key: formKey,
                        child: Column(children: [
                          Container(
                            margin: EdgeInsets.only(top: Size1.margin_top,bottom: Size1.margin_bottom),
                            decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.all(
                                  new Radius.circular(10.0)),
                              color: Colors.grey[200],
                            ),


                            child: Container(

                              height: Size1.height_of_container,
                              width: double.infinity,
                              child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Row(children: <Widget>[
                                  Container(
                                    child: SetIcons(Icons.person),
                                  ),

                                  Container(
                                    child: InkWell(
                                      child: Container(
                                        child: Expanded(
                                          child: Container(



                                              child: new CustomEmailText(
                                                inputBoxController: teEmail,
                                                focusNod: _focusNodeEmail,
                                                textSize: 12.0,
                                                textFont: "Nexa_Bold",
                                              ).textFieldWithOutPrefix(
                                                  ApplicationLocalizations.of(
                                                          context)
                                                      .translate("Email"),
                                                  ApplicationLocalizations.of(
                                                          context)
                                                      .translate("Email")),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                ]),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: Size1.margin_top,bottom: Size1.margin_bottom),
                            decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.all(
                                  new Radius.circular(10.0)),
                              color: Colors.grey[200],
                            ),
                            height: Size1.height_of_container,
                            child: Container(

                              width: double.infinity,
                              child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Row(children: <Widget>[
                                  Container(
                                    child: SetIcons(Icons.lock),
                                  ),
                                  Container(
                                    child: InkWell(
                                      child: Container(
                                        child: Expanded(
                                          child: Container(

                                            child: new CustomPasswordText(
                                              inputBoxController: tePassword,
                                              focusNod: _focusNodePass,
                                              textSize: 12.0,
                                              textFont: "Nexa_Bold",
                                            ).textFieldWithOutPrefix(
                                                ApplicationLocalizations.of(
                                                        context)
                                                    .translate("Password"),
                                                ApplicationLocalizations.of(
                                                        context)
                                                    .translate("Password")),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                              ),
                            ),
                          ),
                          Container(width:Size1.width_text,
                            margin: EdgeInsets.only(
                                top: 10, bottom: 10, left: 5, right: 5),
                            child: FittedBox(
                              child: Row(children: <Widget>[
                                Container(child: CheckBox("RemberMe")),
                                Text(
                                  ApplicationLocalizations.of(context)
                                      .translate("RemberMe"),
                                  style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: Size1.Font_size,
                                      fontWeight: FontWeight.bold),
                                ),

                                Container(
                                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: FlatButton(
                                      onPressed: () {
   Navigator.push(
   context,
   MaterialPageRoute(
    builder: (context) =>
    ForgetPassword(),));
                                      },
                                      child: Text(
                                        ApplicationLocalizations.of(context)
                                            .translate("ForgetPassword"),
                                        style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: Size1.Font_size,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ),

//
//                                        child: Text(
//                                          "Forget Password",
//                                          style: TextStyle(
//                                              color: Colors.grey[700],
//                                              fontSize: 15,
//                                              fontWeight: FontWeight.bold),
//                                        ))
                              ]),
                            ),
                          ),
                          Container(
                            key: button,
                            height: Size1.height_of_container,
                   width: Size1.width_text,
                            margin: EdgeInsets.only(left:10,right:10, top:10),
                            child: RaisedButton(
                                onPressed: () {
                                  _submitCommand();
                                  isshowing = true;
                                  // animationButton();
                                },

//                    if(email.text==''){ print ("Vaild Email");}else{print(email.text);}},
                                color: Colors.indigo[900],
                                child: buildButtonchild(
                                  ApplicationLocalizations.of(context)
                                      .translate("Sign_in"),
                                  style: TextStyle(
                                      fontSize: Size1.Font_size,
                                      color: Colors.white),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                )),
                          ),
                          Container(          width: Size1.width_text,               height:Size1.height_of_container ,

                            margin:
                                EdgeInsets.only(left: 10, top: 10, bottom: 10,right: 10),
                            child: RaisedButton(
                                onPressed: () {
                                  CustomerData.CustomerType = 'Guest';
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => OffersAndAllcar(),
                                      ));
                                },
                                color: Colors.indigo[900],
                                child: Container(

                                  child: Text(
                                    ApplicationLocalizations.of(context)
                                        .translate("continue_without_Account"),
                                    style: TextStyle(
                                        fontSize: Size1.Font_size,
                                        color: Colors.white),
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                )),
                          ),
                          Container(
                            child: FlatButton(
                                onPressed: () {
  Navigator.push(
   context,
   MaterialPageRoute(
    builder: (context) =>
    CreateAccount(),
   ));
                                },
                                child: FittedBox(fit: BoxFit.scaleDown,
                                  child: Text(
                                    ApplicationLocalizations.of(context)
                                        .translate(
                                            "Do_not_Have _an_Account? Sign Up"),
                                    style: TextStyle(fontSize: Size1.Font_size),
                                  ),
                                )),
//              child: Text(
//                'Do not Have an Account?Sing Up ',
//
//                style: TextStyle(
//                    color: Colors.grey[700], fontWeight: FontWeight.bold),
//              ),
                          ),
                        ]),
                      ),
                    )
                  ]),
                ),
              ),
            )));
  }

  Widget buildButtonchild(String s, {TextStyle style}) {
    if (isshowing == true) {
      return Container(
        child: CircularProgressIndicator(
            value: null,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.indigo)),
      );
    } else {
      return Text(ApplicationLocalizations.of(context).translate("Sign_in"),
          style: TextStyle(fontSize: Size1.Font_size, color: Colors.white));
    }
  }
}
