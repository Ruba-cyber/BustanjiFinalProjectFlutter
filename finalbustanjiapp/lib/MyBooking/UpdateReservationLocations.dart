
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:language/AppTranslation/AppTranslation.dart';
import 'package:language/CustomDesign/CurveShape.dart';
import 'package:language/CustomDesign/Icons.dart';
import 'package:language/OffersData/OfferDataAvaliable.dart';
import 'package:language/Reservation/ReservationData.dart';
import 'package:language/Urls/BustanjiUrl.dart';
import 'MyBooking.dart';


class UpdateReservationLocations extends StatefulWidget {
  String pickuploc,
      pickupdate,
      returndate,
      returnloc,
      resid,
      returntime,
      pickuptime,
      flightdate,
      flighttime,
      flightnumber,
      confirmation;
  double totalsum,taxamount;
  bool visairport;

  UpdateReservationLocations(
      this.resid,
      this.confirmation,
      this.pickuploc,
      this.returnloc,
      this.pickupdate,
      this.returndate,
      this.pickuptime,
      this.returntime,
      this.flightdate,
      this.flighttime,
      this.flightnumber,
      this.totalsum,this.visairport,this.taxamount) {}

  String offers;

  @override
  _HomePageState createState() => _HomePageState(
      this.resid,
      this.confirmation,
      this.pickuploc,
      this.returnloc,
      this.pickupdate,
      this.returndate,
      this.pickuptime,
      this.returntime,
      this.flightdate,
      this.flighttime,
      this.flightnumber,
      this.totalsum,this.visairport,this.taxamount);
}

class _HomePageState extends State<UpdateReservationLocations> {
  String bookingtype;
  var txt = TextEditingController();
  String flight, locationtxt;
  String pickuploc,
      resid,
      pickupdate,
      returndate,
      returnloc,
      returntime,
      pickuptime,
      flightdate,
      flighttime,
      flightnumber,
      confirmation;
  bool returntypelocation=false,visairport;
  double totalsum = 0, totalaftertax = 0, taxamount = 0;



  _HomePageState(
      this.resid,
      this.confirmation,
      this.pickuploc,
      this.returnloc,
      this.pickupdate,
      this.returndate,
      this.pickuptime,
      this.returntime,
      this.flightdate,
      this.flighttime,
      this.flightnumber,
      this.totalsum,this.visairport,this.taxamount) {}

  AlertDialogShow(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text('Alert !'),
              content: Text('Are You sure  want to change ? '
                  ' the total price of reservation will be changed'),
              actions: <Widget>[
                Row(children: <Widget>[
                  MaterialButton(
                      elevation: 5.0,
                      onPressed: () {
                        UpdateReservation();
                      },
                      child: Text("ok")),
                  MaterialButton(
                    elevation: 5.0,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Cancel"),
                  )
                ])
              ]);
        });
  }

  Future<DateTime> DateTime2(BuildContext context, String DateSet) async {
    final DateTime dateTime = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1920),
        lastDate: DateTime(DateTime.now().year + 2));

    if (dateTime != null) {
      setState(() {
        switch (DateSet) {
          case ("Pickupdate"):
            pickupdate = dateTime.year.toString() +
                '-' +
                dateTime.month.toString() +
                '-' +
                dateTime.day.toString();
            break;
          case ("Returndate"):
            returndate = dateTime.year.toString() +
                '-' +
                dateTime.month.toString() +
                '-' +
                dateTime.day.toString();
            break;
          case ("Flight Date"):flightdate=dateTime.year.toString() +
              '-' +
              dateTime.month.toString() +
              '-' +
              dateTime.day.toString();break;

        }
      });
    }
  }

  Future<String> UpdateReservation() async {
    print("Update Reservation");
    print(resid);
    print(totalsum);
    print(totalaftertax);print(flightnumber);

    if (visairport == true||returntypelocation==true||ReservationData.Airport==true) {
      print("Flight" + ReservationData.returndate);
    } else {
      flightdate = '0000-00-00';
      flightnumber = "No";
      flighttime = '0:0000';
    }
    var url = BustanjiUrls.updatelocation;

    http.Response response = await http.post(url, body: {
      "resrvationID": resid,
      'returnLocation': returnloc,
      'pickupLocation': pickuploc,
      'pickupDate': pickupdate,
      'returnDate': returndate,
      'pickupTime': pickuptime,
      'reservationStaus': 'Updated',
      'flightDate': flightdate,
      'flightNumber': flightnumber,
      'flightTime': flighttime,
      'confirmation': confirmation,
      'priceBeforeTax': totalsum.toString(),
      'priceAfterTax': totalaftertax.toString(),
      'returnTime':returntime,
    });
    var user = json.decode(response.body);

    if (user['message'] == 'success') {
      Fluttertoast.showToast(
          msg: "Reservation Updated ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MyBooking(),
          ));
    } else {

    }
