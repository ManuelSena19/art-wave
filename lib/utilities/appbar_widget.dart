import 'package:flutter/material.dart';

PreferredSizeWidget? appbarWidget(Widget widget){
  return AppBar(
    backgroundColor: Colors.transparent,
    title: widget,
    centerTitle: true,
    elevation: 0,
  );
}
