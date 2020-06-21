import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:language/AppTranslation/AppTranslation.dart';
import 'package:language/CustomDesign/CurveShape.dart';
import 'package:language/CustomDesign/Icons.dart';
import 'package:language/CustomText/CustomEmail.dart';
import 'package:language/CustomText/CustomPassword.dart';
import 'package:language/Login/Login.dart';
import 'package:language/Urls/BustanjiUrl.dart';


class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {

  final teRenterPassword = TextEditingController();
  final teEmail = TextEditingController();
  final tePassword = TextEditingController();

  FocusNode _FocusNodePassword = new FocusNode();
  FocusNode _FocusNodeEmail = new FocusNode();
  FocusNode _FocusNodeRenterPassword = new FocusNode();
  final formKey = GlobalKey<FormState>();
  String email,renterpassword,password;
  Future<bool> _onWillPop() async {
    return (
        await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Login(),
            )));

  }
  void _submitCommand() {

    final form = formKey.currentState;

    if (form.validate()) {
      form.save();

      if (tePassword.text == teRenterPassword.text) {
        CheckEmail();
        print("Confirmed");
      } else {
        Fluttertoast.showToast(
         msg: ApplicationLocalizations.of(context).translate("Mismatch_Password"),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,

            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
      // animationButton();
    };}
  Future<List> CheckEmail() async {
    var url = BustanjiUrls.checkemail;

    http.Response response = await http.post(url, body: {'email':teEmail.text});

    var user = json.decode(response.body);
    print(user);
    if (user['message'] == 'success') {
      UpdatePassword();
    }
  else{  Fluttertoast.showToast(
        msg: ApplicationLocalizations.of(context).translate("Email_Not_Exit"),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,

        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0
    );}}
  Future<List>UpdatePassword()async{
    var url=BustanjiUrls.forgetpassword;
    http.Response response = await http.post(url, body: {'email':teEmail.text,'password':tePassword.text});

    var user = json.decode(response.body);
    if (user['message'] == 'success') {

      Fluttertoast.showToast(
          msg: ApplicationLocalizations.of(context).translate("Update"),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,

          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0
      );
  }}
  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: _onWillPop,
        child: new Scaffold(
        appBar: new AppBar(backgroundColor: Colors.indigo[900],
        title: new Text(""),
    ),
        body: (SingleChildScrollView(

            child: Container(padding: EdgeInsets.all(10),margin: EdgeInsets.only(bottom: 30),
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
                                Container(child:CurveShape(Icons.person,ApplicationLocalizations.of(context).translate("Reset_Password"),)),

                    Container(
                        margin: EdgeInsets.only(left:5, top:10),
                        child: Form(
                            key: formKey,
                            child: Column(children: [

                            Container(
                            margin: EdgeInsets.only(top:10,bottom: 10,left: 5,right: 5),
                          decoration: new BoxDecoration(color: Colors.grey[200],
                            borderRadius: new BorderRadius.all(
                                new Radius.circular(10.0)),

                          ),
                          height: 50,
                          child: Row(
                              children: <Widget>[
                                Container(
                                  decoration: new BoxDecoration(color: Colors.indigo[700],
                                    borderRadius: new BorderRadius.all(
                                        new Radius.circular(1)),),

                                  child: SetIcons(Icons.email),
                                ),
                                Container(
                                    child: InkWell(
                                      onTap: () {

                                      },

                                      child:
                                      Container(
                                        child: Container(
                                          child: new CustomEmailText(
                                            inputBoxController: teEmail,
                                            focusNod: _FocusNodeEmail,
                                            textSize: 12.0,
                                            textFont: "Nexa_Bold",
                                          ).textFieldWithOutPrefix(
                                              ApplicationLocalizations.of(context).translate("Email"),
                                              ApplicationLocalizations.of(context).translate("Email"),context),
                                        ),
                                      ),


                                    )),])),//
                              Container(
                                  margin: EdgeInsets.only(top:10,bottom: 10,left: 5,right: 5),
                                  decoration: new BoxDecoration(color: Colors.grey[200],
                                    borderRadius: new BorderRadius.all(
                                        new Radius.circular(10.0)),

                                  ),
                                  height: 50,
                                  child: Row(
                                      children: <Widget>[
                                        Container(
                                          decoration: new BoxDecoration(color: Colors.indigo[700],
                                            borderRadius: new BorderRadius.all(
                                                new Radius.circular(1)),),

                                          child: SetIcons(Icons.lock),
                                        ),
                                        Container(
                                          child: InkWell(
                                            onTap: () {

                                            },

                                            child:
                                              Container(
                                                child: Container(
                                                  child: new CustomPasswordText(
                                                    inputBoxController: tePassword,
                                                    focusNod: _FocusNodePassword,
                                                    textSize: 12.0,
                                                    textFont: "Nexa_Bold",
                                                  ).textFieldWithOutPrefix(
                                                      ApplicationLocalizations.of(context).translate("New_Password"),
                                                      ApplicationLocalizations.of(context).translate("New_Password"),context),
                                                ),
                                              ),


                                        )),])),//


                        Container(
                    margin: EdgeInsets.only(top:10,bottom: 10,left: 5,right: 5),
                  decoration: new BoxDecoration(color: Colors.grey[200],
                    borderRadius: new BorderRadius.all(
                        new Radius.circular(10.0)),

                  ),
                  height: 50,
                  child: Row(
                      children: <Widget>[
                        Container(
                          decoration: new BoxDecoration(color: Colors.indigo[700],
                            borderRadius: new BorderRadius.all(
                                new Radius.circular(1)),),

                          child: SetIcons(Icons.lock),
                        ),
                        Container(
                            child: InkWell(
                              onTap: () {

                              },

                              child:
                              Container(
                                child: Container(
                                  child: new CustomPasswordText(
                                    inputBoxController: teRenterPassword,
                                    focusNod: _FocusNodePassword,
                                    textSize: 12.0,
                                    textFont: "Nexa_Bold",
                                  ).textFieldWithOutPrefix(
                                      ApplicationLocalizations.of(context).translate(
                                          "Reset_Password"),
                                      ApplicationLocalizations.of(context).translate(
                                      "Reset_Password"),context),
                                ),
                              ),


                            )),])),//
                              Container(
width: MediaQuery.of(context).size.width/2,height: 50,
                                margin: EdgeInsets.only(bottom: 70,top: 20),
                                child: RaisedButton(
                                    onPressed: () {
_submitCommand();

                                      // animationButton();
                                    },

//                    if(email.text==''){ print ("Vaild Email");}else{print(email.text);}},
                                    color: Colors.indigo[900],
                                    child: Text( ApplicationLocalizations.of(context).translate(
                                        "change"),
                              
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white),),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                    )),
                              ),

   ]),
                        ),),
                  ]),),
            ]))])),))))));



  }
}

