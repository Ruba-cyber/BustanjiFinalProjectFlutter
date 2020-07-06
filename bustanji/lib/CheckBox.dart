import 'package:flutter/material.dart';
import 'CustomerData.dart';

class CheckBox extends StatefulWidget {
  String CheckBoxText;
  CheckBox (this.CheckBoxText);
  @override
  CheckboxWidgetClass createState() => new CheckboxWidgetClass(CheckBoxText);

}

class CheckboxWidgetClass extends State {
String CheckBoxText;
CheckboxWidgetClass(this.CheckBoxText){}
  bool isChecked = false;


  var resultHolder = 'Checkbox is UN-CHECKED';

  void toggleCheckbox(bool value) {
    CustomerData.checkagreemment=isChecked;
    CustomerData.saveaccount=isChecked;
    if(isChecked == false)
    {
      // Put your code here which you want to execute on CheckBox Checked event.
      setState(() {
        isChecked = true;
        resultHolder = 'Checkbox is CHECKED';
        if(CheckBoxText=="Agree"){
        CustomerData.checkagreemment=isChecked;
      }
        else{ if(CheckBoxText=="RemberMe"){
          CustomerData.saveaccount=isChecked;
        }}


      });

    }
    else
    {
      // Put your code here which you want to execute on CheckBox Un-Checked event.
      setState(() {
        isChecked = false;
        if(CheckBoxText=="Agree"){
          CustomerData.checkagreemment=isChecked;
        }
        else {
          if (CheckBoxText == "RemberMe") {
            CustomerData.saveaccount = isChecked;
          }
        } });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[ Transform.scale(
          scale: 1,
          child: Checkbox(
            value: isChecked,
            onChanged: (value){toggleCheckbox(value);},
            activeColor: Colors.indigo[900],
            checkColor: Colors.white,
            tristate: false,
          ),
        ),



        ]);
  }}