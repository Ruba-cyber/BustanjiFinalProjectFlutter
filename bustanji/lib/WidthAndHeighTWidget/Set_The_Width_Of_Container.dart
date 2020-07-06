import 'package:flutter/material.dart';

import '../SplashScreen.dart';
import 'Size_layout.dart';
class Set_The_Width_Of_Container  extends StatelessWidget {

  @override
  //const Set_The_Width_Of_Container({Key key,this.builder});
  Widget build(BuildContext context) {
return
LayoutBuilder(
builder: (context,constraints){Size1.height_size_container=constraints.maxHeight;
Size1.width_size_container=constraints.maxWidth;
Container(child: SplashScreen(),);});
  }
}



