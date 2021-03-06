import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:language/AppTranslation/AppTranslation.dart';
import 'package:language/CustomerInfo/CustomerData.dart';
import 'package:language/Urls/BustanjiUrl.dart';

import 'ContractData.dart';

import 'package:http/http.dart' as http;

import 'Contracts.dart';

class ContractList extends StatefulWidget {
  @override
  _ContractListState createState() => _ContractListState();
}

class _ContractListState extends State<ContractList> {
  bool VisContracts=true;
  @override
  Future<List<ContractData>> Data() async {
    print("DataPass");
    List<ContractData> Contracts = [];
    Contracts.clear();
    var url = BustanjiUrls.contractdata;

    http.Response response = await http
        .post(url, body: {'customer_id': CustomerData.customerid});
print(response.body);
    var Offers = json.decode(response.body);

    for (var u in Offers) {
      print(   u["passenger"],);
      ContractData contractData = ContractData(
        u["reservation_id"],
        u["car_model_english"],
        u["car_model_arabic"],
        u["car_year"],
        u["luggage"],
        u["date_contract_start"],
        u["date_contract_end"],
        u["price_before_payment"],
        u["car_image"],u["passenger"],
        u["doors"],u["reservation_status"],u["transmission"],
        u["car_price_per_day"],u["coin"],
      );

      Contracts.add(contractData);
    }
    print(Contracts.length);
    if(Contracts.length==0){
      setState(() {
        VisContracts=false;
      });
    }
    return Contracts;

  }
  Widget build(BuildContext context) {


Data();
    return Scaffold(

        resizeToAvoidBottomInset: false,
        body: (SingleChildScrollView(
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(child: Contract(),),
])))));
  }
  Widget Contract(){

    if(VisContracts==false){
      return Container( margin:EdgeInsets.only(top: 50,bottom: 50),child: Center(child: Text(  ApplicationLocalizations.of(context).translate("No_Contracts"),style: TextStyle(fontSize: 20,color: Colors.black),),),);
    }
    else{

      return Container(  child: Column(
        children: <Widget>[

       Container(
              child: FutureBuilder(
                  future: Data(),
                  builder: (BuildContext context,
                      AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.data == null) {
                      return Container(margin: EdgeInsets.all(25),
                        child: Center(
                          child: Text(
                              ApplicationLocalizations.of(context).translate("Loading"),
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          print(snapshot.data[index].passanger1);
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            height: 430,
                            child: Contracts(snapshot,index),
                            padding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 6),
                          );
                        },
                      );
                    }
                  }))
        ],
      ),
    );
  }}
}
