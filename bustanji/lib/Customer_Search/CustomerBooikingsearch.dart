import 'dart:convert';

import 'package:devicepreview/AppTranslation/AppTranslation.dart';
import 'package:devicepreview/WidthAndHeighTWidget/Size_layout.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
                child: FittedBox(fit:BoxFit.scaleDown,
                  child: Text(ApplicationLocalizations.of(context).
                  translate("Email2"),style:TextStyle(fontSize:Size1.Font_size,color: Colors.white )),
                ) ,
                   ),
            new Tab(child: 
            FittedBox( fit:BoxFit.scaleDown,child: Text(ApplicationLocalizations.of(context).translate("Name") , style: TextStyle(color: Colors.white, fontSize: Size1.Font_size)))),

            new Tab(child: 
            FittedBox( fit:BoxFit.scaleDown,child: Text(ApplicationLocalizations.of(context).translate("Date") , style: TextStyle(color: Colors.white, fontSize: Size1.Font_size)))),
          ]),

        ),
        body: new TabBarView(
            controller: tabController, children: <Widget>[new Emailandresid(),new NameSearch(),new Dateandemail()]
        ));}}