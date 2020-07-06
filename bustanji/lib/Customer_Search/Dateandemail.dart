import 'dart:convert';
import 'dart:core';

import 'package:devicepreview/AppTranslation/AppTranslation.dart';
import 'package:devicepreview/CustomTexts/Custom_Email_Text.dart';
import 'package:devicepreview/WidthAndHeighTWidget/Size_layout.dart';
import 'package:flutter/material.dart';import 'package:http/http.dart' as http;


import '../CustomerData.dart';
import '../Urls.dart';


import 'ReservationDataBooking.dart';

class Dateandemail extends StatefulWidget {
  @override
  _DateandemailState createState() => _DateandemailState();
}
final formKey = GlobalKey<FormState>();

final teFirstName = TextEditingController();
final teLastName = TextEditingController();
final teEmail = TextEditingController();
final tePassword = TextEditingController();
FocusNode _focusNodeEmail = new FocusNode();
FocusNode _focusNodePass = new FocusNode();
class _DateandemailState extends State<Dateandemail> {
  TextEditingController controller,controller2; String  date='';bool Data1=false;
  @override
  Future<List<ReservationDataBooking>> Data() async {
    print("DataPass");
    List<ReservationDataBooking> Contracts = [];
    Contracts.clear();
    var url = Urls.searchdate;

    http.Response response =
    await http.post(url, body: {'reservationDate': date,'customeremail':
    controller2.text.toString()});
    print(response.body);
    var Offers = json.decode(response.body);

    for (var u in Offers) {
      if (CustomerData.Language == "Arabic") {
        ReservationDataBooking Myres = ReservationDataBooking(
            u["reservation_id"],

            u["pickup_location"],
            u["return_location"],
            u["pickup_date"],
            u["return_date"],
            u["pickup_time"],
            u["return_time"],
            u["flight_date"],
            u["flight_time"],
            u["flight_number"],
            u["price_before_tax"],
            u["total_price_after_tax"],
            u["insurance_status"],
            u["options_status"],
            u["coin"],
            u["car_price_per_day"],
            u["confirmation"],
            u["car_model_arabic"],

            u["car_year"],
            u["car_image"],
            u["passenger"],
            u["luggage"],
            u["doors"],
            u["transmission"],

            u["offer_name"],
            u["red"],
            u["green"],
            u["blue"],
            u["black"],
            u["white"],
            u["silver"],
            u["gold"],
            u["yellow"],
            u["group_id"],
            false);

        Contracts.add(Myres);
      }
      else{  ReservationDataBooking Myres = ReservationDataBooking(
          u["reservation_id"],

          u["pickup_location"],
          u["return_location"],
          u["pickup_date"],
          u["return_date"],
          u["pickup_time"],
          u["return_time"],
          u["flight_date"],
          u["flight_time"],
          u["flight_number"],
          u["price_before_tax"],
          u["total_price_after_tax"],
          u["insurance_status"],
          u["options_status"],
          u["coin"],
          u["car_price_per_day"],
          u["confirmation"],
          u["car_model_english"],
          u["car_year"],
          u["car_image"],
          u["passenger"],
          u["luggage"],
          u["doors"],
          u["transmission"],
          u["offer_name"],
          u["red"],
          u["green"],
          u["blue"],
          u["black"],
          u["white"],
          u["silver"],
          u["gold"],
          u["yellow"],
          u["group_id"],
          false);

      Contracts.add(Myres);
      }
    }
    print(Contracts.length);
    return Contracts;
  } Future<DateTime> DateTime2(BuildContext context) async {
    final DateTime dateTime = await
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1920),
        lastDate: DateTime(DateTime
            .now()
            .year + 2));

    if (dateTime != null) {
      setState(() {
        date = dateTime.year.toString() +
            '-' +
            dateTime.month.toString() +
            '-' +
            dateTime.day.toString();
      controller.text=date;
      });
    }
  }

  Widget build(BuildContext context) {
    date=ApplicationLocalizations.of(context).translate("Date");
    return Scaffold(resizeToAvoidBottomPadding: false,resizeToAvoidBottomInset: false,

        body: SingleChildScrollView(child:
        Column(children: <Widget>[(
            Form(
                key: formKey,
                child: Column(children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.all(
                          new Radius.circular(10.0)),
                      color: Colors.grey[200],
                    ),
                        height:Size1.height_of_container,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  margin: EdgeInsets.all(10),
                  decoration: new BoxDecoration(
                    borderRadius: new BorderRadius.all(
                        new Radius.circular(10.0)),
                    color: Colors.grey[200],
                  ),
                     width:MediaQuery.of(context).size.width,
                      height:Size1.height_of_container,
                  child: FittedBox(fit: BoxFit.scaleDown,
                    child: Row(children: <Widget>[
                    Container(
                    padding: EdgeInsets.only(
                        left: 10, right: 10),
                    child: Icon(
                      Icons.date_range,
                      color: Colors.indigo[900],
                      size: Size1.size_icon,
                    ),
                ),Container( width:Size1.width_text,child: InkWell(child: Text(date,
                        style: TextStyle(fontSize:
                        Size1.Font_size,color: Colors.grey[600],),),   onTap: () {
                        DateTime2(context);
                      },),),


                    ]),
                  ),),),
              Container(width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.all(10),
                    decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.all(
                          new Radius.circular(10.0)),
                      color: Colors.grey[200],
                    ),
                        height:Size1.height_of_container,
                    child:
                    FittedBox(fit:BoxFit.scaleDown,
                      child: Row(children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                              left: 10, right: 10),
                          child: Icon(
                            Icons.email,
                            color: Colors.indigo[900],
                            size: Size1.size_icon,
                          ),
                        ),
                  Container(width: Size1.width_text,
                          child: InkWell(
                            child: Container(
                              child: new CustomEmailText(
                                inputBoxController: teFirstName,
                                focusNod: _focusNodeEmail,
                                textSize: 12.0,
                                textFont: "Nexa_Bold",
                              ).textFieldWithOutPrefix(
                                  ApplicationLocalizations.of(context).translate("Email2"),
                                  ApplicationLocalizations.of(context).translate("Email2")),
                            ),
                          ),
                        ),


                      ]),
                    ),
                  ),
                  Container(
                    width: Size1.width_text,
                    height: Size1.height_of_button,
                    margin: EdgeInsets.fromLTRB(30, 10, 10, 0),
                    child: RaisedButton(
                        onPressed: () {
                          //  print("" + r.text.toString());
                          Data();
                          setState(() {
                            Data1 = true;
                          });
                        },
                        color: Colors.indigo[900],
                        child: Text(
                          ApplicationLocalizations.of(context).translate("search"),
                          style: TextStyle(
                               fontSize: Size1.Font_size,
                              color: Colors.white),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(10.0)),
                        )),
                  ),
