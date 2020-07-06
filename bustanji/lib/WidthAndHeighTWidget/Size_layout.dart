import 'package:flutter/cupertino.dart';

class Size1 {
  BuildContext context;
  static double font_size_nav;
  static String Screen_Type;
  double Screen_width;
  double height_Screen;
  static double width_size_container;
  static double image_slider_height;
  static double height_size_container;
  static String Screen_Size;
  static double padding_icon;
  static double width_of_data_text;
  static double size_icon;
  static double width_of_nav;
  static double width_of_Developed;
  static double Text_width;
  static double width_text;
  static double Font_size;
  static double width_of_container;
  static double width_of_data2;
  static double width_About_us;
  static double Option_Name_width;
  static double Option_Quantitiy_width;
  static double Option_Price_width;
  static double Innsurance_Name_width;
  static double Innsurance_Price_width;
  static double width_of_bRANCH;
  static double margin_top;
static double title;
  static double margin_bottom;
  static double drop_down_list_width;
  static double width_of_incremment_and_decrement_button;
  static double height_of_incremment_and_decrement_button;
  static double height_Of_Curve_shape;
  static double width_of_curve_shape;
  static double width_of_button;
  static double height_of_button;
  static double width_of_dropdown;
  static double height_of_container;
  static double width_ofgender;
  static double height_of_curve;
  static double width_splash_Screen;
  static double height_splash_Screen;
  static double const_height;
  static double height_of_Search;
  static double width_of_Search;
  static double width_of_image;
  static double phonecode;
  Size1(this.context) {

    setscreen();
  }

  void setscreen() {

    print("Width" + "1" + this.Screen_width.toString());
    print("Height" + "1" + this.height_Screen.toString());
    if(MediaQuery.of(context).orientation==Orientation.landscape){
      Screen_width=MediaQuery.of(context).size.height;
      height_Screen=MediaQuery.of(context).size.width;
    }
    else{
      Screen_width=MediaQuery.of(context).size.width;
      height_Screen=MediaQuery.of(context).size.height;
    }
    if (this.Screen_width >= 100 && this.Screen_width < 200) {
      Screen_Type = "VerySmall";
      print("ss");
    } else {
      if (this.Screen_width >= 200 && this.Screen_width < 370) {
        Screen_Type = "Small";
      } else {
        if (this.Screen_width >= 370 && this.Screen_width < 475) {
          Screen_Type = "Medium";
        } else {
          if (this.Screen_width > 475 && this.Screen_width < 1000) {
            Screen_Type = "Large";
          } else {
            if (this.Screen_width >= 1000) {
              Screen_Type = "XLARGE";
            }
          }
        }
      }
    }

    setSizes();
  }

  void setSizes() {
    print(Screen_Type);
    switch (Screen_Type) {
      case ("VerySmall"):
        margin_top = 10;
        margin_bottom = 10;
        Font_size = 12;        height_of_curve = 130;
        size_icon = 20;title=60;
        height_of_container = 40;
        width_text = 180;
        width_of_data2=110;
        width_of_image = MediaQuery.of(context).size.width / 5.4;
        width_of_bRANCH = 70;
        const_height = 350;
        width_About_us = 170;
        width_ofgender = 40;
        width_of_data_text=160;
        phonecode = 80;
        width_splash_Screen = 150;
        height_splash_Screen = 150;
        Option_Name_width=100;
        Option_Quantitiy_width=100;
        Option_Price_width=490;
        width_of_dropdown = 70;
        height_of_Search = 40;
        width_of_Search = 40;
        width_of_button = 120;
        width_of_container = MediaQuery.of(context).size.width;
        height_of_button = 30;
        width_of_nav = 30; image_slider_height=100;
        padding_icon = 8;
        width_of_Developed = 100;
        font_size_nav = 15;
        print("Verysmall");

        break;
      case ("Small"):
        title=80;
        margin_top = 10;
        Option_Name_width=200;
        Option_Quantitiy_width=150;
        Option_Price_width=260;
        phonecode = 130;
        margin_bottom = 10;
        Font_size = 17;
        width_of_data2=260;
        width_of_container = MediaQuery.of(context).size.width;
        width_of_bRANCH = 130;
        font_size_nav = 16;
        height_of_curve = 140;
        const_height = 350;
        width_About_us = 360;
        width_ofgender = 70;
        width_splash_Screen = 200;
        height_splash_Screen = 200;
        width_of_dropdown = 100;
        height_of_Search = 40;
        width_of_Search = 50;
        padding_icon = 10;
        width_of_button = 30;
        height_of_button = 30;
        width_of_Developed = 200;
        size_icon = 20;
        height_of_container = 45;
        width_text = 280;
        width_of_data_text=230;
        image_slider_height=150;
        break;
      case ("Medium"):
        title=170;   Option_Name_width=230;
        Option_Quantitiy_width=150;
        Option_Price_width=150;
        margin_top = 10;
        margin_bottom = 10;
        height_of_curve = 140;
        width_text = 450;
        Font_size = 17;
        phonecode = 150;
        width_of_bRANCH = 160;

        size_icon = 20;
        font_size_nav = 18;
        height_of_container = 60;
        width_text = 260;

        width_ofgender = 80;
        width_of_image = MediaQuery.of(context).size.width / 5.4;
        padding_icon = 10;
        const_height = 400;
        width_About_us = 350;
        width_of_data_text=200;

        width_splash_Screen = 200;
        height_splash_Screen = 150;
        width_of_dropdown = 100;
        height_of_Search = 40;
        width_of_Search = 40;
        width_of_button = 40;
        height_of_button = 40;
        image_slider_height=200;

        width_of_Developed = 160;
        width_of_nav = 50;
        print("Meduim");
        break;
      case ("Large"):
        title=190;
        image_slider_height=300;
        Option_Name_width=150;
        Option_Quantitiy_width=150;
        Option_Price_width=150;
        width_of_data2=250;
        margin_top = 10;
        margin_bottom = 10;
        height_of_curve = 140;
        phonecode = 130;
        width_ofgender = 130;
        font_size_nav = 20;
        width_of_nav = 70;
        width_splash_Screen = 250;
        height_splash_Screen = 200;
        width_of_Developed = 230;
        width_of_dropdown = 270;
        const_height = 600;
        height_of_Search = 50;
        padding_icon = 10;
        width_of_data_text=380;
        width_of_bRANCH = 200;
        width_of_Search = 40;
        width_About_us = 900;
        width_of_button = 400;
        height_of_button = 40;
        Font_size = 20;
        width_text = 300;

        size_icon = 30;
        height_of_container = 90;
        break;
      case ("XLARGE"):
        title=200;
        width_of_data_text=280;
        Option_Name_width=200;
        Option_Quantitiy_width=100;
        Option_Price_width=100;
        margin_top = 30;
        margin_bottom = 30;
        width_ofgender = 100;
        font_size_nav = 20;
        width_of_nav = 70;
        width_splash_Screen = 250;
        height_splash_Screen = 200;
        width_of_Developed = 230;
        width_of_dropdown = 200;
        const_height = 700;
        height_of_Search = 50;
        padding_icon = 10;
        width_of_bRANCH = 200;
        width_of_Search = 40;
        width_About_us = 400;
        width_of_button = 400;
        height_of_button = 40;
        Font_size = 15;
        width_text = 300;
        height_of_curve = 360;
        image_slider_height=500;
        size_icon = 20;
        height_of_container = 130;
        break;
    }
  }
}
