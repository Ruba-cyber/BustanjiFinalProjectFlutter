import 'package:devicepreview/AboutUS/AboutUs.dart';
import 'package:devicepreview/AppTranslation/AppTranslation.dart';
import 'package:devicepreview/BustanjiBranch/BranchLocation.dart';
import 'package:devicepreview/ContactUs/ContactUS.dart';
import 'package:devicepreview/Customer_Search/CustomerBooikingsearch.dart';
import 'package:devicepreview/Emergency/Emergency.dart';
import 'package:devicepreview/SearchCar/SearchCar.dart';
import 'package:devicepreview/WidthAndHeighTWidget/Size_layout.dart';
import 'package:flutter/material.dart';
import '../CustomerData.dart';
import '../ReservationData.dart';

class NavGuest extends StatelessWidget {
  @override
  void Logout() {}

  _launchURL() async {
//    const url = 'http://www.yarubsolutions.com/index.php/ar/';
//    if (await canLaunch(url)) {
//      await launch(url);
//    } else {
//      throw 'Could not launch $url';
//    }
//  }
  }

  BuildContext context1;

  Widget build(BuildContext context) {
    context1 = context;
    return Container(
        child: SafeArea(
          child: Drawer(
              child: SingleChildScrollView(
                  child: Column(children: <Widget>[
      Container(
          width: double.infinity,
          height: 100,
          margin: EdgeInsets.only(top: 30, bottom: 20),
          child: Container(
            child:
                Image.network("https://www.yarubhost.com/images/companylogo.png",
                  width: Size1.width_splash_Screen,height: Size1.height_splash_Screen,),
          ),
      ),
      Container(
            child: ListTile(
                leading: Container(
                    width: Size1.width_of_nav,
                    child: Icon(
                      Icons.lock,
                      size: Size1.size_icon,
                    )),
                title: Text(
                  ApplicationLocalizations.of(context).translate("Login"),
                  style: TextStyle(fontSize: Size1.font_size_nav),
                ),
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ContactUs(),
                      ));
                })),
      ListTile(
          leading: Container(
              width: Size1.width_of_nav,
              child: Icon(
                Icons.local_car_wash,
                size: Size1.size_icon,
              )),
          title: Text(
            ApplicationLocalizations.of(context).translate("Make_Booking"),
            style: TextStyle(fontSize: Size1.font_size_nav),
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
                ApplicationLocalizations.of(context).translate("All");
            ReservationData.carcategory =
                ApplicationLocalizations.of(context).translate("All");
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchCar(),
                ));
          },
      ),
      ListTile(
            leading: Container(
                width: Size1.width_of_nav,

                child: Icon(
                  Icons.date_range,
                  size: Size1.size_icon,
                )),
            title:
            Text(
                ApplicationLocalizations.of(context).translate("My_Booking"),
                style: TextStyle(fontSize: Size1.font_size_nav),
              ),
            onTap: () {
              if (CustomerData.CustomerType == "Customer") {
//                              Navigator.push(
//                                  context,
//                                  MaterialPageRoute(
//
//                                    builder: (context) => MyBooking(),
//                                  ));
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CustomerBooikingsearch()));
              }
            }),
      ListTile(
          leading: Container(
              width: Size1.width_of_nav,
              child: Icon(
                Icons.gps_fixed,
                size: Size1.size_icon,
              )),
          title: Text(
            ApplicationLocalizations.of(context).translate("Branch"),
            style: TextStyle(fontSize: Size1.font_size_nav),
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
          leading: Container(
              width: Size1.width_of_nav,
              child: Icon(
                Icons.info,
                size: Size1.size_icon,
              )),
          title: Container(
            width: Size1.width_of_nav,

              child: Text(
                ApplicationLocalizations.of(context).translate("AboutUs"),
                style: TextStyle(fontSize: Size1.font_size_nav),
              ),
            ),

          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AboutUs(),
                ));
          },
      ),
      ListTile(
          leading: Container(
              width: Size1.width_of_nav,
              child: Icon(
                Icons.call,
                size: Size1.size_icon,
              )),
          title: Container(
            width: Size1.width_of_nav,

              child: Text(
                ApplicationLocalizations.of(context).translate("Contact_Us"),
                style: TextStyle(fontSize: Size1.font_size_nav),
              ),

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
              width: Size1.width_of_nav,
              child: Icon(
                Icons.announcement,
                size: Size1.size_icon,
              )),
          title: Container(
            width: Size1.width_of_nav,

              child: Text(
                ApplicationLocalizations.of(context).translate("Emergency"),
                style: TextStyle(fontSize: Size1.font_size_nav),
              ),
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
          leading: FittedBox(fit: BoxFit.scaleDown,
              child: Container(
            child: Container(
                width: Size1.size_icon,
                child: Icon(
                  Icons.copyright,
                  size: Size1.size_icon,
                )),
          )),
          title: FittedBox(
            fit: BoxFit.fitWidth,
            child: Container(
              width: Size1.width_of_Developed,
              child: Text(
                ApplicationLocalizations.of(context).translate("developedby"),
                style: TextStyle(fontSize: Size1.font_size_nav),
              ),
            ),
          ),
          onTap: () {
            _launchURL();
          },
      ),
    ]))),
        ));
  }
}
