import 'package:flutter/material.dart';
import 'package:language/OffersData/Offer.dart';

import 'AllCar.dart';


import 'package:http/http.dart' as http;
import 'package:language/Urls/BustanjiUrl.dart';
class OffersAndAllcar extends StatefulWidget {
  @override
  Mytabstate createState() => Mytabstate();
}

class Mytabstate extends State<OffersAndAllcar>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = new TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
            title: new Text(""),
            backgroundColor: Colors.indigo[900],
            bottom: new TabBar(controller: tabController, tabs: <Tab>[
              new Tab(
                  child: Text("Offer",
                      style: TextStyle(color: Colors.white, fontSize: 20))),
              new Tab(child: Text("", style: TextStyle(color: Colors.white, fontSize: 20))),
            ])
        ),
        body: new TabBarView(
            controller: tabController, children: <Widget>[new Offer(),new AllCar()]
        ));
  }
}
