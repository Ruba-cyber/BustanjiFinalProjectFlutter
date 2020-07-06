import 'package:devicepreview/AboutUS/AboutUs.dart';
import 'package:devicepreview/AppTranslation/AppTranslation.dart';
import 'package:devicepreview/BustanjiBranch/BranchLocation.dart';
import 'package:devicepreview/ContactUs/ContactUS.dart';
import 'package:devicepreview/Customer_Search/CustomerBooikingsearch.dart';
import 'package:devicepreview/Emergency/Emergency.dart';
import 'package:devicepreview/Login/Login.dart';
import 'package:devicepreview/MyBooking/MyBooking.dart';
import 'package:devicepreview/SearchCar/SearchCar.dart';
import 'package:devicepreview/WidthAndHeighTWidget/Size_layout.dart';
import 'package:flutter/material.dart';
import 'package:devicepreview/MyProfile/MyProfile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:url_launcher/url_launcher.dart';

import '../CustomerData.dart';
import '../ReservationData.dart';


class NavigationDrawer extends StatelessWidget{
  @override
  void Logout(){

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
        child: 
        SafeArea(
          child:
          Drawer(
            child:SingleChildScrollView(
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
Container(child: Login1(),),
                   Container(child: CustomerData1(),),
                 Container(child: List(),),



                    ListTile(
                      leading: Container(
                          width: Size1.width_of_nav, child: Icon(Icons.local_car_wash)),
                      title: Text(
                        ApplicationLocalizations.of(context1).translate("Make_Booking"),
                        style: TextStyle(fontSize: Size1.Font_size),
                      ),
                      onTap: () {
                        ReservationData.returndate = null;
                        ReservationData.returntime = null;
                        ReservationData.pickuptime = null;
                        ReservationData.pickupdate = null;
                        ReservationData.pickuploc = '';
                        ReservationData.returnlocation = '';
                       // ReservationData.caryear =    ApplicationLocalizations.of(context1).translate("All");
                        ReservationData.carcategory =    ApplicationLocalizations.of(context1).translate(
                            "All");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SearchCar(),
                            ));
                      },
                    ),
                    ListTile(
                      leading: Container(
                          width: Size1.width_of_nav, child: Icon(Icons.date_range)),
                      title: Text(
                        ApplicationLocalizations.of(context1).translate("My_Booking"),
                        style: TextStyle(fontSize: Size1.Font_size),
                      ),
                      onTap: (){ ReservationData.height=100;
                      if(CustomerData.CustomerType=="Customer"){
    Navigator.push(
    context,
    MaterialPageRoute(

    builder: (context) => MyBooking(),
    ));
                        }
                      else{ Navigator.push(
                          context,
                          MaterialPageRoute(

                          builder: (context) => CustomerBooikingsearch()));}}),

                    ListTile(
                      leading: Container(
                          width: Size1.width_of_nav, child: Icon(Icons.gps_fixed)),
                      title: Text(
                        ApplicationLocalizations.of(context1).translate("Branch"),
                        style: TextStyle(fontSize:
                        Size1.Font_size),
                      ),
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BranchLocation(),
                            ));
                      },
                    ),
                    ListTile(
                      leading: Container(width: Size1.width_of_nav, child: Icon(Icons.info)),
                      title: Text(
                          ApplicationLocalizations.of(context1).translate("AboutUs"),
                          style: TextStyle(fontSize: Size1.Font_size),
                      ),onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AboutUs(),
                          ));

                    },
                    ),


                    ListTile(


                      leading: Container(width: Size1.width_of_nav, child: Icon(Icons.call)),
                      title: Text(
                          ApplicationLocalizations.of(context1).translate("Contact_Us")    ,
                        style: TextStyle(fontSize: Size1.Font_size),
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


                      leading: Container(width: Size1.width_of_nav,
                          child: Icon(Icons.announcement)),
                      title: Text(
                          ApplicationLocalizations.of(context1).translate("Emergency")    ,
                        style: TextStyle(fontSize:
                        Size1.Font_size),
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
                          child: Container( child: Container(width:Size1.size_icon,
                              child: Icon(Icons.copyright)),)),
                      title: FittedBox(fit: BoxFit.fitWidth,
                        child: Container(width: Size1.width_of_Developed,
                          child: Text(
                              ApplicationLocalizations.of(context1).translate("developedby"),
                            style: TextStyle(fontSize:Size1.Font_size),
                          ),
                        ),
                      ),onTap: (){

                      _launchURL();


                    },
                    ),
                   Container(child: Logout1(),),

                  ]))),
        ));

  }
  Widget CustomerData1(){
    if(CustomerData.CustomerType=='Customer') {
      return Container(child: Text(
        CustomerData.firstname + '  ' + CustomerData.lastname,
        style: TextStyle(color: Colors.black, fontSize: Size1.Font_size,
),),);
    }
    else if(CustomerData.CustomerType=='guest'){}
  }
  Widget List() {
    if(CustomerData.CustomerType =='Customer') {

      return Container(child: ListTile(
        leading: Container(width: Size1.width_of_nav, child: Icon(Icons.perm_identity)),
        title: Text(
          ApplicationLocalizations.of(context1).translate("My_Profile"),
          style: TextStyle(fontSize: 17),
        ),
        onTap: () {
          Navigator.push(
              context1,
              MaterialPageRoute(
                builder: (context) => new MyProfile(),
              ));
         }));
  }}
Widget Login1(){
    if(CustomerData.CustomerType=='Guest'){
    return Container(
    child: ListTile(


    leading: Container(width: Size1.width_of_nav, child: Icon(Icons.lock)),
    title: Text( ApplicationLocalizations.of(context1).translate("Login"),
      style: TextStyle(fontSize: Size1.Font_size),
    ),
    onTap: () async {



      Navigator.pushReplacement(context1,
          MaterialPageRoute(builder: (BuildContext ctx) =>
              Login()));}));}}
Widget Logout1(){
    if(CustomerData.CustomerType=='Customer'){
return Container(
  child: ListTile(


      leading: Container(width: Size1.width_of_nav, child: Icon(Icons.lock_open)),
      title: Text(
          ApplicationLocalizations.of(context1).translate("Logout"),
        style: TextStyle(fontSize: Size1.Font_size),
      ),
      onTap: () async {
        SharedPreferences prefs = await SharedPreferences
            .getInstance();
        if(prefs.getString("email")!=null){
          prefs.remove('email');
          prefs.clear();
           CustomerData.saveaccount=false;
           AlertDialogShow(context1);


        }
        else {AlertDialogShow(context1);

        }}));
}}
  AlertDialogShow(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: FittedBox(child: Text( ApplicationLocalizations.of(context1).translate("Logout"))),
              content:
              FittedBox(fit: BoxFit.fitWidth,
                child: Text(ApplicationLocalizations.of(context1).translate("Are_You_sure_want_to_Logout_from_your account ?"),
                    ),
              ),
              actions: <Widget>[
                Row(children: <Widget>[
                  MaterialButton(
                      elevation: 5.0,
                      onPressed: () {

                        Navigator.pushReplacement(context1,
                            MaterialPageRoute(builder: (BuildContext ctx) =>
                                Login()));


                      },
                      child: Text(ApplicationLocalizations.of(context1).translate("Yes"))),
                  MaterialButton(
                    elevation: 5.0,
                    onPressed: () {

                      Navigator.of(context).pop();
                    },
                    child: Text(ApplicationLocalizations.of(context1).translate("No"))),
                 ] )

              ]);
        });
  }}

