import 'package:devicepreview/AppTranslation/AppTranslation.dart';
import 'package:devicepreview/ReservationInformationDesign/ReservationInfo.dart';
import 'package:devicepreview/WidthAndHeighTWidget/Size_layout.dart';
import 'package:flutter/material.dart';


class Contracts extends StatefulWidget {
  AsyncSnapshot snapshot;
  int index;

  Contracts(this.snapshot, this.index) {}

  @override
  _ContractsState createState() => _ContractsState(this.snapshot, this.index);
}

class _ContractsState extends State<Contracts> {
  AsyncSnapshot snapshot;
  String status;
  int index;

  _ContractsState(this.snapshot, this.index) {
   print("rrsrsw"+snapshot.data[index].resstatus );


  }
void setstatus(){

   if (snapshot.data[index].resstatus == "show") {
     status= ApplicationLocalizations.of(context).translate("TheـContractـCompleted");
   } else {
     if (snapshot.data[index].resstatus == "End") {
       status =ApplicationLocalizations.of(context).translate("ContractـEnded");
     }

}
  print("Contract s"+status);}


    //print("Status"+status);


  @override
  Widget build(BuildContext context) {
     setstatus();

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body:
          Container(

              margin: EdgeInsets.only(left: 10, right: 10),
              child: Material(
                  elevation: 10,
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  color: Colors.white,
                  child: Container(
                    child: Container(
                      child: Column(children: <Widget>[
                        Container(
                            margin: EdgeInsets.only(
                                left: 5, right: 5, top: 10, bottom: 10),
                            child: (ResrevationInfo(
                              ApplicationLocalizations.of(context).translate("StartـContractـDate"),
                                snapshot.data[index].datestart))),
                        Container(
                            margin: EdgeInsets.only(
                                left: 5, right: 5, top: 10, bottom: 10),
                            child: (ResrevationInfo(
                              ApplicationLocalizations.of(context).translate("Ended_Contract_Date"),
                                snapshot.data[index].dateend))),

                        Container(
                            margin: EdgeInsets.only(
                                left: 5, right: 5, top: 10, bottom: 10),
                            child: (ResrevationInfo(
                              ApplicationLocalizations.of(context).translate("Total_All_Price"),

                              snapshot.data[index].price_before_payment +' '+snapshot.data[index].coin,))),
                        Container(
                            margin: EdgeInsets.only(
                                left: 5, right: 5, top: 10, bottom: 10),
                            child: (ResrevationInfo(
                            ApplicationLocalizations.of(context).translate("Reservation_Status"),
                              ""+status))),

Container(child: CarDesign(),),

                  ]))))),
        );
  }
  Widget CarDesign(){
    return Container(
        width:double.infinity *2,
        margin:
        EdgeInsets.only(top: 30, left: 5, right: 5),
//        child: Material(
//          elevation: 5.0,
//          borderRadius:
//          BorderRadius.all(Radius.circular(10.0)),
        color: Colors.white,
        child: FittedBox(
          child: SafeArea(

            child: Row(children: <Widget>[
              Container(
                child: Column(
                    crossAxisAlignment:CrossAxisAlignment.start,children: <Widget>[
                  Container(
                      padding: EdgeInsets.only(
                          bottom: 10, top: 10, left: 10),
                      child: Image.network(
                        snapshot.data[index].carimage,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width /
                            3.4,
                        height:  MediaQuery
                            .of(context)
                            .size
                            .width /
                            6.4,
                      )),
                  Container(margin: EdgeInsets.only(left: 10,right: 10),
                      child:
                      FittedBox(fit: BoxFit.scaleDown,

                        child: Row(children: <Widget>[
                          Container(
                            //padding: (EdgeInsets.all(2)),
                            child: FittedBox(fit: BoxFit.scaleDown ,
                              child: Row(children: <Widget>[
                                Container(
                                  width: Size1.size_icon ,
                                  padding: EdgeInsets.all(2),
                                  child: Icon(Icons.person),
                                ),
                                Container(
                                  width: Size1.size_icon,
                                  padding: EdgeInsets.all(5),
                                  child: Text(
                                     snapshot.data[index].passanger1),
                                ),
                              ]),
                            ),
                          ),
                          Container(
                            child: Row(children: <Widget>[
                              Container(

                                padding: EdgeInsets.all(4),
                                child: Image.network(
                                  "https://encrypted-tbn0.gstatic.com/"
                                      "images?q=tbn%3AANd9GcRAnSdWWPCYXS1jmDaF_VhIPJR81UVTCZFNL1H3yByIAxd4vwx7",
                                  width: Size1.size_icon , ),
                              ),
                              Container(
                                width: Size1.size_icon,
                                padding: EdgeInsets.all(5),
                                child:
                                Text(
                                  snapshot.data[index].carluugage),
                              ),
                            ]),
                          ),
                        ]),
                      )),

                  Container(margin: EdgeInsets.only(left: 10,right: 10),
                    child: Row(children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(2),
                        child: Image.network(
                          "https://3.imimg.com/data3/VT/QG/GLADMIN-140882/car-door-250x250.jpg",width: Size1.size_icon *5,),
                        width: Size1.size_icon,  ),
                      Container(
                        width: Size1.size_icon,
                        padding: EdgeInsets.all(5),
                        child: Text(snapshot.data[index].doors,
                            style:TextStyle( fontSize:Size1.Font_size,)),
                      ),
                      Container(
                        width:80,
                        padding: EdgeInsets.only(left: 15,right: 15),
                        child: Text(snapshot.data[index].caryear,
                          style: TextStyle(fontSize: Size1.Font_size),
                        ),
                      ),
                    ]),
                  ),

                ]),
              ),
              Container(margin: EdgeInsets.only(left: 30,right: 30),
                  child: Column(
                      crossAxisAlignment:CrossAxisAlignment.start,
                      children: <Widget>[

                        Container(
                          padding: EdgeInsets.only(
                              left: 10, right: 10, top: 10),
                          child: Text(
                            snapshot.data[index].carnameen,
                            style: TextStyle(
                                fontSize: Size1.Font_size,
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: 10, right: 10, top: 0),
                          child: Text( snapshot.data[index].transmiision,
                            style: TextStyle(
                                fontSize: Size1.Font_size,
                                color: Colors.black),
                          ),
                        ),


                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                          snapshot.data[index].carpriceday +' '+snapshot.data[index].coin,

                            style: TextStyle(
                                fontSize: Size1.Font_size,
                                color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                        ),


                      ])),
            ]),
          ),
        ));
    //));
  }
}
