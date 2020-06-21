import 'package:flutter/material.dart';
import 'package:language/AppTranslation/AppTranslation.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsDesign extends StatefulWidget {
  @override
  AsyncSnapshot snapshot;
  int index;

  ContactUsDesign(this.snapshot, this.index) {}

  _ContactUsDesignState createState() => _ContactUsDesignState(snapshot, index);
}

class _ContactUsDesignState extends State<ContactUsDesign> {
  AsyncSnapshot snapshot;
  int index;

  _ContactUsDesignState(this.snapshot, this.index) {}

  void call(String number) => launch("tel:$number");

  void sendEmail(String email) => launch("mailto:$email");

  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 10, right: 10,top: 5),
        child: Material(
          elevation: 1.0,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 5, bottom: 0),
                child: Text(
                  "" + snapshot.data[index].branchnameen,
                  style: TextStyle(fontSize: 18, color: Colors.black,fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                height: 30,
                margin: EdgeInsets.all(5),
                decoration: new BoxDecoration(

                  borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
                ),
                padding: EdgeInsets.all(5),
                child: Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Icon(
                        Icons.phone,
                        color: Colors.indigo,
                        size: 20,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Text( ApplicationLocalizations.of(context).translate("Phone1"),
                        style: TextStyle(fontSize: 17, color: Colors.black,fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: InkWell(
                        onTap: () {
                          call(snapshot.data[index].phone1);
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                            left: 2,
                          ),
                          child: Text(
                            "" + snapshot.data[index].phone1,
                            style: TextStyle(
                                fontSize: 15, color: Colors.indigo[900]),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: 30,
                margin: EdgeInsets.all(5),
                decoration: new BoxDecoration(

                  borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
                ),
                padding: EdgeInsets.all(5),
                child: Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Icon(
                        Icons.phone,
                        color: Colors.indigo,
                        size: 20,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Text(
                        ApplicationLocalizations.of(context).translate("Phone2"),
                        style: TextStyle(fontSize: 17, color: Colors.black,fontWeight: FontWeight.bold,),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: InkWell(
                        onTap: () {
                          call(snapshot.data[index].phone2);
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                            left: 2,
                          ),
                          child: Text(
                            "" + snapshot.data[index].phone2,
                            style: TextStyle(
                                fontSize: 17, color: Colors.indigo[900]),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(

                height: 30,
                margin: EdgeInsets.all(5),
                decoration: new BoxDecoration(
                   borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
                ),
                padding: EdgeInsets.all(5),
                child: Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Icon(
                        Icons.phone,
                        color: Colors.indigo,
                        size: 20,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Text(
                          ApplicationLocalizations.of(context).translate("Phone3"),
                        style: TextStyle(fontSize: 17, color: Colors.black,fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: InkWell(
                        onTap: () {
                          call(snapshot.data[index].phone3);
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                            left: 2,
                          ),
                          child: Text(
                            "" + snapshot.data[index].phone3,
                            style: TextStyle(
                                fontSize: 15, color: Colors.indigo[900]),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                  height: 30,
                  margin: EdgeInsets.all(5),
                  decoration: new BoxDecoration(

                    borderRadius:
                        new BorderRadius.all(new Radius.circular(10.0)),
                  ),
                  padding: EdgeInsets.all(5),
                  child: Row(children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Icon(
                        Icons.email,
                        color: Colors.indigo,
                        size: 20,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Text(
                          ApplicationLocalizations.of(context).translate("Email_ContactUs"),
                        style: TextStyle(fontSize: 17, color: Colors.black,fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 30, right: 10),
                      child: InkWell(
                        onTap: () {
                          sendEmail(snapshot.data[index].email);
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                            left: 2,
                          ),
                          child: Text(
                            "" + snapshot.data[index].email,
                            style: TextStyle(
                                fontSize: 15, color: Colors.indigo[900]),
                          ),
                        ),
                      ),
                    ),
                  ])),
              Container(
                height: 30,
                margin: EdgeInsets.all(5),
                decoration: new BoxDecoration(

                  borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
                ),
                padding: EdgeInsets.all(5),
                child: Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Icon(
                        Icons.phone,
                        color: Colors.indigo,
                        size: 20,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Text(
                        ApplicationLocalizations.of(context).translate("Fax"),
                        style: TextStyle(fontSize: 17, color: Colors.black,fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 40, right: 10),
                      child: InkWell(
                        onTap: () {
                          call(snapshot.data[index].fax);
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                            left: 2,
                          ),
                          child: Text(
                            "" + snapshot.data[index].fax,
                            style: TextStyle(
                                fontSize: 15, color: Colors.indigo[900]),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
