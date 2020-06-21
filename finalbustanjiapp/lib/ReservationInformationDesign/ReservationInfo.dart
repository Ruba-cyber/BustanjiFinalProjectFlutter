import 'package:flutter/cupertino.dart';
import 'package:intl/intl_browser.dart';
class ResrevationInfo extends StatefulWidget {
  @override
  String text1, text2;

  _ResrevationInfoState createState() => _ResrevationInfoState(this.text1,this.text2);

  ResrevationInfo(this.text1, this.text2) {}
}

class _ResrevationInfoState extends State<ResrevationInfo> {
  @override
  String text1, text2;
  _ResrevationInfoState(this.text1,this.text2);
  Widget build(BuildContext context) {
    return Container(
        width: 300,margin: EdgeInsets.only(top: 10,bottom: 10),
        child: FittedBox(
            child: Row(
          children: <Widget>[
            Container(
              child: FittedBox(
                child: Container(width: 200,
                  child: Text(
                    ""+text1,
                    style: (TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ),
            Container(
              child: FittedBox(

                child: Container(width: 200,
  child:  Directionality(
    textDirection: TextDirection.ltr,

                    child: Text(
                      ""+text2,
                      style: (TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ),
            )
          ],
        )));
  }
}
