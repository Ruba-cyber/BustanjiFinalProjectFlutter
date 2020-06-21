import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:language/AppTranslation/AppTranslation.dart';
import 'package:language/CustomDesign/CurveShape.dart';
import 'package:language/CustomerInfo/CustomerData.dart';
import 'package:language/Reservation/ReservationData.dart';
import 'package:language/Urls/BustanjiUrl.dart';
import 'package:rate_my_app/rate_my_app.dart';

import '../HomePage.dart';


class FeedBackAndresNumber extends StatefulWidget {
  @override
  _FeedBackAndresNumberState createState() => _FeedBackAndresNumberState();
}

class _FeedBackAndresNumberState extends State<FeedBackAndresNumber> {
  RateMyApp rate_my_app = RateMyApp(
      preferencesPrefix: 'rate My App',
      minDays: 0,
      minLaunches: 7,
      remindDays: 2,
      remindLaunches: 5);

  void initState() {
    super.initState();
    rate_my_app.init().then((_){
      if(rate_my_app.shouldOpenDialog){ //conditions check if user already rated the app
        rate_my_app.showStarRateDialog(
          context,
          title:   ApplicationLocalizations.of(context).translate("Rating"),

          actionsBuilder: (_, stars){
            return [ // Returns a list of actions (that will be shown at the bottom of the dialog).
              FlatButton(
                child: Text(  ApplicationLocalizations.of(context).translate("ok"),),
                onPressed: () async {
                  print('Thanks for the ' + (stars == null ? '0' : stars.round().toString()) + ' star(s) !');
                  if(stars != null){
                    FeedBackRating(stars);
                    Navigator.pop<RateMyAppDialogButton>(context, RateMyAppDialogButton.rate);
                    //if the user stars is equal to 4 or five
                    // you can redirect the use to playstore or                         appstore to enter their reviews


                  } else {
// else you can redirect the user to a page in your app to tell you how you can make the app better

                  }
                  // You can handle the result as you want (for instance if the user puts 1 star then open your contact page, if he puts more then open the store page, etc...).
                  // This allows to mimic the behavior of the default "Rate" button. See "Advanced > Broadcasting events" for more information :
                  await rate_my_app.callEvent(RateMyAppEventType.rateButtonPressed);
                  Navigator.pop<RateMyAppDialogButton>(context, RateMyAppDialogButton.rate);
                },
              ),
            ];
          },
          dialogStyle: DialogStyle(
            titleAlign: TextAlign.center,
            messageAlign: TextAlign.center,
            messagePadding: EdgeInsets.only(bottom: 20.0),
          ),
          starRatingOptions: StarRatingOptions(),
          onDismissed: () => rate_my_app.callEvent(RateMyAppEventType.laterButtonPressed),
        );
      }
    });
  }
  Future<String>FeedBackRating(var  stars) async {
    var data = BustanjiUrls.feedback;
    print (CustomerData.customerid);print(stars);print(ReservationData.resid.toString());
    http.Response response = await http.post(data, body: {
      'reservation_id': ReservationData.resid.toString(),
      "application_stars": stars.toString(),
      "customer_id": CustomerData.customerid
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo[900],
        ),
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
            child: Column(children: <Widget>[


            Container(child:CurveShape(Icons.perm_identity,   ApplicationLocalizations.of(context).translate("ReservationSucess"),),
        ),


                              Container(

                                  child: Padding(

                                    padding: EdgeInsets.only(bottom: 30),
                                    child:Center(child: Text(ReservationData.resid.toString(),

                                      style:
                                      TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.bold),
                                    ),
                                    ),),
                                ),
                           Container(
                                  padding:
                                  EdgeInsets.only(left: 10, right: 10, bottom: 10),
                                  child: Text(
                                    ApplicationLocalizations.of(context).translate("Thank_You _for_Making_Reservation"),
                                 style: TextStyle(fontSize: 18),
                                  ),
                                ),
              Container(
                padding:
                EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: Text(   ApplicationLocalizations.of(context).translate("Continue_Booking"),
                  style: TextStyle(fontSize: 18),
                ),
              ),
                            Center(
                                  child: Container(
                                    height: 130,
                                    width: 260,
                                    padding: EdgeInsets.only(top: 10),
                                    margin: EdgeInsets.only(top: 10,bottom: 200),
                                    child: Center(
                                      child: Container(height: 70,width: 260,
                                        child: RaisedButton(
                                            onPressed: () {Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        HomePage()),
                                                result: (Route<dynamic> route()) => false);},

//                    if(email.text==''){ print ("Vaild Email");}else{print(email.text);}},
                                            color: Colors.indigo[900],
                                            child: Text(   ApplicationLocalizations.of(context).translate("Make_Another_Booking"),

                                              style: TextStyle(
                                                  fontSize: 18, color: Colors.white),
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.all(Radius.circular(10.0)),
                                            )),
                                      ),
                                    ),
                                  ),
                                ),
                              ])));

  }
}