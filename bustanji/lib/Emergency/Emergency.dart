import 'package:devicepreview/AppTranslation/AppTranslation.dart';
import 'package:devicepreview/HomePage/HomePage.dart';
import 'package:devicepreview/Login/Login.dart';
import 'package:devicepreview/WidthAndHeighTWidget/Size_layout.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../CustomerData.dart';

//import 'package:language/AppTranslation/AppTranslation.dart';
//import 'package:url_launcher/url_launcher.dart';

class Emergency extends StatefulWidget {
  @override
  _EmergencyState createState() => _EmergencyState();
}


class _EmergencyState extends State<Emergency> {
  BoxFit fit;
  void setFitBox(){
    if(Size1.Screen_Type=="XLarge"){fit=BoxFit.contain;}
    else{fit=BoxFit.contain;}
  }
  void call(String number) => launch("tel:$number");
  Future<bool> _onbackpress() async {
    if (CustomerData.CustomerType == "Customer") {
      return (
          await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => new HomePage(),
              )));
    }
    else{return (
        await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => new Login(),
            )));}}



  Widget build(BuildContext context) {
    setFitBox();

    return WillPopScope(onWillPop: _onbackpress,

      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Colors.indigo[900],
          ),
          body: SingleChildScrollView(
              child: Container(
                  child: Material(
                      child: Column(children: <Widget>[
            Container(
                margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 50),
                child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    color: Colors.white,
                    child: Container(
                      child: SafeArea(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(top: 30, bottom: 10),
                                decoration: (BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.only())),
                                width: double.infinity,
                                height: Size1.height_of_curve,
                                child: Column(children: <Widget>[
                                  Container(width:MediaQuery.of(context).size.width,
                                    child: Icon(
                                      Icons.add_alert,
                                      color: Colors.indigo[900],
                                      size: Size1.size_icon *1.2,
                                    ),
                                  ),
                                  Center(
                                    child: Container(width:Size1.width_text/2,
                                      padding: EdgeInsets.only(top: 10,bottom: 10),
                                      child: FittedBox(
                                        child: Text(
                                          ApplicationLocalizations.of(context)
                                              .translate("Emergency"),
                                          style: TextStyle(
                                              color: Colors.indigo[900],
                                              fontSize: Size1.Font_size),
                                        ),
                                      ),
                                    ),
                                  )
                                ]),
                              ),
                              Container(width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.only(
                                    left: 20, top: 10, bottom: 10, right: 20),
                                child: FittedBox(fit: fit,
                                  child: SafeArea(
                                    child: Container(
                                      width: Size1.width_text,
                                      child: Text(
                                        ApplicationLocalizations.of(context)
                                            .translate("Emergency_Call"),
                                        style: TextStyle(
                                            fontSize: Size1.Font_size,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(width: Size1.width_text,
                                margin: EdgeInsets.only(
                                    left: 10, top: 10, bottom: 10, right: 10),
                                child: FittedBox(fit: fit,
                                  child: Text(
                                    ApplicationLocalizations.of(context)
                                        .translate("Emergency_Number"),
                                    style:
                                        TextStyle(fontSize: Size1.Font_size,
                                            color: Colors.indigo),
                                  ),
                                ),
                              ),
                              Container(width: double.infinity,
                                margin: EdgeInsets.all(10),
                                decoration: new BoxDecoration(
                                  borderRadius: new BorderRadius.all(
                                      new Radius.circular(10.0)),
                                  color: Colors.grey[300],
                                ),
                                height:Size1.height_of_container/1.3,
                                child: FittedBox( fit:fit,
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.only(left: 10, right: 10),
                                        child: Icon(
                                          Icons.phone,
                                          color: Colors.indigo[900],
                                       size: Size1.size_icon,
                                        ),
                                      ),
                                      Container(
                                        child: InkWell(
                                          onTap: () {
                                            call("911");
                                          },
                                          child: Container( width: Size1.width_text,
                                            padding: EdgeInsets.only(
                                              left: 2,right: 2
                                            ),
                                            child: Center(
                                              child: Text(
                                                "911",
                                                style: TextStyle(
                                                    fontSize: Size1.Font_size,
                                                    color: Colors.indigo[900]),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              FittedBox(fit: fit,
                                child: Container(width: Size1.width_text,
                                  margin: EdgeInsets.only(
                                      left: 10, top: Size1.margin_bottom, bottom: Size1.margin_bottom, right: 10),
                                    child: Text(
                                      ApplicationLocalizations.of(context)
                                          .translate("Customer_Services"),
                                      style:
                                          TextStyle(fontSize: Size1.Font_size, color: Colors.indigo),
                                    ),
                                  ),
                              ),
                              
                              Container(width: double.infinity,
                                margin: EdgeInsets.all(10),
                                decoration: new BoxDecoration(
                                  borderRadius: new BorderRadius.all(
                                      new Radius.circular(10.0)),
                                  color: Colors.grey[300],
                                ),
                                height:Size1.height_of_container/1.3,
                                child: FittedBox(
                                  child: Container(width:  MediaQuery.of(context).size.width ,
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.only(left: 10, right: 10),
                                          child: Icon(
                                            Icons.phone,
                                            color: Colors.indigo[900],
                                         size: Size1.size_icon,
                                          ),
                                        ),
                                        Container(
                                          child: InkWell(
                                            onTap: () {
                                              call("065785225");
                                            },
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                left: 2,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "065785225",
                                                  style: TextStyle(
                                                      fontSize: Size1.Font_size,
                                                      color: Colors.indigo[900]),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              FittedBox(fit: fit,
                                child: Container(width: Size1.width_text,
                                  margin: EdgeInsets.only(
                                      left: 10, top: 10, bottom: Size1.margin_bottom, right: Size1.margin_top),
                                  child: Container(
                                    child: Text(
                                      ApplicationLocalizations.of(context)
                                          .translate("Accident_Traffic"),
                                      style:
                                          TextStyle(fontSize: Size1.Font_size, color: Colors.indigo),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                margin: EdgeInsets.all(10),
                                decoration: new BoxDecoration(
                                  borderRadius: new BorderRadius.all(
                                      new Radius.circular(10.0)),
                                  color: Colors.grey[300],
                                ),
                                height:Size1.height_of_container/1.3,
                                child: FittedBox(fit: fit,
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.only(left: 10, right: 10),
                                        child: Icon(
                                          Icons.phone,
                                          color: Colors.indigo[900],
                                       size: Size1.size_icon,
                                        ),
                                      ),
                                      Container(
                                        child: InkWell(
                                          onTap: () {
                                                    call("065785225");
                                          },
                                          child: Container(
                                            padding: EdgeInsets.only(
                                              left: 2,
                                            ),
                                            child: Center(
                                              child: Text(
                                                "065785225",
                                                style: TextStyle(
                                                    fontSize: Size1.Font_size,
                                                    color: Colors.indigo[900]),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(width:Size1.width_text,
                                margin: EdgeInsets.only(
                                    left: 10, top: 10, bottom: 10, right: 10),
                                child: FittedBox(fit: fit,
                                  child: Text(
                                    ApplicationLocalizations.of(context)
                                        .translate("Road_way"),
                                    style:
                                        TextStyle(fontSize: Size1.Font_size, color: Colors.indigo),
                                  ),
                                ),
                              ),
                              Container(width:double.infinity,
                                margin: EdgeInsets.all(10),
                                decoration: new BoxDecoration(
                                  borderRadius: new BorderRadius.all(
                                      new Radius.circular(10.0)),
                                  color: Colors.grey[300],
                                ),
                                height:Size1.height_of_container/1.3,
                                child: FittedBox(fit: fit,
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.only(left: 10, right: 10),
                                        child: Icon(
                                          Icons.phone,
                                          color: Colors.indigo[900],
                                          size: Size1.size_icon,
                                        ),
                                      ),
                                      Container(
                                        child: InkWell(
                                          onTap: () {
                                              call("065785225");
                                          },
                                          child: Container(width: Size1.width_text,
                                            padding: EdgeInsets.only(
                                              left: 2,right: 2
                                            ),
                                            child: Center(
                                              child: Text(
                                                "065785225",
                                                style: TextStyle(
                                                    fontSize:Size1.Font_size,
                                                    color: Colors.indigo[900]),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    )))
          ]))))),
    );
  }
}
