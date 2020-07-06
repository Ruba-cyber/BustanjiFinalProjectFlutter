
import 'package:devicepreview/AppTranslation/AppTranslation.dart';
import 'package:devicepreview/CustomDesign/CurveShape.dart';
import 'package:devicepreview/CustomDesign/Icons.dart';
import 'package:devicepreview/CustomTexts/CustomText.dart';
import 'package:devicepreview/DropDownList/DropDownList.dart';
import 'package:devicepreview/HomePage/HomePage.dart';
import 'package:devicepreview/Login/Login.dart';
import 'package:devicepreview/NavGuest/NavigationDrawer.dart';
import 'package:devicepreview/WidthAndHeighTWidget/Size_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:devicepreview/Steps_Of_Reservation/SecondStepChooseOptionAndInnsuranc.dart';
import 'package:devicepreview/TimePickerDialog.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import '../CustomerData.dart';
import '../DateSelected.dart';
import '../OfferDataAvaliable.dart';

import '../ReservationData.dart';
import '../Urls.dart';

class MakeBooking extends StatefulWidget {
  MakeBooking(this.offers) {
    ReservationData.returndate = null;
    ReservationData.returntime = null;
    ReservationData.pickuptime = null;
    ReservationData.pickupdate = null;
    ReservationData.pickuploc = '';
    ReservationData.returnlocation ='';

  }

  String offers;

  @override
  _HomePageState createState() => _HomePageState(offers);
}

class _HomePageState extends State<MakeBooking> {
  String bookingtype;

