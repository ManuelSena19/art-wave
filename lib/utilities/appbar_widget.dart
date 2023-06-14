import 'package:art_wave/constants/push_routes.dart';
import 'package:art_wave/constants/routes.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget? appbarWidget(BuildContext context, Widget widget){
  return AppBar(
    backgroundColor: Colors.transparent,
    title: GestureDetector(
      onTap: (){
        pushRoute(context, homescreenRoute);
      },
      child: widget,
    ),
    centerTitle: true,
    elevation: 0,
    iconTheme: const IconThemeData(color: Colors.black),
  );
}