//if(checkemail=="1"){
//      _loginCommand();
  }

  Future<String> Location(String pickuploction) async {
    var url = await http.get(BustanjiUrls.searchlocation);
    var user = json.decode(url.body);
    print("yd");
    print(user);
    for (var i in user) {

      print(i["location_name_english"]);
      if (i["location_name_english"] == pickuploction) {
        locationtxt = i["tax_amount"];
        taxamount = double.parse(locationtxt);
        print("Tax_Amount"+taxamount.toString());
        String type=i["type"];
        if(type=="1"){
          ReservationData.Airport=true;
          print("Airport");


        }
        else{setState(() {
          ReservationData.Airport=false;

        });}
        print (type);
        print(locationtxt);



        //print(locationTxt);
        //    ReservationData.taxamount=locationTxt;
//print(ReservationData.taxamount);

      }
    }}
  Future<String> ReturnLocation(String returnlocation) async {
    var url = await http.get(BustanjiUrls.searchlocation);
    var user = json.decode(url.body);
    print("yd");
    print(user);
    for (var i in user) {

      print(i["location_name_english"]);
      if (i["location_name_english"] == returnlocation) {

        String type=i["type"];
        if(type=="1") {print("Airport");
        setState(() {
          returntypelocation = true;

        });
        print(type);
        }
        else{setState(() {
          returntypelocation=false;

        });}}}}

  //print(locationTxt);
  //    ReservationData.taxamount=locationTxt;
