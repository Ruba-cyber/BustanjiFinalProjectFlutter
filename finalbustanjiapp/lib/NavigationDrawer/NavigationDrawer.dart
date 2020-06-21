import 'package:flutter/material.dart';
import 'package:language/AboutUS/AboutUs.dart';
import 'package:language/AppTranslation/AppTranslation.dart';
import 'package:language/BustanjiBranch/BranchLocation.dart';
import 'package:language/BustanjiBranch/BranchLocation.dart';
import 'package:language/ContactUs/ContactUS.dart';
import 'package:language/CustomerInfo/CustomerData.dart';
import 'package:language/Emergency/Emergency.dart';
import 'package:language/Login/Login.dart';
import 'package:language/Reservation/ReservationData.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';


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
        child: Drawer(
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
                        width: 50, child: Icon(Icons.local_car_wash)),
                    title: Text(
                       ApplicationLocalizations.of(context).translate("Make_Booking"),
                      style: TextStyle(fontSize: 17),
                    ),
                    onTap: () {
                      ReservationData.returndate = null;
                      ReservationData.returntime = null;
                      ReservationData.pickuptime = null;
                      ReservationData.pickupdate = null;
                      ReservationData.pickuploc = '';
                      ReservationData.returnlocation = '';
                      ReservationData.caryear =  ApplicationLocalizations.of(context).translate("All");
                      ReservationData.carcategory =  ApplicationLocalizations.of(context).translate("All");
//                      Navigator.push(
//                          context,
//                          MaterialPageRoute(
//                            builder: (context) => SearchCar(),
//                          ));
                    },
                  ),
//                  ListTile(
//                    leading: Container(
//                        width: 50, child: Icon(Icons.date_range)),
//                    title: Text(
//                       ApplicationLocalizations.of(context).translate("My_Booking"),
//                      style: TextStyle(fontSize: 17),
//                    ),
//                    onTap: (){ ReservationData.height=100;
//                    if(CustomerData.CustomerType=="Customer"){
//    Navigator.push(
//    context,
//    MaterialPageRoute(
//
//    builder: (context) => MyBooking(),
//    ));}else{ Navigator.push(
//                        context,
//                        MaterialPageRoute(
//
//                        builder: (context) => CustomerBooikingsearch()));}}),

                  ListTile(
                    leading: Container(
                        width: 50, child: Icon(Icons.gps_fixed)),
                    title: Text(
                       ApplicationLocalizations.of(context).translate("Branch_loc"),
                      style: TextStyle(fontSize: 17),
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
                    leading: Container(width: 50, child: Icon(Icons.info)),
                    title: Text(
                         ApplicationLocalizations.of(context).translate("AboutUs"),
                        style: TextStyle(fontSize: 17),
                    ),onTap: (){
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
                         ApplicationLocalizations.of(context).translate("Contact_Us")    ,
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


                    leading: Container(width: 50, child: Icon(Icons.announcement)),
                    title: Text(
                         ApplicationLocalizations.of(context).translate("Emergency")    ,
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
                        child: Container( child: Container(width:50,child: Icon(Icons.copyright)),)),
                    title: FittedBox(
                      child: Container(width: MediaQuery.of(context).size.width/3,
                        child: Text(
                             ApplicationLocalizations.of(context).translate("developedby"),
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ),onTap: (){

                    _launchURL();


                  },
                  ),
                 Container(child: Logout1(),),

                ]))));

  }
  Widget CustomerData1(){
    if(CustomerData.CustomerType=='Customer') {
      return Container(child: Text(
        CustomerData.firstname + '  ' + CustomerData.lastname,
        style: TextStyle(color: Colors.black, fontSize: 17),),);
    }
    else if(CustomerData.CustomerType=='guest'){}
  }
  Widget List() {
    if(CustomerData.CustomerType =='Customer') {

      return Container(child: ListTile(
        leading: Container(width: 50, child: Icon(Icons.perm_identity)),
        title: Text(
           ApplicationLocalizations.of(context1).translate("My_Profile"),
          style: TextStyle(fontSize: 17),
    )));
//        onTap: () {
//          Navigator.push(
//              context1,
//              MaterialPageRoute(
//                builder: (context) => new MyProfile(),
//              ));
//         }));
  }}
Widget Login1(){
    if(CustomerData.CustomerType=='Guest'){
    return Container(
    child: ListTile(


    leading: Container(width: 50, child: Icon(Icons.lock)),
    title: Text(  ApplicationLocalizations.of(context1).translate("Login"),
      style: TextStyle(fontSize: 17),
    ),
    onTap: () async {



      Navigator.pushReplacement(context1,
          MaterialPageRoute(builder: (BuildContext ctx) =>
              Login()));}));}}
Widget Logout1(){
    if(CustomerData.CustomerType=='Customer'){
return Container(
  child: ListTile(


      leading: Container(width: 50, child: Icon(Icons.lock_open)),
      title: Text(
           ApplicationLocalizations.of(context1).translate("Logout"),
        style: TextStyle(fontSize: 17),
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
              title: Text(  ApplicationLocalizations.of(context1).translate("Logout")),
              content: Text( ApplicationLocalizations.of(context1).translate("Are_You_sure_want_to_Logout_from_your account ?"),
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
                      child: Text( ApplicationLocalizations.of(context1).translate("Yes"))),
                  MaterialButton(
                    elevation: 5.0,
                    onPressed: () {

                      Navigator.of(context).pop();
                    },
                    child: Text( ApplicationLocalizations.of(context1).translate("No"))),
                 ] )

              ]);
        });
  }}

