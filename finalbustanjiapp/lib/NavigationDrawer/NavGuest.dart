import 'package:flutter/material.dart';
import 'package:language/AboutUS/AboutUs.dart';
import 'package:language/AppTranslation/AppTranslation.dart';
import 'package:language/BustanjiBranch/BranchLocation.dart';
import 'package:language/ContactUs/ContactUS.dart';
import 'package:language/CustomerInfo/CustomerData.dart';
import 'package:language/Emergency/Emergency.dart';
import 'package:language/Login/Login.dart';
import 'package:language/Reservation/ReservationData.dart';


import 'package:url_launcher/url_launcher.dart';


class NavGuest extends StatelessWidget {
  @override
  void Logout() {

  }

  _launchURL() async {
    const url = 'http://www.yarubsolutions.com/index.php/ar/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  BuildContext context1;

  Widget build(BuildContext context) {
    context1 = context;
    return Container(
        child: Drawer(
            child: SingleChildScrollView(
                child: Column(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: 100,

                        margin: EdgeInsets.only(top: 30, bottom: 20),

                        child: Container(


                          child: Image.network(
                              "https://www.yarubhost.com/images/companylogo.png"),


                        ),
                      ),
                      Container(child: ListTile(


                          leading: Container(
                              width: 50, child: Icon(Icons.lock)),
                          title: Text(
                              ApplicationLocalizations.of(context).translate("Login"),
                            style: TextStyle(fontSize: 17),
                          ),
                          onTap: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Login(),
                                ));
                          })),


                      ListTile(
                        leading: Container(
                            width: 50, child: Icon(Icons.local_car_wash)),
                        title: Text(
                            ApplicationLocalizations.of(context).translate("Make_Booking"),
                          style: TextStyle(fontSize: 17),
                        ),
                        onTap: () {
                          CustomerData.CustomerType = "Guest";
                          ReservationData.returndate = null;
                          ReservationData.returntime = null;
                          ReservationData.pickuptime = null;
                          ReservationData.pickupdate = null;
                          ReservationData.pickuploc = '';
                          ReservationData.returnlocation = '';
                          ReservationData.caryear =
                              ApplicationLocalizations.of(context1).translate(
                                  "All");
                          ReservationData.carcategory =
                              ApplicationLocalizations.of(context1).translate(
                                  "All");
//                      Navigator.push(
//                          context,
//                          MaterialPageRoute(
//                            builder: (context) => SearchCar(),
//                          ));
//                        },
                        }),
                      ListTile(
                          leading: Container(
                              width: 50, child: Icon(Icons.date_range)),
                          title: Text(
                              ApplicationLocalizations.of(context).translate("My_Booking"),
                            style: TextStyle(fontSize: 17),
                          ),
                          onTap: () {
                            ReservationData.height = 100;
                            if (CustomerData.CustomerType == "Customer") {
//                              Navigator.push(
//                                  context,
//                                  MaterialPageRoute(
//
//                                    builder: (context) => MyBooking(),
//                                  ));
//                            } else {
//                              Navigator.push(
//                                  context,
//                                  MaterialPageRoute(
//
//                                      builder: (context) =>
//                                          CustomerBooikingsearch()));
                           }
                          }),

                      ListTile(
                        leading: Container(
                            width: 50, child: Icon(Icons.gps_fixed)),
                        title: Text(
                            ApplicationLocalizations.of(context).translate("Branch"),
                          style: TextStyle(fontSize: 17),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BranchLocation(),
                              ));
                        },
                      ),
                      ListTile(
                        leading: Container(width: 50, child: Icon(Icons.info)),
                        title: Text(
                            ApplicationLocalizations.of(context).translate("AboutUs"),
                          style: TextStyle(fontSize: 17),
                        ), onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AboutUs(),
                            ));
                      },
                      ),


                      ListTile(


                        leading: Container(width: 50, child: Icon(Icons.call)),
                        title: Text(
                            ApplicationLocalizations.of(context).translate("Contact_Us"),
                          style: TextStyle(fontSize: 17),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ContactUs(),
                              ));
                        },

                      ),
                      ListTile(


                        leading: Container(
                            width: 50, child: Icon(Icons.announcement)),
                        title: Text(
                            ApplicationLocalizations.of(context).translate("Emergency"),
                          style: TextStyle(fontSize: 17),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Emergency(),
                              ));
                        },

                      ),
                      ListTile(
                        leading: FittedBox(
                            child: Container(child: Container(
                                width: 50, child: Icon(Icons.copyright)),)),
                        title: FittedBox(
                          child: Container(width: 350,
                            child: Text(
                                ApplicationLocalizations.of(context).translate("developedby"),
                              style: TextStyle(fontSize: 17),
                            ),
                          ),
                        ), onTap: () {
                        _launchURL();
                      },
                      ),


                    ]))));
  }

  Widget CustomerData1() {
    if (CustomerData.CustomerType == 'Customer') {
      return Container(child: Text(
        CustomerData.firstname + '  ' + CustomerData.lastname,
        style: TextStyle(color: Colors.black, fontSize: 17),),);
    }
    else if (CustomerData.CustomerType == 'guest') {}
  }


    }





