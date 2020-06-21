import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:language/AppTranslation/AppTranslation.dart';

import 'Dateandemail.dart';
import 'Emailandresid.dart';
import 'NameSearch.dart';

class CustomerBooikingsearch extends StatefulWidget {
  @override
  _CustomerBookingsearchState createState() => _CustomerBookingsearchState();
}

class _CustomerBookingsearchState extends State<CustomerBooikingsearch> with SingleTickerProviderStateMixin {
  @override
  TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    tabController = new TabController(length: 3, vsync: this);}

  Widget build(BuildContext context) {

    return Scaffold( resizeToAvoidBottomInset: false,
        appBar: new AppBar(
          title: new Text(""),
          backgroundColor: Colors.indigo[900],
          bottom: new TabBar(controller: tabController, tabs: <Tab>[
            new Tab(
                child: Text(   ApplicationLocalizations.of(context).translate("Email") ,
                    style: TextStyle(color: Colors.white, fontSize: 20))),
            new Tab(child: Text(   ApplicationLocalizations.of(context).translate("Name") , style: TextStyle(color: Colors.white, fontSize: 20))),

            new Tab(child: Text(   ApplicationLocalizations.of(context).translate("Date") , style: TextStyle(color: Colors.white, fontSize: 20))),
          ]),

        ),
        body: new TabBarView(
            controller: tabController, children: <Widget>[new Emailandresid(),new NameSearch(),new Dateandemail()]
        ));}}