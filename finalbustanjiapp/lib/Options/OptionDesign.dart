import 'package:flutter/material.dart';
import 'package:language/OffersData/OfferData.dart';
import 'package:language/Reservation/ReservationData.dart';

class OptionDesign extends StatefulWidget {
  @override
  String price;
  AsyncSnapshot snapshot;
  int index;

  OptionDesign(this.snapshot, this.index);

  _OptionDesignState createState() =>
      _OptionDesignState(this.snapshot, this.index);

}

class _OptionDesignState extends State<OptionDesign> {
  String price;
  AsyncSnapshot snapshot;
  int index;
  int optionlimit = 0;
  int optioncount = 0;
  String optioncount1 = "0";
  bool notadd=false;

  _OptionDesignState(this.snapshot, this.index);

  void setPrice() {
    price = snapshot.data[index].price;

    if (OfferData.coin == 'Currency') {
      ReservationData.coin='JD';
      price = snapshot.data[index].price ;
    } else {
      print(OfferData.coin);
      if (OfferData.coin == 'JD') {
        price = snapshot.data[index].price  ;
      }
      if (OfferData.coin == 'EUR') {
        price = snapshot.data[index].europrice ;
      }
      if (OfferData.coin == 'USD') {
        price = snapshot.data[index].dollarprice ;
      }
      //price = snapshot.data[index].price + '  JD';
    }
  }

  void incrementluggage() {
print(notadd);
    print(optioncount1);
    optionlimit = int.parse(snapshot.data[index].optionlimit);
    int optioncount = int.parse(optioncount1);

    if (optioncount < optionlimit) {

      setState(() {
        optioncount = optioncount + 1;
        optioncount1 = optioncount.toString();



          if (ReservationData.optionname.length > 0) {
            for (var i = 0; i < ReservationData.optionname.length; i++) {

              if (ReservationData.optionname[i] == snapshot.data[index].optionname) {
                print("Found");
notadd=true;

                ReservationData.optionname[i]=snapshot.data[index].optionname;
               ReservationData.optioncount[i]=optioncount1;
               ReservationData.optionprice[i]=price;
              print(ReservationData.optionname.length);

        // ReservationData.optionname.insert(i,snapshot.data[index].optionname);
           //  ReservationData.optioncount.insert(i,optioncount1);
         //   ReservationData.optionprice.insert(i,price);
//           }
                print(ReservationData.optionname.length);
              }
              else{ notadd=false;}


//              ReservationData.optionname.add(snapshot.data[index].optionname);
//              ReservationData.optioncount.add(optioncount1);
//              ReservationData.optionprice.add(price);}
            }

          }
            if (notadd ==false) {
              print("Add");
              ReservationData.optionname.add(snapshot.data[index].optionname);
              ReservationData.optioncount.add(optioncount1);
              ReservationData.optionprice.add(price);
            }
              });
    } print1();

  }

  void print1() { print("OptioList");
  if(ReservationData.optionname.length>0){
    for (var i = 0; i < ReservationData.optionname.length; i++) {
      print(ReservationData.optionname[i]);
      print(ReservationData.optionprice[i]);
      print(ReservationData.optioncount[i]);

    }
  }}

  void DecrementOption() {
    int optioncount = int.parse(optioncount1);

    if (optioncount > 0) {
print ("Large");
      setState(() {
        optioncount = optioncount - 1;
        optioncount1 = optioncount.toString();
        if(optioncount==0){
          for (var i = 0; i < ReservationData.optionname.length; i++) {
            if (ReservationData.optionname[i] ==
                snapshot.data[index].optionname) {
              // ReservationData.optionname.removeAt(i);
              ReservationData.optionname.removeAt(i);
              ReservationData.optioncount.removeAt(i);
              ReservationData.optionprice.removeAt(i);
              print("Deleted Option");
        }}}

      else{  if (ReservationData.optionname.length > 0) {
          for (var i = 0; i < ReservationData.optionname.length; i++) {
            if (ReservationData.optionname[i] ==
                snapshot.data[index].optionname) {
              // ReservationData.optionname.removeAt(i);
              ReservationData.optionname[i]=snapshot.data[index].optionname;
              ReservationData.optioncount[i]=optioncount1;
              ReservationData.optionprice[i]=price;
            }}}}});
print1();
//      } else {
//        print("Add");

        }
  }

//    } else {print("hh");
//      if(optioncount1=="0"){
//      for (var i = 0; i < ReservationData.optionname.length; i++) {
//        if (ReservationData.optionname[i] == snapshot.data[index].optionname) {
//          print("Delet");
//          ReservationData.optionname.removeAt(i);
//          ReservationData.optioncount.removeAt(i);
//          ReservationData.optionprice.removeAt(i);
//        }









//     //   numberofluggage=""+numluggage.toString();
//        print(num);
//
//
//      });
//    }
//    else {
//      print("More");
//      setState(() {
//       // numluggage = numluggage;
//     //   numberofluggage=""+numluggage.toString();
//     //   vis=false;
//      });

  @override
  Widget build(BuildContext context) {
    setPrice();
    return Container(
        child: Container(
            child: Material(
      elevation: 5.0,
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
      color: Colors.white,
      child: Column(children: <Widget>[
        Container(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 30, bottom: 0, left: 90),
                child: Text(
                  snapshot.data[index].optionname,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 30, bottom: 0, left: 20),
                child: Text(
                  price+' ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
            ])),
        Container(
          child: Row(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.all(10),
                  child: Image.network(
                    snapshot.data[index].image,
                    width: MediaQuery.of(context).size.width / 2.4,
                    height: 120,
                  )),
              Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        color: Colors.white,
                      ),
                      width: 50,
                      height: 50,
                      padding: EdgeInsets.only(bottom: 0, top: 0),
                      child: RaisedButton(
                        color: Colors.indigo[900],
                        onPressed: () {
                          incrementluggage();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          child: Text(
                            "+",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      color: Colors.grey[300],
                      width: 50,
                      height: 50,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          optioncount1,
                          // numberofpassanger.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        color: Colors.white,
                      ),
                      width: 50,
                      height: 50,
                      child: RaisedButton(
                        color: Colors.indigo[900],
                        onPressed: () {
                          DecrementOption();
                        },
                        padding: EdgeInsets.only(bottom: 0, top: 0),
                        child: Text(
                          "-",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ]),
    )));
  }
}
