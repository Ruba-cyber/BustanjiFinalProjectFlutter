import 'dart:convert';


import 'package:devicepreview/AppTranslation/AppTranslation.dart';
import 'package:devicepreview/WidthAndHeighTWidget/Size_layout.dart';
import '../CustomerData.dart';
import '../Urls.dart';
import 'Designrespickuplocation.dart';
import 'ReservationDataBooking.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class MyReservation extends StatefulWidget {
  @override
  _ContractListState createState() => _ContractListState();
}

class _ContractListState extends State<MyReservation>

    with SingleTickerProviderStateMixin {
  bool VisReservation;
  Future<List<ReservationDataBooking>> Data() async {
    print("DataPass");
    List<ReservationDataBooking> MyReservations = [];
    MyReservations.clear();
    var url = Urls.mybooking;
    http.Response response =
    await http.post(url,
        body: {'customer_id': CustomerData.customerid});
    print(response.body);
    var Offers = json.decode(response.body);

    for (var u in Offers) {
//   u["car_model_arabic"],
    if(CustomerData.Language=="Arabic"){
      ReservationDataBooking Myres = ReservationDataBooking(
        u["reservation_id"],
        u["pickup_location_arabic"],
        u["return_location_arabic"],
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

    MyReservations.add(Myres);
   }
    else{
      ReservationDataBooking Myres = ReservationDataBooking(
          u["reservation_id"],
          u["pickup_location_english"],
          u["return_location_english"],
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

      MyReservations.add(Myres);
      print("Reservation"+u["reservation_id"]); }}
    print(MyReservations.length);
    if (MyReservations.length == 0) {
      setState(() {
        VisReservation == false;
      });
    }
    else {
      setState(() {
        VisReservation == true;
      });

       }
    return MyReservations;
  }
  Widget build(BuildContext context) {

    return Scaffold(
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        body: (SingleChildScrollView(
            child: Container(
                child: Column(children: <Widget>[
Container(child: MyReservation(),),


        ])))));

//                         return
  }
  Widget MyReservation(){
    if(VisReservation==false){return Container(
      margin:EdgeInsets.only(top: 50,right: 50),child: Text(
      ApplicationLocalizations.of(context).translate("No_Reservation"),
      style: TextStyle(fontSize: 18),),);}
    else{
    return Container(
        child: SafeArea(
          child: Column(children: <Widget>[
            FutureBuilder(
                future: Data(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.data == null) {
                    return Center(
                      child: Container(margin: EdgeInsets.only(top: 10,bottom: 10),
                        child: Center(
                          child: Text(
                            ApplicationLocalizations.of(context).translate("Loading") ,
                            style: TextStyle(fontSize: Size1.Font_size),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Container(
                      width: double.infinity,
                      child: ListView.builder(
                          padding:
                          EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(


                                children: <Widget>[
                                  Container(
                                      child: (Designrespickuplocation(
                                          snapshot, index)))
                                ]);
                          }),
                    );
                  }
                })
          ]),
        ));
  }}}