import 'dart:convert';

import 'package:devicepreview/WidthAndHeighTWidget/Size_layout.dart';
import 'package:devicepreview/AppTranslation/AppTranslation.dart';
import 'package:devicepreview/CustomTexts/CustomText.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../CustomerData.dart';
import '../Urls.dart';

import 'ReservationDataBooking.dart';
class NameSearch extends StatefulWidget {
  @override
  _NameState createState() => _NameState();
}
final formKey = GlobalKey<FormState>();
TextEditingController controller,controller2;bool Data1=false;
FocusNode _focusNodePass = new FocusNode();
FocusNode _focusNodeEmail = new FocusNode();
Future<List<ReservationDataBooking>> Data() async {
  print("DataPass");
  List<ReservationDataBooking> Contracts = [];
  Contracts.clear();
  var url = Urls.searchresname;

  http.Response response =
  await http.post(url, body: {'customerName': controller.text.toString(),'reservationNumber':
  controller2.text.toString()});
  print(response.body);
  var Offers = json.decode(response.body);

  for (var u in Offers) {
    if(CustomerData.Language=="Arabic"){ ReservationDataBooking Myres = ReservationDataBooking(u["reservation_id"],
        u["pickup_location"],
        u["return_location"],
        u["pickup_date"],
        u["return_date"],u["pickup_time"],u["return_time"],
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
        u["doors"],  u["transmission"],
        u["offer_name"],
        u["red"],
        u["green"],
        u["blue"],
        u["black"],
        u["white"],
        u["silver"],
        u["gold"],
        u["yellow"],
        u["group_id"],false);

    Contracts.add(Myres);}
    ReservationDataBooking Myres = ReservationDataBooking(u["reservation_id"],
        u["pickup_location"],
        u["return_location"],
        u["pickup_date"],
        u["return_date"],u["pickup_time"],u["return_time"],
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
        u["doors"],  u["transmission"],
        u["offer_name"],
        u["red"],
        u["green"],
        u["blue"],
        u["black"],
        u["white"],
        u["silver"],
        u["gold"],
        u["yellow"],
        u["group_id"],false);

    Contracts.add(Myres);
  }

  print(Contracts.length);
  return Contracts;
}
class _NameState extends State<NameSearch> {

  FocusNode _focusNodeFirstName = new FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false, resizeToAvoidBottomInset: false,

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
                    width: MediaQuery.of(context).size.width,
                    height: Size1.height_of_container,
                    child: FittedBox(fit: BoxFit.scaleDown,
                      child: Row(children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                              left: 10, right: 10),
                          child: Icon(
                            Icons.format_list_numbered,
                            color: Colors.indigo[900],
                            size: Size1.size_icon,
                          ),
                        ), Container(width: Size1.width_text,
                          child: CustomText(
                            inputBoxController: controller,
                            focusNod: _focusNodePass,
                            textSize: 12.0,
                            textFont: "Nexa_Bold",
                          ).textFieldWithOutPrefix(
                              ApplicationLocalizations.of(context).translate(
                                  "Resid"),
                              ApplicationLocalizations.of(context).translate(
                                  "Resid"), context),
                        ),

                      ]),
                    ),

                  ), Container(
                    margin: EdgeInsets.all(10),
                    decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.all(
                          new Radius.circular(10.0)),
                      color: Colors.grey[200],
                    ),
                    height: Size1.height_of_container,
                    width: MediaQuery.of(context).size.width,
                    child: Container(

                      decoration: new BoxDecoration(
                        borderRadius: new BorderRadius.all(
                            new Radius.circular(10.0)),
                        color: Colors.grey[200],
                      ),
                      height:Size1.size_icon,
                      child: FittedBox(fit: BoxFit.scaleDown,
                        child: Row(children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(
                                left: 10, right: 10),
                            child: Icon(
                              Icons.person,
                              color: Colors.indigo[900],
                              size:  Size1.size_icon,
                            ),
                          ),
                          Container(width: Size1.width_text,
                            child: CustomText(
                              inputBoxController: controller,
                              focusNod: _focusNodeEmail,
                              textSize: 12.0,
                              textFont: "Nexa_Bold",
                            ).textFieldWithOutPrefix(
                                ApplicationLocalizations.of(context).translate(
                                    "Name"),
                                ApplicationLocalizations.of(context).translate(
                                    "Name"), context),
                          ),
                        ]),
                      ),
                    ),
                  ),
                  Container(
                    height:Size1.height_of_button,
                    width: Size1.width_text,
                    margin: EdgeInsets.fromLTRB(30, 0, 10, 0),
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
                          ApplicationLocalizations.of(context).translate(
                              "search"),
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(10.0)),
                        )),
                  ),


                  //   Container(child: List1()),
                ])))
        ])));
  }
//Widget List1(){ if(Data1==true){
//    return Container(child :Wrap( children: <Widget>[
//    Container(child: Wrap( children: <Widget>[
//    FutureBuilder(
//    future: Data(),
//    builder: (BuildContext context,
//    AsyncSnapshot<dynamic> snapshot) {
//    if (snapshot.data == null) {
//    return Center(
//    child: Container(
//    child: Center(
//    child: Text(
//      ApplicationLocalizations.of(context).translate("Loading") ,
//    style: TextStyle(fontSize: 20),
//    ),
//    ),
//    ),
//    );}}));}
////    } else {
//////    return Container(margin: EdgeInsets.all(5),
//////    child: ListView.builder(
//////    physics: NeverScrollableScrollPhysics(),
//////    shrinkWrap: true,
//////    itemCount: snapshot.data.length,
//////    itemBuilder: (BuildContext context, int index) {
//////    return Wrap(direction: Axis.vertical,
//////
//////    spacing: 10,
//////    children: <Widget>[
//////    Container(child: Material(
//////    elevation: 5.0,
//////    borderRadius: BorderRadius.all(Radius.circular(5.0)),
//////    child: (Designrespickuplocation(
//////    snapshot, index)))
//////    )  ]);
////    }  ),
////    );}})]))]));
//


}