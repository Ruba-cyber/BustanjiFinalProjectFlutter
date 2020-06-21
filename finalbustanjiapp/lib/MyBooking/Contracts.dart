import 'package:flutter/material.dart';
class Contracts extends StatefulWidget {
  AsyncSnapshot snapshot;
  int index;

  Contracts(this.snapshot, this.index) {}

  @override
  _ContractsState createState() => _ContractsState(this.snapshot, this.index);
}

class _ContractsState extends State<Contracts> {
  AsyncSnapshot snapshot;String status;
  int index;

  _ContractsState(this.snapshot, this.index) {
    print("oo");
    if(snapshot.data[index].resstatus=="show"){status="The Contract Completed";}else{
      if(snapshot.data[index].resstatus=="End"){status="The Contract Ended";}}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
            height: 800,
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Material(
                elevation: 10,
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                color: Colors.white,
                child: Container(
                  child: Container(
                    child: Column(children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            Container(
                                width: 220,
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  "Reservation Number:",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                )),
                            Container(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  snapshot.data[index].resid,
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                )),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: <Widget>[
                            Container(width: 220,
                                child: Text(
                                  "Start Contract Date: ",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                )),
                            Container(
                                child: Text(
                              snapshot.data[index].datestart,
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            )),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: <Widget>[
                            Container(
                                width: 220,
                                child: Text(
                                  " End  Contract Date: ",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                )),
                            Container(
                                child: Text(
                              snapshot.data[index].dateend,
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            )),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: <Widget>[
                            Container(
                                width: 220,
                                child: Text(
                                  "Total Price : ",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                )),
                            Container(
                                child: Text(
                              snapshot.data[index].price_before_payment,
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            )),
                          ],
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: <Widget>[
                              Container(
                                  width: 220,
                                  child: Text(
                                    "Reservation Status :",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )),
                              Container(
                                  child: Text(
                              status,
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black),
                              )),
                            ],
                          )),
                      Container(
                        margin: EdgeInsets.only(left: 5, right: 5),
                        child: Material(
                            elevation: 0.0,
                            borderRadius:
                                BorderRadius.all(Radius.circular(0.0)),
                            color: Colors.white,
                            child: Row(children: <Widget>[
                              Container(
                                child: Column(children: <Widget>[
                                  Container(
                                      padding: EdgeInsets.only(
                                          bottom: 10, top: 10, left: 10),
                                      child: Image.network(
                                        snapshot.data[index].carimage,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.4,
                                        height: 120,
                                      )),
                                  Container(
                                      child: Row(children: <Widget>[
                                    Container(
                                      //padding: (EdgeInsets.all(2)),
                                      child: Row(children: <Widget>[
                                        Container(
                                          width: 40,
                                          padding: EdgeInsets.all(2),
                                          child: Icon(Icons.person),
                                        ),
                                        Container(
                                          width: 30,
                                          padding: EdgeInsets.all(5),
                                          child: Text(
                                              snapshot.data[index].passanger1),
                                        ),
                                      ]),
                                    ),
                                    Container(
                                      child: Row(children: <Widget>[
                                        Container(
                                          width: 40,
                                          padding: EdgeInsets.all(2),
                                          child: Image.network(
                                              "https://encrypted-tbn0.gstatic.com/"
                                              "images?q=tbn%3AANd9GcRAnSdWWPCYXS1jmDaF_VhIPJR81UVTCZFNL1H3yByIAxd4vwx7"),
                                        ),
                                        Container(
                                          width: 30,
                                          padding: EdgeInsets.all(5),
                                          child: Text(
                                              snapshot.data[index].carluugage),
                                        ),
                                      ]),
                                    ),
                                  ])),
                                  Container(
                                    child: Row(children: <Widget>[
                                      Container(
                                        width: 40,
                                        padding: EdgeInsets.all(2),
                                        child: Image.network(
                                            "https://3.imimg.com/data3/VT/QG/GLADMIN-140882/car-door-250x250.jpg"),
                                      ),
                                      Container(
                                        width: 20,
                                        padding: EdgeInsets.all(5),
                                        child: Text(snapshot.data[index].doors),
                                      ),
                                      Container(
                                        width: 80,
                                        padding: EdgeInsets.only(left: 20),
                                        child:
                                            Text(snapshot.data[index].caryear),
                                      ),
                                    ]),
                                  ),
                                ]),
                              ),
                              Container(
                                  child: Column(children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(
                                      left: 10, right: 10, top: 10, bottom: 0),
                                  child: Text(
                                    snapshot.data[index].carnameen,
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.black),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      left: 0, right: 10, top: 0, bottom: 0),
                                  child: Text(
                                    snapshot.data[index].transmiision,
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.black),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      left: 0, right: 10, top: 10, bottom: 60),
                                  child: Text(
                                    snapshot.data[index].carpriceday +
                                        '' +
                                        snapshot.data[index].coin,
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.black),
                                  ),
                                ),
                              ]))
                            ])),
                      ),
                    ]),
                  ),
                ))));
  }
}
