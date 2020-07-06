


import 'package:devicepreview/Emergency/Emergency.dart';
import 'package:flutter/material.dart';




class CustomRouter{
  static Route<dynamic>all(RouteSettings routeSettings){
    switch(routeSettings.name){
      case ('/'):return MaterialPageRoute(builder: (_)=>Emergency());
    }}
}