  Future<bool> _onWillPop() async {
    if(CustomerData.CustomerType=="Customer"){
    return (await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>  new HomePage(),
        )));
  }
    else{return (await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => new Login(),
        )));}}

  var txt = TextEditingController();

  FocusNode _focusNumber = new FocusNode();
  String flight;

  _HomePageState(this.bookingtype) {}
  List<String> LocationList = [], LocationType = [];
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool move = false;

  AlertDialogWarning(BuildContext context, String error) {
    return showDialog(
        context: context,
        builder: (context) {
          return Container(width: MediaQuery.of(context).size.width/2,
            height: MediaQuery.of(context).size.width/2,
            child: AlertDialog(
                title: (
                Text(ApplicationLocalizations.of(context).translate("Warning"))),
                content:
                FittedBox(child: Container(
                  width: Size1.width_text,
                    child: Text(error,style: TextStyle(fontSize: Size1.Font_size),maxLines: 2,))),
                actions: <Widget>[
                  Row(children: <Widget>[
                    MaterialButton(
                        elevation: 5.0,
                        onPressed: () {
                          // UpdateReservation();
//                        Navigator.push(
//                            context,
//                            MaterialPageRoute(
//                              builder: (context) => (),
//                            ));
                          Navigator.of(context).pop();
                        },
                        child: Text(ApplicationLocalizations.of(context).translate("ok"))),
                    MaterialButton(
                        elevation: 5.0,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          (ApplicationLocalizations.of(context).translate("Cancel")),
                        ))
                  ])
                ]),
          );
        });
  }

  void _submitCommand() {
    print(ReservationData.returndate);
    print(ReservationData.pickupdate);
    print(ReservationData.FlightDate);
    if (ReservationData.Airport == true ||ReservationData.ReturnLocationAirport==true) {
     // var splitreturndate = ReservationData.returndate.split('-');
      var split = ReservationData.pickupdate.split('-');
      //var yearreturndate = int.parse(splitreturndate[0]);
      //var monthreturn = int.parse(splitreturndate[1]);
      //var returnday = int.parse(splitreturndate[2]);
      var yearpickup = int.parse(split[0]);
      var monthpickup = int.parse(split[1]);
      var daypickupdate = int.parse(split[2]);
      var splitflightdate = ReservationData.FlightDate.split('-');
      var flightyear = int.parse(splitflightdate[0]);
      var monthflight = int.parse(splitflightdate[1]);
      var flightday = int.parse(splitflightdate[2]);
      var pickuptime1 = ReservationData.pickuptime.split(":").toString();
      var FlightTime = ReservationData.Flightime.split(":").toString();
      final pickupdate = DateTime(yearpickup, monthpickup, daypickupdate);
    //  final returndate = DateTime(yearreturndate, monthreturn, returnday);
      final flightdate = DateTime(flightyear, monthflight, flightday);
      print(pickuptime1);

      int hour1 = int.parse(pickuptime1[1]);
      int hour2 = int.parse(FlightTime[1]);

//iint min1=int.parse(pickuptime1[2]);
//     int min2=int.parse(pickuptime2[2]);

      if (ReservationData.FlightDate != null &&
          ReservationData.Flightime != null &&
          txt.text != null) {
        ReservationData.NumberFlight = txt.text;

        if (pickupdate.isAfter(flightdate)){// && flightdate.isBefore(returndate)) {
          print("dd");
          Move();
        } else {
          AlertDialogWarning(
            context,
            ApplicationLocalizations.of(context).translate("Flight_Date_before_pickupdate"),
          );
        }
        Move();
      } else {
        if (txt.text == null) {
          AlertDialogWarning(
            context,
            ApplicationLocalizations.of(context).translate("Please_Enter_Flight_Number"),
          );
        } else if (ReservationData.FlightDate == null) {
          AlertDialogWarning(
            context,
            ApplicationLocalizations.of(context).translate("Please_Enter_Flight_Date"),
          );

          //  msg: ApplicationLocalizations.of(context).translate.of(context).text("Please_Enter_Flight_Date"),  toastLength: Toast.LENGTH_SHORT,

          if (ReservationData.Flightime == null) {
            AlertDialogWarning(
              context,
              ApplicationLocalizations.of(context).translate("Please_Enter_Flight_Time"),
            );

            // msg: ApplicationLocalizations.of(context).translate.of(context).text("Please_Enter_Flight_Time"),

          }
        }
      }
    } else {
      Move();
    }
  }

  void Move() {
    if (ReservationData.pickuploc != null &&
        ReservationData.returnlocation != null &&
        ReservationData.pickuptime != null &&
        ReservationData.returntime != null &&
        ReservationData.pickupdate != null &&
        ReservationData.returndate != null) {
      SetDate();
    } else {
      if (ReservationData.pickuploc == null) {
        AlertDialogWarning(
          context,
          ApplicationLocalizations.of(context).translate("Please_Enter_pickup_Location"),
        );
      }

      if (ReservationData.returnlocation == null) {
        AlertDialogWarning(
          context,
          ApplicationLocalizations.of(context).translate("Please_Enter_Return_Location"),
        );
        //Please_Enter_Return_Location

      }

      if (ReservationData.pickuptime == null) {
        AlertDialogWarning(
          context,
          ApplicationLocalizations.of(context).translate("Please_Enter_Pickup_Time"),
        );
      }

      if (ReservationData.returntime == null) {
        AlertDialogWarning(
          context,
          ApplicationLocalizations.of(context).translate("Please_Enter_Return_Time"),
        );
      }

      if (ReservationData.returndate == null) {
        AlertDialogWarning(
          context,
          ApplicationLocalizations.of(context).translate("Please_Enter_Return_Date"),
        );
      }

      if (ReservationData.pickupdate == null) {
        AlertDialogWarning(
          context,
          ApplicationLocalizations.of(context).translate("Please_Enter_PickupDate"),
        );
      }
    }
  }

  Future<List<String>> Location() async {
    print(ReservationData.colorblue);
    var url = await http.get(Urls.getlocation);
    var location = json.decode(url.body);
    LocationList.clear();

    for (var u in location) {
      if (CustomerData.Language == "Arabic") {
        LocationList.add(u['location_name_arabic']);
      } else {
        LocationList.add(u['location_name_english']);
      }
      LocationType.add(u['type']);
      setState(() {
        ReservationData.pickuploc = '' + ReservationData.pickuploc;
        ReservationData.returnlocation = '' + ReservationData.returnlocation;
      });
    }
  }

  Future<String> SetDate() {
    print("Days Coumt");
    var split = ReservationData.pickupdate.split('-');
    var yearpickup = int.parse(split[0]);
    var monthpickup = int.parse(split[1]);
    var daypickupdate = int.parse(split[2]);
    var splitreturndate = ReservationData.returndate.split('-');
    var returnyear = int.parse(splitreturndate[0]);
    var monthreturn = int.parse(splitreturndate[1]);
    var dayreturn = int.parse(splitreturndate[2]);
    final pickupdate = DateTime(yearpickup, monthpickup, daypickupdate);
    final returndate = DateTime(returnyear, monthreturn, dayreturn);
    final datenow = DateTime.now();

    if (returndate.isAfter(pickupdate) && pickupdate.isAfter(datenow)) {
      final difference = returndate.difference(pickupdate).inDays + 1;

      ReservationData.ReservationDaysCount = difference;
      if (ReservationData.updatepickuplocation == true) {
//        Navigator.pushReplacement(
//            context, MaterialPageRoute(builder: (context) => OffersResult()),
//            result: (Route<dynamic> route()) => false);
      }
      if ((bookingtype == "Offers")) {
        setoffers(pickupdate, returndate);
        ReservationData.resstatus = "Offers";
      } else {
        ReservationData.resstatus = " No Offers";

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => new SecondStepChooseOptionAndInnsyranc()),
            result: (Route<dynamic> route()) => false);
      }

      ///    print("ReturN DAte");

    } else {
      if (pickupdate.isBefore(datenow) || pickupdate == datenow) {
        AlertDialogWarning(
          context,
          ApplicationLocalizations.of(context).translate("Can't_Reserve_in_same_day"),
        );
      }
      if (returndate.isBefore(pickupdate) || returndate == pickupdate) {
        AlertDialogWarning(
            context,
            ApplicationLocalizations.of(context).translate
          ("Can't_Reserve_less_than_one_day"));
      }
    }
  }

  void setoffers(var pickupdate, var returndate) {
    var pickupdateoffer = OfferDataAvaliable.from_date.split("-");
    int y1 = int.parse(pickupdateoffer[0]);
    int m1 = int.parse(pickupdateoffer[1]);
    int d1 = int.parse(pickupdateoffer[2]);
    var returndateoffer = OfferDataAvaliable.to_date.split("-");
    int y2 = int.parse(returndateoffer[0]);
    int m2 = int.parse(returndateoffer[1]);
    int d2 = int.parse(returndateoffer[2]);
    final offerstardate = DateTime(y1, m1, d1);
    final offersenddate = DateTime(y2, m2, d2);
    switch (OfferDataAvaliable.offername) {
      case ("timeOffer"):
        print("Time Offer");

        if (pickupdate.isBefore(offerstardate) ||
            pickupdate.isAfter((offersenddate)) ||
            returndate.isAfter(offersenddate) ||
            returndate.isBefore(offerstardate)) {
          AlertDialogWarning(
              context,
              ApplicationLocalizations.of(context).translate("rent_in_peroid") +
                  "" +
                  OfferDataAvaliable.from_date +
                  "" +
                  OfferDataAvaliable.to_date +
                  "" +
                  ApplicationLocalizations.of(context).translate("to_get_offer"));
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
  new SecondStepChooseOptionAndInnsyranc()));


              };

        break;
      case ("daysOffer"):
        print(ReservationData.ReservationDaysCount);
        print(OfferDataAvaliable.offerdaycount);
        int daycount = int.parse(OfferDataAvaliable.offerdaycount);
        if (ReservationData.ReservationDaysCount >= daycount) {
          if (pickupdate.isBefore(offersenddate) &&
              pickupdate.isAfter((offerstardate)) &&
              returndate.isAfter(offerstardate) &&
              returndate.isBefore(offersenddate)) {
            print("Get Offer");
            int freedays = int.parse(OfferDataAvaliable.offerdayofree);
            ReservationData.totaldaysfree =
                ReservationData.ReservationDaysCount - freedays;

            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => SecondStepChooseOptionAndInnsyranc()),
                result: (Route<dynamic> route()) => false);
          } else {
            AlertDialogWarning(
                context,
                ApplicationLocalizations.of(context).translate("rent_in_peroid") +
                    "" +
                    OfferDataAvaliable.from_date +
                    "" +
                    OfferDataAvaliable.to_date +
                    "" +
                    ApplicationLocalizations.of(context).translate("to_get_offer"));
          }
        } else {
          AlertDialogWarning(
              context,
              ApplicationLocalizations.of(context).translate("rent_in_peroid") +
                  "" +
                  OfferDataAvaliable.from_date +
                  "" +
                  OfferDataAvaliable.to_date +
                  "" +
                  ApplicationLocalizations.of(context).translate("to_get_offer"));
        }

        break;
      case ("discountOffer"):
        print("Discount Offer");
        if (pickupdate.isBefore(offerstardate) ||
            pickupdate.isAfter((offersenddate)) ||
            returndate.isAfter(offersenddate) ||
            returndate.isBefore(offerstardate)) {
          AlertDialogWarning(
              context,
              ApplicationLocalizations.of(context).translate("rent_in_peroid") +
                  "" +
                  OfferDataAvaliable.from_date +
                  "" +
                  OfferDataAvaliable.to_date +
                  "" +
                  ApplicationLocalizations.of(context).translate("to_get_offer"));
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => SecondStepChooseOptionAndInnsyranc()));
        }
        break;
        break;

      case ("optionOffer"):
        print("Option Offer");
        if (pickupdate.isBefore(offerstardate) ||
            pickupdate.isAfter((offersenddate)) ||
            returndate.isAfter(offersenddate) ||
            returndate.isBefore(offerstardate)) {
          AlertDialogWarning(
              context,
              ApplicationLocalizations.of(context).translate("rent_in_peroid") +
                  "" +
                  OfferDataAvaliable.from_date +
                  "" +
                  OfferDataAvaliable.to_date +
                  "" +
                  ApplicationLocalizations.of(context).translate("to_get_offer"));
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => SecondStepChooseOptionAndInnsyranc()));
        }
        break;
        break;
      case ("fuelOffer"):
        print("Fuel Offer");
        if (pickupdate.isBefore(offerstardate) ||
            pickupdate.isAfter((offersenddate)) ||
            returndate.isAfter(offersenddate) ||
            returndate.isBefore(offerstardate)) {
          AlertDialogWarning(
              context,
              ApplicationLocalizations.of(context).translate("rent_in_peroid") +
                  "" +
                  OfferDataAvaliable.from_date +
                  "" +
                  OfferDataAvaliable.to_date +
                  "" +
                  ApplicationLocalizations.of(context).translate("to_get_offer"));
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => SecondStepChooseOptionAndInnsyranc()));
        }

        break;
      default:
        setState((){ReservationData.resstatus='No Offer';});
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => new SecondStepChooseOptionAndInnsyranc()),
          result: (Route<dynamic> route()) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    Location();
    print(ReservationData.pickuploc);
    print(ReservationData.returnlocation);

    return new  WillPopScope(onWillPop: _onWillPop,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text(""),
            backgroundColor: Colors.indigo[900],
          ),
