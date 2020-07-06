import 'package:devicepreview/AppTranslation/AppTranslation.dart';
import 'package:devicepreview/WidthAndHeighTWidget/Size_layout.dart';
import 'package:flutter/material.dart';
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
          elevation: 5.0,

          child: Wrap(direction: Axis.vertical,
            children: <Widget>[
              Container(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                                Container(
                                  width:Size1.width_text,


                  padding: EdgeInsets.only(top: 5, bottom: 5),


                  child: Center(
                    child: Text(
                      ""+snapshot.data[index].branchen,
                      style: TextStyle(fontSize:  Size1.Font_size, color: Colors.black),
                    ),
                  ),
                ),

                Container(

                    margin: EdgeInsets.only(
                        left: 5, right: 5, top: 10, bottom: 5),
                    decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.all(

                          new Radius.circular(10.0)),),


                    child: SafeArea(

                      child: Row(
                          children: <Widget>[

                            Container(


                              padding: EdgeInsets.only(
                                  left: 5, right: 5, top: 5, bottom: 5),
                              child: Icon(
                                Icons.location_city,
                                color: Colors.indigo,
                                size: Size1.size_icon,
                              ),
                            ),
                            Container(
                              width:  Size1.width_of_bRANCH,
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: SafeArea(
                                child: Text(
                                  ApplicationLocalizations.of(context).translate(
                                      "Address"),
                                  style: TextStyle(
                                      fontSize:  Size1.Font_size, color: Colors.black),
                                ),
                              ),
                            ),


                            Container(width:  Size1.width_of_bRANCH,
                              padding: EdgeInsets.only(left: 5, right: 5),
                              child: InkWell(
                                onTap: () {


                                },

                                  child: Text(snapshot.data[index].locationen,
                                    style: TextStyle(
                                        fontSize:  Size1.Font_size, color: Colors.indigo[900]),),
                                ),
                              ),
                          ]),
                    )),
                Container(

                    margin: EdgeInsets.all(5),
                    decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.all(

                          new Radius.circular(10.0)),),
                    padding: EdgeInsets.all(5),
                    child: SafeArea(
                      child: Row(
                          children: <Widget>[


                            Container(width:    Size1.width_of_bRANCH,

                              padding: EdgeInsets.only(left: 5, right: 5),
                              child: InkWell(
                                onTap: () {
                                  _launchMapsUrl(snapshot.data[index].Gps);
                                },
                                child: Text(
                                  ApplicationLocalizations.of(context).translate(
                                      "Location_on _Map"), style: TextStyle(
                                    fontSize:  Size1.Font_size,
                                    color: Colors.indigo,
                                    fontWeight: FontWeight.bold),),
                              ),),
                            Container(width:  Size1.width_of_bRANCH,
                              padding: EdgeInsets.only(left: 5, right: 5),
                              child: Icon(Icons.edit_location,
                                color: Colors.indigo,
                                size: Size1.size_icon,
                              ),
                            ),
                          ]),
                    )),
              ]))
            ],),));
  }}