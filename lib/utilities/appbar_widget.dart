import 'package:flutter/material.dart';

PreferredSizeWidget? appbarWidget(String title){
  return AppBar(
    backgroundColor: Colors.transparent,
    title: Text(title),
    centerTitle: true,
    elevation: 0,
  );
}
