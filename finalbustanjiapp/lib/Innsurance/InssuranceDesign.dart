import 'package:flutter/material.dart';
import 'package:language/OffersData/OfferData.dart';
import 'package:language/Reservation/ReservationData.dart';


class InssuranceDesign extends StatefulWidget {
  @override
  String price;
  AsyncSnapshot snapshot;
  int index;

  InssuranceDesign(this.snapshot, this.index);

  _OptionDesignState createState() =>
      _OptionDesignState(this.snapshot, this.index);
}

class _OptionDesignState extends State<InssuranceDesign> {
  String price;
  AsyncSnapshot snapshot;
  int index;
  bool isChecked = false;

  _OptionDesignState(this.snapshot, this.index);

  void setPrice() {
    price = snapshot.data[index].price;

    if (OfferData.coin == 'Currency') {
      ReservationData.coin='JD';
      price = snapshot.data[index].price + ' ';
    } else {
      print(OfferData.coin);
      if (OfferData.coin == 'JD') {
        price = snapshot.data[index].price + '  ';
      }
      if (OfferData.coin == 'EUR') {
        price = snapshot.data[index].europrice + ' ';
      }
      if (OfferData.coin == 'USD') {
        price = snapshot.data[index].dollarprice + ' ';
      }
      //price = snapshot.data[index].price + '  JD';
    }
  }

  void toggleCheckbox(bool value) {
    if (isChecked == false) {
      // Put your code here which you want to execute on CheckBox Checked event.
      setState(() {
        isChecked = true;


        ReservationData.inssuracelistname.add(snapshot.data[index].insuranceen);
        ReservationData.inssuranceprice.add(price);
      });
    } else {
      // Put your code here which you want to execute on CheckBox Un-Checked event.
      setState(() {
    isChecked=false;
        for (var i = 0; i < ReservationData.inssuracelistname.length; i++) {
          if (ReservationData.inssuracelistname[i] ==
              snapshot.data[index].insuranceen) {
            {
              print("Remove");
              ReservationData.inssuracelistname.removeAt(i);
              ReservationData.inssuranceprice.removeAt(i);
            }
          }


        }

      });
    }
    print1();
  }

  void print1() {
    print("OptioList");
    if (ReservationData.inssuracelistname.length > 0) {
      for (var i = 0; i < ReservationData.inssuracelistname.length; i++) {
        print(ReservationData.inssuracelistname[i]);
        print(ReservationData.inssuranceprice[i]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    setPrice();

    return Container(
        child: Row(children: <Widget>[
      Container(
          width: MediaQuery.of(context).size.width / 1.1,
          margin: EdgeInsets.only(left: 10, right: 10),
          child: Column(children: <Widget>[
            Container(
                child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    color: Colors.white,
                    child: Container(
                        child: Column(children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 20),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: Center(
                                  child: Text(
                                    snapshot.data[index].insuranceen,
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                          child: Row(children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(top: 0, bottom: 0, left: 10,right: 10),
                          child: Image.network(
                            snapshot.data[index].image,
                            width: MediaQuery.of(context).size.width / 2.4,
                            height: MediaQuery.of(context).size.width / 2.4,
                          ),
                        ),
                        Container(
                            child: Checkbox(
                          value: isChecked,
                          onChanged: (value) {
                            toggleCheckbox(value);
                          },
                          activeColor: Colors.indigo[900],
                          checkColor: Colors.white,
                          tristate: false,
                        )),
                        Container(
                          child: Text(
                            price+' '+ReservationData.coin,
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ),
                      ]))
                    ]))))
          ]))
    ]));
  }
}
