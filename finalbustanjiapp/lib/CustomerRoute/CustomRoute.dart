


import 'package:flutter/material.dart';
import 'package:language/SplashScreen/SpalshScreen.dart';


class CustomRouter{
static Route<dynamic>all(RouteSettings routeSettings){
  switch(routeSettings.name){
    case ('/'):return MaterialPageRoute(builder: (_)=>SplashScreen());
  }}
}