//Container(child: List1(),)
          ])))])));

  }
//  Widget List1(){  if(Data1==true){
//  return  Container(child:Wrap( children: <Widget>[
//  Container(child: Wrap( children: <Widget>[
//  FutureBuilder(
//  future: Data(),
//    builder: (BuildContext context,
//    AsyncSnapshot<dynamic> snapshot) {
//    if (snapshot.data == null) {
//    return Center(
//    child: Container(
//    child: Center(
//    child: Text( ApplicationLocalizations.of(context).translate("Loading"),
//
//    style: TextStyle(fontSize: 20),
//    ),
//    ),
//    ),
//    );
//    } else {
//    return Container(margin: EdgeInsets.all(5),
//    child: ListView.builder(
//    physics: NeverScrollableScrollPhysics(),
//    shrinkWrap: true,
//    itemCount: snapshot.data.length,
//    itemBuilder: (BuildContext context, int index) {
//    return Wrap(direction: Axis.vertical,
//
//    spacing: 10,
//    children: <Widget>[
//    Container(child: Material(
//    elevation: 5.0,
//    borderRadius: BorderRadius.all(Radius.circular(5.0)),
//    child: (Designrespickuplocation(
//    snapshot, index)))
//    )  ]);
//    }  ),
//    );}})]))]));}}
}