//          drawer: Container(
//            child: NavigationDrawer(),
//          ),

          // Not necessary for Option 1

          body: (SingleChildScrollView(
              padding: EdgeInsets.only(left: 10, right: 5, top: 10, bottom: 10),
              child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  color: Colors.white,
                  child: Container(
                      child: Column( mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                        Container(
                            child: Column(children: <Widget>[
                              Container(
                                  child: Column( mainAxisAlignment: MainAxisAlignment.spaceAround,children: <Widget>[
                                    Container(
                                        child: CurveShape(
                                          Icons.person,
                                          ApplicationLocalizations.of(context).translate("Make_Booking"),
                                        )),
                                    Container(
                                        margin: EdgeInsets.only(
                                            left: 5, right: 2, top: 10, bottom: 5),
                                        child: Column(children: [
                                          Container(
                                            width: double.infinity,
                                            margin: EdgeInsets.only(left: 5, right: 5),
                                            decoration: new BoxDecoration(
                                              borderRadius: new BorderRadius.all(
                                                  new Radius.circular(10.0)),
                                              color: Colors.grey[200],
                                            ),
                                            child: FittedBox(fit: BoxFit.fitWidth,
                                              child: Row(children: <Widget>[
                                                Container(
                                                  decoration: new BoxDecoration(
                                                    borderRadius: new BorderRadius.all(
                                                        new Radius.circular(1.0)),
                                                    color: Colors.indigo[700],
                                                  ),
                                                  child: SetIcons(
                                                    Icons.add_location,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Container(
                                                    width:Size1.width_text,

                                                    margin: EdgeInsets.only(left: 5, right: 5),
                                                    child: Container(

                                                      child: DropDownList(
                                                          ApplicationLocalizations.of(context).translate
                                                            ("PickupLoc"),
                                                          LocationList),
                                                    )),
                                              ]),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 10,bottom: 10),
                                            child:DateSelected(ApplicationLocalizations.of(context).translate("Pickup_date")),
                                          ),
                                          Container(
                                              margin: EdgeInsets.only(top: 10,bottom: 10),
                                              child: TimePickerDialog(
                                                  ApplicationLocalizations.of(context).translate
                                                      ("Pickup_time"))),
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: 5, right: 5, top: 10, bottom: 10),
                                            width: double.infinity,
                                            decoration: new BoxDecoration(
                                              color: Colors.grey[200],
                                              borderRadius: new BorderRadius.all(
                                                  new Radius.circular(10.0)),
                                            ),
                                            child: Container(

                                              child: FittedBox(
                                                child: Row(children: <Widget>[
                                                  Container(
                                                    decoration: new BoxDecoration(
                                                      borderRadius: new BorderRadius.all(
                                                          new Radius.circular(1.0)),
                                                      color: Colors.indigo[700],
                                                    ),
                                                    child: SetIcons(
                                                      Icons.add_location,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Container(
                                                     width: Size1.width_text,
                                                      child: Container(

                                                          padding: EdgeInsets.only(
                                                              left: 2, right: 2),
                                                          child: DropDownList(
                                                              (ApplicationLocalizations.of(context).translate
                                                                 ("returnloc")),
                                                              LocationList))),
                                                ]),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 10,bottom: 10),
                                            child: DateSelected(ApplicationLocalizations.of(context).translate
                                                ("Return_date")),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 10,bottom: 10),
                                            child: TimePickerDialog(
                                                ApplicationLocalizations.of(context).translate
                                                    ("Return_Time")),
                                          ),
                                          Container(
                                            child: Airport(),
                                          ),
                                          Container(
                                            height: Size1.height_of_container,
                                            margin: EdgeInsets.only(bottom: Size1.margin_top, top: Size1.margin_bottom),
                                            width:Size1.width_text,
                                            child: RaisedButton(
                                                onPressed: () {
                                                  _submitCommand();
                                                  // isshowing = true;
                                                  // animationButton();
                                                },

//                    if(emaiRl.text==''){ print ("Vaild Email");}else{print(email.text);}},
                                                color: Colors.indigo[900],
                                                child: Text(
                                                  ApplicationLocalizations.of(context).translate
                                                      ("Continue"),
                                                  style: TextStyle(
                                                      fontSize: Size1.Font_size, color: Colors.white),
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.all(Radius.circular(10.0)),
                                                )),
                                          ),
                                        ])),
                                  ]))
                            ]))
                      ])))))),
    );
  }

  Widget Airport() {
    if (ReservationData.Airport == true ||
        ReservationData.ReturnLocationAirport == true) {
      return Column(children: <Widget>[
        Container(margin: EdgeInsets.only(top: 10,bottom: 10),
          width:double.infinity,
          child: DateSelected(
            ApplicationLocalizations.of(context).translate("Flight_Date"),
          ),

        ),
        Container(
          margin: EdgeInsets.only(top: 10,bottom: 10),
          width: double.infinity,
          child: TimePickerDialog(
            ApplicationLocalizations.of(context).translate("Flight_Time"),
          ),
        ),
        Container(
width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
            decoration: new BoxDecoration(
              color: Colors.grey[200],
              borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
            ),
            height: Size1.height_of_container,
            child: FittedBox(fit: BoxFit.scaleDown,
              child: Row(children: <Widget>[
                Container(
                  child: SetIcons(Icons.flight),
                ),
                Container(
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      child: InkWell(
                        child: Container(
                          child: new CustomText(
                            inputBoxController: txt,
                            focusNod: _focusNumber,
                            textSize: 12.0,
                            textFont: "Nexa_Bold",
                          ).textFieldWithOutPrefix(
                              ApplicationLocalizations.of(context).translate("Flight_Number"),
                              ApplicationLocalizations.of(context).translate("Flight_Number"),context),
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
            ))
      ]);
    }
  }
}
