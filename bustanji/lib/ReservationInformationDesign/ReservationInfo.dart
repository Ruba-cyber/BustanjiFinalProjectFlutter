import 'package:devicepreview/WidthAndHeighTWidget/Size_layout.dart';
import 'package:flutter/cupertino.dart';

class ResrevationInfo extends StatefulWidget {
  @override
  String text1, text2;

  _ResrevationInfoState createState() => _ResrevationInfoState(this.text1,this.text2);

  ResrevationInfo(this.text1, this.text2, ) {}
}

class _ResrevationInfoState extends State<ResrevationInfo> {
  @override
  String text1, text2;
  _ResrevationInfoState(this.text1,this.text2);
  Widget build(BuildContext context) {
    return Container(
        width:double.infinity  ,
        margin: EdgeInsets.only(top: 5,bottom: 5,left: 5,right: 5),
        child: FittedBox(
          child: SafeArea(
              child: Row(crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: FittedBox(
                  child: Container(width:Size1.width_of_data_text,
                    child :Text(
                      ""+text1,maxLines: 2,
                      style: (TextStyle(fontSize: Size1.Font_size,
                          fontWeight: FontWeight.bold)),
                    ),
                  ),

                ),

              ),
              Container(
                child: FittedBox(

                  child: Container(width:Size1.width_of_data2,



                      child: Text(
                        "  "+text2,maxLines: 2,
                        style: (TextStyle(fontSize: Size1.Font_size,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.normal)),
                      ),
                    ),
                  ),
                ),

            ],
          )),
        ));
  }
}
