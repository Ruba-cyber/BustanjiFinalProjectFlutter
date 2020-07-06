import 'dart:convert';
import 'package:devicepreview/AppTranslation/AppTranslation.dart';
import 'package:devicepreview/WidthAndHeighTWidget/Size_layout.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../CustomerData.dart';
import '../Urls.dart';
import 'ContactUsData.dart';
import 'ContactUsDesign.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}
List< ContactUsData>contact=[];
Future<List<ContactUsData>>ContactusData1()async{
  var url = await http.get(Urls.contactus);
  contact.clear();
  var ContactUs = json.decode(url.body);
  for (var u in ContactUs) {
    if(CustomerData.Language=="Arabic"){
      ContactUsData c1 = new ContactUsData(u["branch_name_arabic"],u["phone1"],u["phone2"],u["phone3"]
          ,u["email"],u["fax"] );
      contact.add(c1);  }
    else {
      ContactUsData c1 = new ContactUsData(
          u["branch_name_english"], u["phone1"], u["phone2"], u["phone3"]
          , u["email"], u["fax"]);
      contact.add(c1);
    }
}
return contact;}
class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {


        return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.indigo[900],
        ),
        body: SingleChildScrollView(
        child: Container(
        child: Material(

        child: Column(children: <Widget>[
        Container(
        padding: EdgeInsets.only(top: 30, bottom: 30),
            decoration: (BoxDecoration(

                borderRadius: BorderRadius.only())),
            width:double.infinity,

            child: Column(children: <Widget>[

              Center(
                child: Container( width:Size1.width_text,padding:EdgeInsets.only(bottom:5,left:25,right: 25),
                  child: Text( ApplicationLocalizations.of(context).translate("Contact_Us"),
                    style: (TextStyle(fontSize: Size1.Font_size,fontWeight: FontWeight.bold,color: Colors.indigo[900])),),),
              ),

     Container(  child: FutureBuilder(
         future: ContactusData1(),
         builder:
             (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
           if (snapshot.data == null) {
             return Container(
               child: Center(
                 child: Text(
                     ApplicationLocalizations.of(context).translate("Loading") ,  
                   style: TextStyle(fontSize:Size1.Font_size),
                 ),
               ),
             );
           }
           else {

             print(snapshot.data.length);
             return ListView.builder(
               physics: NeverScrollableScrollPhysics(),
               shrinkWrap: true,
               itemCount: snapshot.data.length,
               itemBuilder: (BuildContext context, int index) {

                 return Container(
                   width: MediaQuery.of(context).size.width,
                   height: Size1.const_height,
                   child: ContactUsDesign(snapshot,index),

                   padding:
                   EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                 );
               },
             );
           }
         }))]))])))));

  }
}