//print(ReservationData.taxamount);






  List<String> _myJson = [];
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool move = false;

  void _submitCommand() {
    Location(pickuploc);
    if (ReservationData.Airport == true||returntypelocation==true) {
      var split = pickupdate.split('-');
      var yearpickup = int.parse(split[0]);
      var monthpickup = int.parse(split[1]);
      var daypickupdate = int.parse(split[2]);
      var splitflightdate = flightdate.split('-');
      var returnyear = int.parse(splitflightdate[0]);
      var monthreturn = int.parse(splitflightdate[1]);
      var dayreturn = int.parse(splitflightdate[2]);
      var pickuptime1 = pickuptime.split(":").toString();
      var pickuptime2 = flighttime.split(":").toString();
      final pickupdate1 = DateTime(yearpickup, monthpickup,
          daypickupdate);
      final returndate = DateTime(returnyear, monthreturn, dayreturn);
      print(pickuptime1);
      print(pickuptime2);
      int hour1 = int.parse(pickuptime1[1]);

      int hour2 = int.parse(pickuptime2[1]);

      if (flightdate != null && flighttime != null && txt.text != null) {
        if (ReservationData.pickuploc.contains("Aireport")) {
          if (pickupdate1.isAfter(returndate)) {
            Move();
          } else if (pickupdate1 == returndate && (hour1 > hour2)) {
            Move();
          } else {
            Fluttertoast.showToast(
                msg: "Please Renter Flight Time or pickupdate",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        } else {
          Move();
        }
      } else {
        if (txt.text == null) {
          Fluttertoast.showToast(
              msg: "Please Enter The Flight Number",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0);
        } else if (flightdate == null) {
          Fluttertoast.showToast(
              msg: "Please Enter  Flight Date",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0);
        } else {
          if (flighttime == null) {
            Fluttertoast.showToast(
                msg: "Please Enter  Flight Time",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        }

      }
    } else {
      Move();
    }
  }

//   }   } else {

  void Move() {
    if (pickupdate != null &&
        pickuptime != null &&
        pickuploc != null &&
        returndate != null &&
        returnloc != null &&
        returntime != null) {
      SetDate();
    } else {
      if (ReservationData.pickuploc == null) {
        Fluttertoast.showToast(
            msg: "Please Choose Pickup Location",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
      }

      if (ReservationData.returnlocation == null) {
        Fluttertoast.showToast(
            msg: "Please Choose Return  Location",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
      }

      if (ReservationData.pickuptime == null) {
        Fluttertoast.showToast(
            msg: "Please Choose Pick Up Time",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
      }

      if (ReservationData.returntime == null) {
        Fluttertoast.showToast(
            msg: "Please Choose Return Time",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
      }

      if (ReservationData.returndate == null) {
        Fluttertoast.showToast(
            msg: "Please Choose Return Date",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
      }

      if (ReservationData.pickupdate == null) {
        Fluttertoast.showToast(
            msg: "Please Choose Pick Up Date",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
  }

  Future<TimeOfDay> TimeSelect(
      BuildContext context, String pickuptimestate) async {
    final now = DateTime.now();
    final dateTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: now.hour, minute: now.minute),
    );



    if (dateTime != null) {
      setState(() {
        switch(pickuptimestate){
          case("Pick Up Time"):  pickuptime = '' + dateTime.format(context);break;
          case("Return Time"):    returntime = '' + dateTime.format(context);break;
          case("Flight Time"): flighttime = '' + dateTime.format(context);break;
        }

        // txttime=''+dateTime.hour.toString()+':'+dateTime.minute.toString();
      });
    }
  }

  Future<List<String>> Data() async {
    print(ReservationData.colorblue);
    var url = await http.get(BustanjiUrls.getlocation);
    var coin = json.decode(url.body);
    _myJson.clear();
    for (var u in coin) {
      _myJson.add(u['location_name_english']);
      setState(() {
        ReservationData.pickuploc = '' + ReservationData.pickuploc;
        ReservationData.returnlocation = '' + ReservationData.returnlocation;
      });
    }
  }

  Future<String> SetDate() {
    print("Days Coumt");
    var split = pickupdate.split('-');
    var yearpickup = int.parse(split[0]);
    var monthpickup = int.parse(split[1]);
    var daypickupdate = int.parse(split[2]);
    var splitreturndate = returndate.split('-');
    var returnyear = int.parse(splitreturndate[0]);
    var monthreturn = int.parse(splitreturndate[1]);
    var dayreturn = int.parse(splitreturndate[2]);
    final pickupdate1 = DateTime(yearpickup, monthpickup, daypickupdate);
    final returndate1 = DateTime(returnyear, monthreturn, dayreturn);
    final datenow = DateTime.now();

    if (returndate1.isAfter(pickupdate1) && pickupdate1.isAfter(datenow)) {
      final difference = returndate1.difference(pickupdate1).inDays + 1;

      ReservationData.ReservationDaysCount = difference;
      if (OfferDataAvaliable.offername == null ||
          OfferDataAvaliable.offername == 'No ffer') {
        AlertDialogShow(context);
        calculateTotal();
      } else {
        Location(pickuploc);
        setoffers(pickupdate1, returndate1);

        ///    print("ReturN DAte");
      }
    } else {
      if (pickupdate1.isBefore(datenow) || pickupdate1 == datenow) {
        Fluttertoast.showToast(
            msg: "Please Renter PickUp Date",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
      }
      if (returndate1.isBefore(pickupdate1)
          || returndate1 == pickupdate1) {
        Fluttertoast.showToast(
            msg: "Please Renter Return  Date",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
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
          Fluttertoast.showToast(
              msg: "Please rent from  " +
                  OfferDataAvaliable.from_date +
                  " to " +
                  OfferDataAvaliable.to_date +
                  "To Get Specail Price",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0);
        } else {
          AlertDialogShow(context);
          totalsum = totalsum * ReservationData.totaldaysfree;
          totalaftertax = (totalsum * taxamount) + totalsum;
        }
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
            totalsum = totalsum * ReservationData.totaldaysfree;
            totalaftertax = (totalsum * taxamount) + totalsum;

            AlertDialogShow(context);
          } else {
            Fluttertoast.showToast(
                msg: "Please rent from  " +
                    OfferDataAvaliable.from_date +
                    " to " +
                    OfferDataAvaliable.to_date +
                    "To Get Specail Price",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        } else {
          Fluttertoast.showToast(
              msg: "Please Rent Count Of Days  " +
                  OfferDataAvaliable.offerdaycount +
                  "To Get Free Days",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0);
        }

        break;
      case ("discountOffer"):
        print("Discount Offer");
        if (pickupdate.isBefore(offerstardate) ||
            pickupdate.isAfter((offersenddate)) ||
            returndate.isAfter(offersenddate) ||
            returndate.isBefore(offerstardate)) {
          Fluttertoast.showToast(
              msg: "Please rent from  " +
                  OfferDataAvaliable.from_date +
                  " to " +
                  OfferDataAvaliable.to_date +
                  "To Get Discount  Offer",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0);
        } else {
          calculateTotal();
          AlertDialogShow(context);
        }
        break;

      case ("optionOffer"):
        print("Option Offer");
        if (pickupdate.isBefore(offerstardate) ||
            pickupdate.isAfter((offersenddate)) ||
            returndate.isAfter(offersenddate) ||
            returndate.isBefore(offerstardate)) {
          Fluttertoast.showToast(
              msg: "Please rent from  " +
                  OfferDataAvaliable.from_date +
                  " to " +
                  OfferDataAvaliable.to_date +
                  "To Get Option  Offer",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0);
        } else {
          calculateTotal();
          AlertDialogShow(context);
        }
        break;

      case ("fuelOffer"):
        print("Fuel Offer");
        if (pickupdate.isBefore(offerstardate) ||
            pickupdate.isAfter((offersenddate)) ||
            returndate.isAfter(offersenddate) ||
            returndate.isBefore(offerstardate)) {
          Fluttertoast.showToast(
              msg: "Please rent from  " +
                  OfferDataAvaliable.from_date +
                  " to " +
                  OfferDataAvaliable.to_date +
                  "To Get Fuel  Offer",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0);
        } else {
          calculateTotal();
          AlertDialogShow(context);
        }
        break;
    }
  }

  void calculateTotal() {
    try {
      print(totalsum);
      print(ReservationData.ReservationDaysCount);
      totalsum = totalsum * ReservationData.ReservationDaysCount;
      totalaftertax = (totalsum * taxamount) + totalsum;
    } catch (E) {}
  }

  @override
  Widget build(BuildContext context) {
    Data();

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("Make Booking"),
          backgroundColor: Colors.indigo[900],
        ),
//        drawer: Container(
//          child: NavigationDrawer(),
//        ),

        // Not necessary for Option 1

        body: (SingleChildScrollView(
            padding: EdgeInsets.only(left: 10, right: 5, top: 10, bottom: 10),
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
                                      Container(
                                          decoration: (BoxDecoration(
                                              gradient: LinearGradient(
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  colors: [
                                                    Color(0xFF1A237E),
                                                    Color(0xFF283593)
                                                  ]),
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft: Radius.circular(80)))),
                                          width: MediaQuery.of(context).size.width,
                                          height: 150,
                                          child: Column(
                                            children: <Widget>[
                                              Container(child:CurveShape(Icons.person,     ApplicationLocalizations.of(context).translate("Make_Booking"),)),
                                            ],
                                          )),
                                    ])),
                            Container(
                                margin:
                                EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 5),

                                child: Column(children: [
                                  Container(
                                      margin: EdgeInsets.only(
                                          left: 5, right: 5, top: 5, bottom: 5),
                                      width: MediaQuery.of(context).size.width,
                                      decoration: new BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: new BorderRadius.all(
                                            new Radius.circular(10.0)),
                                      ),
                                      child: Row(children: <Widget>[
                                        Container(
                                          decoration: new BoxDecoration(
                                            borderRadius: new BorderRadius.all(
                                                new Radius.circular(1.0)),
                                            color: Colors.indigo[700],
                                          ),
                                          width: 40,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 5, right: 5, top: 10, bottom: 10),
                                            child: SetIcons(
                                              Icons.add_location,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),

                                        Container(
                                          height: 40,
                                          padding: EdgeInsets.only(
                                              left: 2, top: 4, bottom: 4, right: 2),
                                          child: new DropdownButton<String>(
                                            isDense: true,
                                            hint: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 2, left: 2, right: 2, bottom: 2),
                                              child: Container(
                                                width: 200,
                                                child: new Text(
                                                  pickuploc,
                                                  overflow: TextOverflow.clip,
                                                ),
                                              ),
                                            ),
                                            onChanged: (String newValue) {
                                              setState(() {
                                                pickuploc = newValue;
                                                Location(pickuploc);

                                              });
                                            },
                                            items: _myJson.map((item) {
                                              return new DropdownMenuItem<String>(
                                                value: item.toString(),
                                                child: new Text(
                                                  item.toString(),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ])),
                                  Container(
                                      margin: EdgeInsets.only(
                                          top: 5, bottom: 2, left: 5, right: 5),
                                      child: Container(
                                          margin: EdgeInsets.only(top: 5, bottom: 5),
                                          decoration: new BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius: new BorderRadius.all(
                                                new Radius.circular(10.0)),
                                          ),
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                decoration: new BoxDecoration(
                                                  color: Colors.indigo[700],
                                                  borderRadius: new BorderRadius.all(
                                                      new Radius.circular(1.0)),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 10,
                                                      bottom: 10,
                                                      right: 8,
                                                      left: 8),
                                                  child: SetIcons(
                                                    Icons.date_range,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                child: InkWell(
                                                  onTap: () {
                                                    DateTime2(context, 'Pickupdate');
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(
                                                        top: 10,
                                                        left: 5,
                                                        right: 5,
                                                        bottom: 10),
                                                    child: Text(
                                                      pickupdate,
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          color: Colors.grey[600]),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ))),
                                  Container(
                                      margin: EdgeInsets.only(
                                          top: 5, bottom: 2, left: 5, right: 5),
                                      child: Container(
                                          margin: EdgeInsets.only(top: 5, bottom: 5),
                                          decoration: new BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius: new BorderRadius.all(
                                                new Radius.circular(10.0)),
                                          ),
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                decoration: new BoxDecoration(
                                                  color: Colors.indigo[700],
                                                  borderRadius: new BorderRadius.all(
                                                      new Radius.circular(1.0)),
                                                ),
                                                child: Padding(//
                                                  padding: EdgeInsets.only(
                                                      top: 10,
                                                      bottom: 10,
                                                      right: 8,
                                                      left: 8),
                                                  child: SetIcons(
                                                    Icons.date_range,
                                                    color: Colors.white,//
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                child: InkWell(
                                                  onTap: () {
                                                    TimeSelect(context, 'Pickuptime');
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(
                                                        top: 10,
                                                        left: 5,
                                                        right: 5,
                                                        bottom: 10),
                                                    child: Text(
                                                      pickuptime,
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          color: Colors.grey[600]),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ))),
                                  Container(
                                      margin: EdgeInsets.only(
                                          left: 5, right: 5, top: 5, bottom: 5),
                                      width: MediaQuery.of(context).size.width,
                                      decoration: new BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: new BorderRadius.all(
                                            new Radius.circular(10.0)),
                                      ),
                                      child: Row(children: <Widget>[
                                        Container(
                                          decoration: new BoxDecoration(
                                            borderRadius: new BorderRadius.all(
                                                new Radius.circular(1.0)),
                                            color: Colors.indigo[700],
                                          ),
                                          width: 40,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 5, right: 5, top: 10, bottom: 10),
                                            child: SetIcons(
                                              Icons.add_location,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 40,
                                          padding: EdgeInsets.only(
                                              left: 2, top: 4, bottom: 4, right: 2),
                                          child: new DropdownButton<String>(
                                            isDense: true,
                                            hint: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 2, left: 2, right: 2, bottom: 2),
                                              child: Container(
                                                width: 200,
                                                child: new Text(
                                                  returnloc,
                                                  overflow: TextOverflow.clip,
                                                ),
                                              ),
                                            ),
                                            onChanged: (String newValue) {
                                              setState(() {
                                                returnloc = newValue;
                                                ReturnLocation(returnloc);
                                              });},
                                            items: _myJson.map((item) {
                                              return new DropdownMenuItem<String>(
                                                value: item.toString(),
                                                child: new Text(
                                                  item.toString(),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ])),
                                  Container(
                                      margin: EdgeInsets.only(
                                          top: 5, bottom: 2, left: 5, right: 5),
                                      child: Container(
                                          margin: EdgeInsets.only(top: 5, bottom: 5),
                                          decoration: new BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius: new BorderRadius.all(
                                                new Radius.circular(10.0)),
                                          ),
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                decoration: new BoxDecoration(
                                                  color: Colors.indigo[700],
                                                  borderRadius: new BorderRadius.all(
                                                      new Radius.circular(1.0)),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 10,
                                                      bottom: 10,
                                                      right: 8,
                                                      left: 8),
                                                  child: SetIcons(
                                                    Icons.date_range,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                child: InkWell(
                                                  onTap: () {
                                                    DateTime2(context, 'Returndate');
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(
                                                        top: 10,
                                                        left: 5,
                                                        right: 5,
                                                        bottom: 10),
                                                    child: Text(
                                                      returndate,
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          color: Colors.grey[600]),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ))),
                                  Container(
                                      margin: EdgeInsets.only(
                                          top: 5, bottom: 2, left: 5, right: 5),
                                      child: Container(
                                          margin: EdgeInsets.only(top: 5, bottom: 5),
                                          decoration: new BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius: new BorderRadius.all(
                                                new Radius.circular(10.0)),
                                          ),
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                decoration: new BoxDecoration(
                                                  color: Colors.indigo[700],
                                                  borderRadius: new BorderRadius.all(
                                                      new Radius.circular(1.0)),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 10,
                                                      bottom: 10,
                                                      right: 8,
                                                      left: 8),
                                                  child: SetIcons(
                                                    Icons.alarm,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                child: InkWell(
                                                  onTap: () {
                                                    TimeSelect(context, 'ReturnTime');
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(
                                                        top: 10,
                                                        left: 5,
                                                        right: 5,
                                                        bottom: 10),
                                                    child: Text(
                                                      returntime,
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          color: Colors.grey[600]),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ))),
                                  Container(
                                    child: Flight(),
                                  ),
                                  Container(
                                    height: 50,
                                    margin: EdgeInsets.only(bottom: 10, top: 10),
                                    width: 200,
                                    child: RaisedButton(
                                        onPressed: () {
                                          _submitCommand();
                                          // isshowing = true;
                                          // animationButton();
                                        },

//                    if(email.text==''){ print ("Vaild Email");}else{print(email.text);}},
                                        color: Colors.indigo[900],
                                        child: Text(
                                          "Save Changes",
                                          style: TextStyle(
                                              fontSize: 20, color: Colors.white),
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(10.0)),
                                        )),
                                  ),

                                ]))]))]))))));
  }

  Widget Flight() {
    print("Flight Data"+flightdate+"Flight Time"+flighttime+flightnumber);
    if(flightdate=="0000-00-00"){print("Flight Date");setState(() {
      flightdate=   ApplicationLocalizations.of(context).translate("Flight_Time");
    });}
    if(flighttime=="0:0000"){setState(() {
      flighttime=   ApplicationLocalizations.of(context).translate("Flight_Time");
    });}
    if(visairport==false){
      if(flightnumber==null){
        txt.text=    ApplicationLocalizations.of(context).translate("Flight_Number");


      }}
    else{txt.text=flightnumber;}






    if (ReservationData.Airport == true
        ||returntypelocation==true||
        visairport==true) {
      return Column(children: <Widget>[
        Container(
            margin: EdgeInsets.only(top: 5, bottom: 2, left: 5, right: 5),
            child: Container(
                margin: EdgeInsets.only(top: 5, bottom: 5),
                decoration: new BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: new BorderRadius.all
                    (new Radius.circular(10.0)),
                ),
                child: Row(
                  children: <Widget>[
                    Container(
                      decoration: new BoxDecoration(
                        color: Colors.indigo[700],
                        borderRadius:
                        new BorderRadius.all(new Radius.circular(1.0)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 10, bottom: 10, right: 8, left: 8),
                        child: SetIcons(
                          Icons.date_range,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      child: InkWell(
                        onTap: () {
                          DateTime2(context, 'Flight Date');
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 5, right: 5, bottom: 10),
                          child: Text(
                            flightdate,
                            style: TextStyle(
                                fontSize: 17, color: Colors.grey[600]),
                          ),
                        ),
                      ),
                    )
                  ],
                ))),
        Container(
          margin: EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
          decoration: new BoxDecoration(
            color: Colors.grey[200],
            borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
          ),
          child: Row(
            children: <Widget>[
              Container(
                padding:
                EdgeInsets.only(left: 2, right: 5, top: 10, bottom: 10),
                decoration: new BoxDecoration(
                  color: Colors.indigo[600],
                  borderRadius: new BorderRadius.all(new Radius.circular(1.0)),
                ),
                width: 40,
                child: SetIcons(
                  Icons.access_alarm,
                  color: Colors.white,
                ),
              ),
              Container(
                child: InkWell(
                  onTap: () {
                    TimeSelect(context, 'Flight Time');
                  },
                  child: Padding(
                    padding:
                    EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
                    child: Text(
                      flighttime,
                      style: TextStyle(fontSize: 17, color: Colors.grey[600]),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),  Container(
          margin: EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
          decoration: new BoxDecoration(
            color: Colors.grey[200],
            borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
          ),
          child: Row(
              children: <Widget>[
                Container(
                  padding:
                  EdgeInsets.only(left: 2, right: 5, top: 10, bottom: 10),
                  decoration: new BoxDecoration(
                    color: Colors.indigo[600],
                    borderRadius: new BorderRadius.all(new Radius.circular(1.0)),
                  ),
                  width: 40,
                  child: SetIcons(
                    Icons.flight,
                    color: Colors.white,
                  ),
                ),
                Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width / 1.6,
                    child: (Form(key: formKey,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 3, right: 3),
                        child: TextFormField(
                          controller: txt,
                          validator: (val) =>
                          val.length < 1 ? 'Invaild Flight Number' : null,
                          obscureText: false,
                          onSaved: (val) => flightnumber = val,
                          style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Flight Number",
                              filled: false),
                        ),
                      ),
                    )))
              ]),
        ),]);
    }
  }
}