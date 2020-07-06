
import 'package:devicepreview/AppTranslation/AppTranslation.dart';
import 'package:devicepreview/CustomDesign/CurveShape.dart';
import 'package:devicepreview/CustomDesign/Icons.dart';
import 'package:devicepreview/CustomTexts/CustomText.dart';
import 'package:devicepreview/WidthAndHeighTWidget/Size_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';



import '../OfferDataAvaliable.dart';
import '../ReservationData.dart';
import '../Urls.dart';
import 'MyBooking.dart';


class UpdateReservationLocations extends StatefulWidget {
  String pickuploc,
      pickupdate,
      returndate,
      returnloc,
      resid,offername,
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
      this.offername,
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
      this.confirmation,this.offername,
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
      resid,offername,
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

  FocusNode _focusNumber = new FocusNode();

  _HomePageState(
      this.resid,
      this.confirmation,
      this.offername,
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
    print("SHeo");
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text(ApplicationLocalizations.of(context).translate("Alert")),
              content: Text(ApplicationLocalizations.of(context).translate("Are_You_sure_want_to_change")),
              actions: <Widget>[
                Row(children: <Widget>[
                  MaterialButton(
                      elevation: 5.0,
                      onPressed: () {
                        UpdateReservation();
                      },
                      child: Text(ApplicationLocalizations.of(context).translate("ok"))),
                  MaterialButton(
                    elevation: 5.0,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(ApplicationLocalizations.of(context).translate("Cancel")),
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
    var url = Urls.updatelocation;

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
      Fluttertoast.showToast(
          msg: "Reservation Updated",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    }
//if(checkemail=="1"){
//      _loginCommand();
  }

  Future<String> Location(String pickuploction) async {
    var url = await http.get(Urls.searchlocation);
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
    var url = await http.get(Urls.searchlocation);
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

  AlertDialogWarning(BuildContext context, String error) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text(ApplicationLocalizations.of(context).translate("Warning")),
              content: Text(error),
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
              ]);
        });
  }





  List<String> _myJson = [];
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool move = false;

  void _submitCommand() {
  print("DJDD");
    if (ReservationData.Airport == true||returntypelocation==true) {
      var splitreturndate = ReservationData.returndate.split('-');
      var split = ReservationData.pickupdate.split('-');
      var yearreturndate = int.parse(splitreturndate[0]);
      var monthreturn = int.parse(splitreturndate[1]);
      var returnday = int.parse(splitreturndate[2]);
      var yearpickup = int.parse(split[0]);
      var monthpickup = int.parse(split[1]);
      var daypickupdate = int.parse(split[2]);
      var splitflightdate = ReservationData.FlightDate.split('-');
      var flightyear = int.parse(splitflightdate[0]);
      var monthflight = int.parse(splitflightdate[1]);
      var flightday = int.parse(splitflightdate[2]);
      final pickupdate = DateTime(yearpickup, monthpickup, daypickupdate);
      final returndate = DateTime(yearreturndate, monthreturn, returnday);
      final flightdate = DateTime(flightyear, monthflight, flightday);
      if (flightdate != null && flighttime != null && txt.text != null) {
        if (ReservationData.pickuploc.contains("Aireport")) {
          if (pickupdate.isAfter(flightdate) && flightdate.isBefore(returndate)) {
            Move();
          }
        }

      }
      else {
        if (txt.text == null) {

        } else if (flightdate == null) {
          AlertDialogWarning(
              context,
              ApplicationLocalizations.of(context).translate("Please_Enter_Flight_Date") );


        }

      }
    } else {
      print("S1");
      Move();
    }
  }

//   }   } else {

