

import 'package:flutter/material.dart';
import 'package:language/AppTranslation/AppTranslation.dart';
import 'package:url_launcher/url_launcher.dart';

class Emergency extends StatefulWidget {
  @override
  _EmergencyState createState() => _EmergencyState();
}

class _EmergencyState extends State<Emergency> {
  @override
  void call(String number) => launch("tel:$number");

  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.indigo[900],
        ),
        body: SingleChildScrollView(
            child: Container(
                child: Material(
                    child: Column(children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 50),
                          child: Material(
                              elevation: 5.0,
                              borderRadius: BorderRadius.all(Radius.circular(20.0)),
                              color: Colors.white,
                              child: Container(
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.only(top: 30, bottom: 10),
                                        decoration: (BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius: BorderRadius.only())),
                                        width: MediaQuery.of(context).size.width,
                                        height: 150,
                                        child: Column(children: <Widget>[
                                          Container(
                                            child: Icon(
                                              Icons.add_alert,
                                              color: Colors.indigo[900],
                                              size: 60,
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                                 ApplicationLocalizations.of(context).translate("Emergency"),
                                              style: TextStyle(
                                                  color: Colors.indigo[900], fontSize: 20),
                                            ),
                                          )
                                        ]),
                                      ),
                                      Container(
                                        margin:
                                        EdgeInsets.only(left: 10, top: 10, bottom: 10,right: 100),
                                        child: FittedBox(
                                          child: Container(width: 400,
                                            child: Text(
                                               ApplicationLocalizations.of(context).translate("Emergency_Call"),
                                              style:
                                              TextStyle(fontSize: 20, color: Colors.black),
                                            ),
                                          ),
                                        ),),
                                      Container(
                                        margin:
                                        EdgeInsets.only(left: 10, top: 10, bottom: 10),
                                        child: Text(
                                           ApplicationLocalizations.of(context).translate("Emergency_Number"),
                                          style:
                                          TextStyle(fontSize: 20, color: Colors.indigo),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(10),
                                        decoration: new BoxDecoration(
                                          borderRadius: new BorderRadius.all(
                                              new Radius.circular(10.0)),
                                          color: Colors.grey[300],
                                        ),
                                        height: 50,
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.only(left: 10, right: 10),
                                              child: Icon(
                                                Icons.phone,
                                                color: Colors.indigo[900],
                                                size: 30,
                                              ),
                                            ),
                                            Container(
                                              child: InkWell(
                                                onTap: () {
                                                  call("911");
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                    left: 2,
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "911",
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.indigo[900]),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin:
                                        EdgeInsets.only(left: 10, top: 10, bottom: 10),
                                        child: Text(
                                           ApplicationLocalizations.of(context).translate("Customer_Services"),    style:
                                          TextStyle(fontSize: 20, color: Colors.indigo),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(10),
                                        decoration: new BoxDecoration(
                                          borderRadius: new BorderRadius.all(
                                              new Radius.circular(10.0)),
                                          color: Colors.grey[300],
                                        ),
                                        height: 50,
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.only(left: 10, right: 10),
                                              child: Icon(
                                                Icons.phone,
                                                color: Colors.indigo[900],
                                                size: 30,
                                              ),
                                            ),
                                            Container(
                                              child: InkWell(
                                                onTap: () {
                                                  call("065785225");
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                    left: 2,
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "065785225",
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.indigo[900]),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                      ),
                                      Container(
                                        margin:
                                        EdgeInsets.only(left: 10, top: 10, bottom: 10,right: 10),
                                        child: Text(
                                           ApplicationLocalizations.of(context).translate("Accident_Traffic"),
                                          style:
                                          TextStyle(fontSize: 20, color: Colors.indigo),
                                        ),),
                                      Container(
                                        margin: EdgeInsets.all(10),
                                        decoration: new BoxDecoration(
                                          borderRadius: new BorderRadius.all(
                                              new Radius.circular(10.0)),
                                          color: Colors.grey[300],
                                        ),
                                        height: 50,
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.only(left: 10, right: 10),
                                              child: Icon(
                                                Icons.phone,
                                                color: Colors.indigo[900],
                                                size: 30,
                                              ),
                                            ),
                                            Container(
                                              child: InkWell(
                                                onTap: () {
                                                  call("065785225");
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                    left: 2,
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "065785225",
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.indigo[900]),
                                                    ),
                                                  ),
                                                ),
                                              ),

                                            ),

                                          ],

                                        ),),
                                      Container(
                                        margin:
                                        EdgeInsets.only(left: 10, top: 10, bottom: 10),
                                        child: Text(
                                           ApplicationLocalizations.of(context).translate("Road_way"),
                                          style:
                                          TextStyle(fontSize: 20, color: Colors.indigo),
                                        ),),
                                      Container(
                                        margin: EdgeInsets.all(10),
                                        decoration: new BoxDecoration(
                                          borderRadius: new BorderRadius.all(
                                              new Radius.circular(10.0)),
                                          color: Colors.grey[300],
                                        ),
                                        height: 50,
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.only(left: 10, right: 10),
                                              child: Icon(
                                                Icons.phone,
                                                color: Colors.indigo[900],
                                                size: 30,
                                              ),
                                            ),
                                            Container(
                                              child: InkWell(
                                                onTap: () {
                                                  call("065785225");
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                    left: 2,
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "065785225",
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.indigo[900]),
                                                    ),
                                                  ),
                                                ),
                                              ),

                                            ),

                                          ],

                                        ),),    ]),
                              )))
                    ])))));
  }
}

