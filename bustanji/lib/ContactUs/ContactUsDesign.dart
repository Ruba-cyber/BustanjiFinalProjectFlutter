import 'package:devicepreview/AppTranslation/AppTranslation.dart';
import 'package:devicepreview/WidthAndHeighTWidget/Size_layout.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsDesign extends StatefulWidget {
  @override
  AsyncSnapshot snapshot;
  int index;

  ContactUsDesign(this.snapshot, this.index) {}

  _ContactUsDesignState createState() => _ContactUsDesignState(snapshot, index);
}

class _ContactUsDesignState extends State<ContactUsDesign> {
  AsyncSnapshot snapshot;
  int index;

  _ContactUsDesignState(this.snapshot, this.index) {}
//
  void call(String number) => launch("tel:$number");

  void sendEmail(String email) => launch("mailto:$email");

  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 10,left: 10,right: 10,bottom: 10),
//        child: Material(
//          elevation: 5.0,
//          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          child: FittedBox(
            child: Column (crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Container(

                    padding: EdgeInsets.only(top: 5, bottom: 0,left: 80,right: 80),
                    child: Text(
                      "" + snapshot.data[index].branchnameen,textAlign: TextAlign.center,
                      style: TextStyle(fontSize: Size1.Font_size
                          , color: Colors.black,fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  height: Size1.height_of_container,
                  margin: EdgeInsets.all(5),
                  decoration: new BoxDecoration(

                    borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
                  ),
                  padding: EdgeInsets.all(5),
                  child: FittedBox(
                    child: Wrap(direction: Axis.horizontal,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Icon(
                            Icons.phone,
                            color: Colors.indigo,
                            size: Size1.size_icon,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Text(
                            ApplicationLocalizations.of(context).translate("Phone1"),
                            style: TextStyle(fontSize: Size1.Font_size, color: Colors.black,fontWeight: FontWeight.bold,),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: InkWell(
                            onTap: () {
                              //  call(snapshot.data[index].phone2);
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: 2,right: 2
                              ),
                              child: Text(
                                "" + snapshot.data[index].phone1,
                                style: TextStyle(
                                    fontSize: Size1.Font_size, color: Colors.indigo[900]),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  height: Size1.height_of_container,
                  margin: EdgeInsets.all(5),
                  decoration: new BoxDecoration(

                    borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
                  ),
                  padding: EdgeInsets.all(5),
                  child: FittedBox(fit: BoxFit.scaleDown,
                    child: Wrap(direction: Axis.horizontal,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Icon(
                            Icons.phone,
                            color: Colors.indigo,
                          size: Size1.size_icon,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Text(
                            ApplicationLocalizations.of(context).translate("Phone2"),
                            style: TextStyle(fontSize: Size1.Font_size, color: Colors.black,fontWeight: FontWeight.bold,),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: InkWell(
                            onTap: () {
                              call(snapshot.data[index].phone2);
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                left: 2,right: 2
                              ),
                              child: Text(
                                "" + snapshot.data[index].phone2,
                                style: TextStyle(
                                    fontSize: Size1.Font_size, color: Colors.indigo[900]),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  height: Size1.height_of_container,
                  margin: EdgeInsets.all(5),
                  decoration: new BoxDecoration(

                    borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
                  ),
                  padding: EdgeInsets.all(5),
                  child: FittedBox(fit: BoxFit.scaleDown,
                    child: Wrap(direction: Axis.horizontal,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Icon(
                            Icons.phone,
                            color: Colors.indigo,
                            size: Size1.size_icon,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Text(
                            ApplicationLocalizations.of(context).translate("Phone3"),
                            style: TextStyle(fontSize: Size1.Font_size, color: Colors.black,fontWeight: FontWeight.bold,),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: InkWell(
                            onTap: () {
                                call(snapshot.data[index].phone2);
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: 2,right: 2
                              ),
                              child: Text(
                                "" + snapshot.data[index].phone3,
                                style: TextStyle(
                                    fontSize: Size1.Font_size, color: Colors.indigo[900]),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  height: Size1.height_of_container,
                  margin: EdgeInsets.all(5),
                  decoration: new BoxDecoration(

                    borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
                  ),
                  padding: EdgeInsets.all(5),
                  child: FittedBox(fit: BoxFit.scaleDown,
                    child: Wrap(direction: Axis.horizontal,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Icon(
                            Icons.email,
                            color: Colors.indigo,
                            size: Size1.size_icon,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Text(
                            ApplicationLocalizations.of(context).translate("Email2"),
                            style: TextStyle(fontSize: Size1.Font_size, color: Colors.black,fontWeight: FontWeight.bold,),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: InkWell(
                            onTap: () {
                                sendEmail(snapshot.data[index].email);
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: 2,right: 2
                              ),
                              child: Text(
                                "" + snapshot.data[index].email,
                                style: TextStyle(
                                    fontSize: Size1.Font_size, color: Colors.indigo[900]),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),),
    Container(
    height: Size1.height_of_container,
    margin: EdgeInsets.all(5),
    decoration: new BoxDecoration(

    borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
    ),
    padding: EdgeInsets.all(5),
    child: FittedBox(fit: BoxFit.scaleDown,
    child: Wrap(direction: Axis.horizontal,
    children: <Widget>[
    Container(
    padding: EdgeInsets.only(left: 10, right: 10),
    child: Icon(
    Icons.phone,
    color: Colors.indigo,
    size: Size1.size_icon,
    ),
    ),
    Container(
    padding: EdgeInsets.only(left: 10, right: 10),
    child: Text(
    ApplicationLocalizations.of(context).translate("Fax"),
    style: TextStyle(fontSize: Size1.Font_size, color: Colors.black,fontWeight: FontWeight.bold,),
    ),
    ),
    Container(
    padding: EdgeInsets.only(left: 10, right: 10),
    child: InkWell(
    onTap: () {
     call(snapshot.data[index].fax);
    },
    child: Container(
    padding: EdgeInsets.only(
    left: 60,right: 60
    ),
    child: Text(
    "" + snapshot.data[index].fax,
    style: TextStyle(
    fontSize: Size1.Font_size, color: Colors.indigo[900]),
    ),
    ),
    ),
    )
    ],
    ),
    ),
    ),]),
          //)));



    ));}
}
