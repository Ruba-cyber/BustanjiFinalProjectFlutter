import 'package:flutter/material.dart';
import 'package:language/AppTranslation/AppTranslation.dart';
import 'package:url_launcher/url_launcher.dart';

class BranchDesign extends StatefulWidget {

  @override AsyncSnapshot snapshot;int index;
  BranchDesign(this.snapshot,this.index){}
  _ContactUsDesignState createState() => _ContactUsDesignState(snapshot,index);
}

class _ContactUsDesignState extends State<BranchDesign> {
  AsyncSnapshot snapshot;int index;
  _ContactUsDesignState(this.snapshot,this.index){}
  void _launchMapsUrl(String location) async {
    String valueStr =snapshot.data[index].Gps;
    var vals = valueStr.split(',')[0];
    var val2=valueStr.split(',')[1];
    print(vals);
    double s1=double.parse(vals);
    double s2=double.parse(val2);
    final url = 'https://www.google.com/maps/search/?api=1&query=$s1+$s2';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  Widget build(BuildContext context) {
    return Container(

        margin: EdgeInsets.only(left: 5, right: 5),
        child: Material(
          elevation: 1.0,

          child: Wrap(direction: Axis.vertical,
            children: <Widget>[
             Container(child: Column(children: <Widget>[
              Container(
              padding: EdgeInsets.only(top:5,bottom: 5),


          child: Text(
            ""+snapshot.data[index].branchen,
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
        ),

        Container(

            margin: EdgeInsets.only(left: 5,right: 5,top: 10,bottom: 5),
            decoration: new BoxDecoration(
              borderRadius: new BorderRadius.all(

                  new Radius.circular(10.0)),),
            padding: EdgeInsets.all(2),
            child: Row(
                children: <Widget>[

                  Container(


                    padding: EdgeInsets.only(left: 5, right: 5,top: 5,bottom: 5),
                    child: Icon(
                      Icons.location_city,
                      color: Colors.indigo,
                      size: 30,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Text(
                           ApplicationLocalizations.of(context).translate("Address"),
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),



                  Container(width: 200,
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: InkWell(
                      onTap: () {



                      },
                      child:  Text(snapshot.data[index].locationen,style: TextStyle(fontSize: 17,color: Colors.indigo[900]),),
                    ),),
                ])),
        Container(

            margin: EdgeInsets.all(5),
            decoration: new BoxDecoration(
              borderRadius: new BorderRadius.all(

                  new Radius.circular(10.0)),),
            padding: EdgeInsets.all(5),
            child: Row(
                children: <Widget>[




                  Container(width: 180,
                    padding: EdgeInsets.only(left: 5, right: 5),
                    child: InkWell(
                      onTap: () {

                        _launchMapsUrl(snapshot.data[index].Gps);


                      },
                      child:  Text(    ApplicationLocalizations.of(context).translate("Location_on _Map"),style: TextStyle(fontSize: 15,color: Colors.indigo,fontWeight: FontWeight.bold),),
                    ),),
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Icon(Icons.edit_location,
                      color: Colors.indigo,
                      size: 30,
                    ),
                  ),   ])),    ]))],),));


           }}