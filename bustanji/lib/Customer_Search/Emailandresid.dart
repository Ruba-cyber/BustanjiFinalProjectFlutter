import 'dart:convert';
import 'package:devicepreview/AppTranslation/AppTranslation.dart';
import 'package:devicepreview/CustomTexts/CustomText.dart';
import 'package:devicepreview/CustomTexts/Custom_Email_Text.dart';
import 'package:devicepreview/WidthAndHeighTWidget/Size_layout.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../CustomerData.dart';
import '../Urls.dart';

import 'ReservationDataBooking.dart';
class Emailandresid extends StatefulWidget {
  @override
  _EmailandresidState createState() => _EmailandresidState();
}

class _EmailandresidState extends State<Emailandresid> {
  final formKey = GlobalKey<FormState>();
  String _email;
  TextEditingController
  Temaill = new TextEditingController();
  TextEditingController Tresid = new TextEditingController();

  FocusNode _focusresid = new FocusNode();
  FocusNode _focusDate = new FocusNode();
  bool Data1 = false;

  Future<String> emailandresid() {

  }

  Future<List<ReservationDataBooking>> Data() async {


    List<ReservationDataBooking> Contracts = [];
    Contracts.clear();
    var url =   Urls.searchemail;

    http.Response response =
    await http.post(url,
        body: {'customeremail': Temaill.text.toString(), 'reservationNumber':
        Tresid.text.toString()});
    print(response.body);
    var Offers = json.decode(response.body);

    for (var u in Offers) {
      if(CustomerData.Language=="Arabic"){}
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
          u["group_id"],false);

      Contracts.add(Myres);
    }

    return Contracts;
  }

  final teEmail = TextEditingController();
  final te = TextEditingController();
  FocusNode _focusNodeEmail = new FocusNode();
  FocusNode focusresid = new FocusNode();
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
                  width:MediaQuery.of(context).size.width,
                   height:Size1.height_of_container,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
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

                            Container(width:Size1.width_text,
                              child: CustomEmailText(
                                  inputBoxController: Temaill,
                                  focusNod:_focusNodeEmail ,
                                  textSize: 12.0,
                                  textFont: "Nexa_Bold",
                                ).textFieldWithOutPrefix(
                                    ApplicationLocalizations.of(context).translate("Email2"),
                                    ApplicationLocalizations.of(context).translate("Email2")),
                            ),
                      ]),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(3),
                    decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.all(
                          new Radius.circular(10.0)),
                      color: Colors.grey[200],
                    ),
                    height:Size1.height_of_container,
                   width:MediaQuery.of(context).size.width,
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
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(width:Size1.width_text,
                            child: CustomText(
                              inputBoxController: Tresid,
                              focusNod:_focusresid ,
                              textSize: 12.0,
                              textFont: "Nexa_Bold",
                            ).textFieldWithOutPrefix(
                                ApplicationLocalizations.of(context).translate("Resid"),
                                ApplicationLocalizations.of(context).translate("Resid"),
                                context),
                          ),
                        ),
                      ]),
                    ),
                  ), Container(
                    width: Size1.width_text,height: Size1.height_of_button,
                    margin: EdgeInsets.fromLTRB(30, 0, 10, 0),
                    child: RaisedButton(
                        onPressed: () {
                          print("" + Tresid.text.toString());
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
                ])))])));
    //   Container(child: List1(),) ])));
  }

//  Widget List1() {
//    if (Data1 == true) {
//    return Container(child: Wrap(children: <Widget>[
//    Container(child: Wrap(children: <Widget>[
//    FutureBuilder(
//    future: Data(),
//    builder: (BuildContext context,
//    AsyncSnapshot<dynamic> snapshot) {
//    if (snapshot.data == null) {
//    return Center(
//    child: Container(
//    child: Center(
//    child: Text(
//    ApplicationLocalizations.of(context).translate(""),
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
//    borderRadius: BorderRadius.all(
//    Radius.circular(5.0)),
//    child: (Designrespickuplocation(
//    snapshot, index)))
//    )
//    ]);
//    }),
//    );
//    }
//    })
//    ]))
      //]));
    }
