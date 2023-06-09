import 'package:flutter/material.dart';

void pushRoute(BuildContext context, String routeName){
  Navigator.pushNamed(context, routeName);
}

void pushReplacementRoute(BuildContext context, String routeName){
  Navigator.pushReplacementNamed(context, routeName);
}