  void Move() {
    print("s2");
    if (pickupdate != null &&
        pickuptime != null &&
        pickuploc != null &&
        returndate != null &&
        returnloc != null &&
        returntime != null) {
      SetDate();
    } else {
      if (pickuploc == null) {
        AlertDialogWarning(
            context,
            ApplicationLocalizations.of(context).translate("Please_Enter_pickup_Location") );

      }

      if (returnloc == null) {
        AlertDialogWarning(
            context,
            ApplicationLocalizations.of(context).translate("Please_Enter_Return_Location")
        );
      }

      if (pickuptime == null) {
        AlertDialogWarning(
            context,
            ApplicationLocalizations.of(context).translate("Please_Enter_Pickup_Time") );

      }

      if (returntime == null) {
        AlertDialogWarning(
            context,
            ApplicationLocalizations.of(context).translate("Please_Enter_Return_Time") );}



      if (ReservationData.returndate == null) {
        AlertDialogWarning(
            context,
            ApplicationLocalizations.of(context).translate("Please_Enter_Return_Date"));
      }

      if (ReservationData.pickupdate == null) {
        AlertDialogWarning(
            context,
            ApplicationLocalizations.of(context).translate("Please_Enter_PickupDate"));

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


         String  txttime=''+dateTime.format(context);
          if(txttime.contains('ص')){setState(() {txttime= dateTime.hour.toString() + ':' + dateTime.minute.toString() +'am';});}
          else {
            if (txttime.contains('م')) {
              setState(() {
                txttime =
                    dateTime.hour.toString() + ':' + dateTime.minute.toString() +
                        'pm';

            });
          }
        switch(pickuptimestate){

          case("Pick Up Time"):  pickuptime = '' + txttime;break;
          case("Return Time"):    returntime = '' + txttime;break;
          case("Flight Time"): flighttime = '' + txttime;break;
        }

        // txttime=''+dateTime.hour.toString()+':'+dateTime.minute.toString();
      }});
    }
  }

  Future<List<String>> Data() async {
    print(ReservationData.colorblue);
    var url = await http.get(Urls.getlocation);
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
    print("S3");
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
      if (OfferDataAvaliable.offername == 'normal') {
        AlertDialogShow(context);
        calculateTotal();
      } else {
       if(offername!='normal'){
      print("You Can't Change");
        ///    print("ReturN DAte");
      }
      }
    } else {
      if (pickupdate1.isBefore(datenow) || pickupdate1 == datenow) {
        AlertDialogWarning(
            context,
            ApplicationLocalizations.of(context).translate("Can't_Reserve_less_than_one_day") );
      }
      if (returndate1.isBefore(pickupdate1)
          || returndate1 == pickupdate1) {
        AlertDialogWarning(
            context,
            ApplicationLocalizations.of(context).translate("Can't_Reserve_in_same_day") );
      }
    }
  }

  void calculateTotal() {
    print("Calculate");
    try {
      print(totalsum);
      print(ReservationData.ReservationDaysCount);
      totalsum = totalsum * ReservationData.ReservationDaysCount;
      totalaftertax = (totalsum * taxamount) + totalsum;
    } catch (E) {}
  }
  Future<bool> _onWillPop() async {
    return (
        await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MyBooking(),
            )));

  }
  @override
  Widget build(BuildContext context) {
    Data();

    return WillPopScope(onWillPop: _onWillPop,
      child: Scaffold(

          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text(" "),
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
                      child: Column(children: <Widget>[
                      Container(
                      child: Column( mainAxisAlignment: MainAxisAlignment.spaceAround,children: <Widget>[
                        Container(
                            child: CurveShape(
                              Icons.person,
                              ApplicationLocalizations.of(context).translate("Make_Booking"),
                            )),



      Container(
      margin:
      EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 5),

      child: Column(children: [
      Container(
      margin: EdgeInsets.only(
      left: 5, right: 5, top: 5, bottom: 5),
      width: double.infinity,
      decoration: new BoxDecoration(
      color: Colors.grey[200],
      borderRadius: new BorderRadius.all(
      new Radius.circular(10.0)),
      ),
      child: FittedBox(
        child: Row(children: <Widget>[
SetIcons(Icons.add_location),
        Container(

        padding: EdgeInsets.only(
        left: 2, top: 4, bottom: 4, right: 2),
        child: new DropdownButton<String>(
        isDense: true,
        hint: Padding(
        padding: const EdgeInsets.only(
         left: 5, right: 5),
        child: Container(
        width: Size1.width_text ,
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
        ]),
      )),


      Container(width: double.infinity,
      margin: EdgeInsets.only(top: 5, bottom: 5,left: 5,right: 5),
      decoration: new BoxDecoration(
      color: Colors.grey[200],
      borderRadius: new BorderRadius.all(
      new Radius.circular(10.0)),
      ),
      child: FittedBox(
        child: Row(
        children: <Widget>[



 SetIcons(
        Icons.date_range,
        color: Colors.white,
        ),


        Container(width: Size1.width_text ,
        child: InkWell(
        onTap: () {
        DateTime2(context, 'Pickupdate');
        },
        child: Padding(
        padding: const EdgeInsets.only(
        top: 10,
        left: 3,
        right:3,
        bottom: 10),
        child: Text(
        pickupdate,
        style: TextStyle(
        fontSize: Size1.Font_size,
        color: Colors.grey[600]),
        ),
        ),
        ),
        ),
]),
      )),
      Container(width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(
      top: 5, bottom: 2, left: 5, right: 5),
      child: Container(
      margin: EdgeInsets.only(top: 5, bottom: 5),
      decoration: new BoxDecoration(
      color: Colors.grey[200],
      borderRadius: new BorderRadius.all(
      new Radius.circular(10.0)),
      ),
      child: FittedBox(
        child: Row(
        children: <Widget>[

   SetIcons(
        Icons.access_alarm,
        color: Colors.white,//


        ),
        Container(width: Size1.width_text,
        child: InkWell(
        onTap: () {
        TimeSelect(context, 'Pickuptime');
        },

        child: Padding(
          padding: const EdgeInsets.only(left: 5,right: 5),
          child: Text(
          pickuptime,
          style: TextStyle(
 fontSize: Size1.Font_size,color: Colors.grey[600]),
          ),
        ),
        ),
        ),

        ],
        ),
      ))),
      Container(
      margin: EdgeInsets.only(
      left: 5, right: 5, top: 5, bottom: 5),
      width: double.infinity,
      decoration: new BoxDecoration(
      color: Colors.grey[200],
      borderRadius: new BorderRadius.all(
      new Radius.circular(10.0)),
      ),
      child: FittedBox(
        child: Row(children: <Widget>[
        Container(

        child: SetIcons(
        Icons.add_location,
        color: Colors.white,
        ),

        ),
        Container(


        child: new DropdownButton<String>(
        isDense: true,
        hint: Padding(
        padding: const EdgeInsets.only(
         left: 5, right: 5,),
        child: Container(
        width: Size1.width_text ,
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
        ]),
      )),
      Container(width: double.infinity,
margin: EdgeInsets.only(top: 5,bottom: 5,left:5,right: 5),
      child: Container(

      decoration: new BoxDecoration(
      color: Colors.grey[200],
      borderRadius: new BorderRadius.all(
      new Radius.circular(10.0)),
      ),
      child:
      FittedBox(
        child: Row(
        children: <Widget>[

SetIcons(
        Icons.date_range,
        color: Colors.white,
        ),


        Container(width:Size1.width_text,
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
 fontSize: Size1.Font_size,color: Colors.grey[600]),
        ),
        ),
        ),
        )
        ],
        ),
      ))),
      Container(width:MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(
      top: 5, bottom: 2, left: 5, right: 5),
      child: Container(

      decoration: new BoxDecoration(
      color: Colors.grey[200],
      borderRadius: new BorderRadius.all(
      new Radius.circular(10.0)),
      ),
      child: FittedBox(
        child: Row(
        children: <Widget>[
  Container(child:
   SetIcons(
        Icons.alarm,
        color: Colors.white,
        ),

        ),
        Container(width: Size1.width_text,
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
 fontSize: Size1.Font_size,color: Colors.grey[600]),
        ),
        ),
        ),
        )
        ],
        ),
      ))),
      Container(
      child: Flight(),
      ),
      Container(
      height: 50,
      margin: EdgeInsets.only(bottom: 10, top: 10),
      width: Size1.width_text*0.7,
      child: RaisedButton(
      onPressed: () {
      _submitCommand();
      // isshowing = true;
      // animationButton();
      },

//                    if(email.text==''){ print ("Vaild Email");}else{print(email.text);}},
      color: Colors.indigo[900],
      child: Text("Sva",

      style: TextStyle(
      fontSize: Size1.Font_size, color: Colors.white),
      ),
      shape: RoundedRectangleBorder(
      borderRadius:
      BorderRadius.all(Radius.circular(10.0)),
      )),
      ),

      ]))]))]))]))])))))),
    );
  }

  Widget Flight() {
    print("Flight Data"+flightdate+"Flight Time"+flighttime+flightnumber);
    if(flightdate=="0000-00-00"){print("Flight Date");setState(() {
      flightdate=ApplicationLocalizations.of(context).translate("Flight_Date");
    });}
    if(flighttime=="0000"){setState(() {
      flighttime=ApplicationLocalizations.of(context).translate("Flight_Time");
    });}
    if(visairport==false){
      if(flightnumber==null){
        txt.text= ApplicationLocalizations.of(context).translate("Flight_Number");


      }}
    else{txt.text=flightnumber;}






    if (ReservationData.Airport == true
        ||returntypelocation==true||
        visairport==true) {
      return Column(children: <Widget>[
        Container(
            margin: EdgeInsets.only(top: 5, bottom: 2, left: 5, right: 5),
            child: Container(width: double.infinity,
                margin: EdgeInsets.only(top: 5, bottom: 5),
                decoration: new BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: new BorderRadius.all
                    (new Radius.circular(10.0)),
                ),
                child: FittedBox(
                  child: Row(
                    children: <Widget>[


                      SetIcons(
                            Icons.date_range,
                            color: Colors.white,

                        ),

                      Container(width: Size1.width_text,
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
                                  fontSize: Size1.Font_size, color: Colors.grey[600]),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ))),
        Container(width: double.infinity,
          margin: EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
          decoration: new BoxDecoration(
            color: Colors.grey[200],
            borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
          ),
          child:
          FittedBox(
            child: Row(
              children: <Widget>[

                   SetIcons(
                    Icons.access_alarm,
                    color: Colors.white,
                  ),
                Container(width: Size1.width_text,
                  child: InkWell(
                    onTap: () {
                      TimeSelect(context, 'Flight Time');
                    },
                    child: Padding(
                      padding:
                      EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
                      child: Text(
                        flighttime,
                        style: TextStyle(fontSize: Size1.Font_size, color: Colors.grey[600]),
                      )
                    ),
                  ),
                )
              ],
            ),
          ),
        ),  Container(width: MediaQuery.of(context).size.width,
    margin: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
    decoration: new BoxDecoration(
    color: Colors.grey[200],
    borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
    ),

    child: FittedBox(
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
    )),])
  ;





    }
  }
}