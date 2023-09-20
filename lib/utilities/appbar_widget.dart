import 'package:art_wave/constants/push_routes.dart';
import 'package:art_wave/constants/routes.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget? appbarWidget(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.transparent,
    title: GestureDetector(
      onTap: () {
        pushRoute(context, mainRoute);
      },
      child: ClipOval(
        child: Image.asset(
          'assets/logo.png',
          fit: BoxFit.fill,
          height: 45,
          width: 50,
        ),
      ),
    ),
    centerTitle: true,
    elevation: 0,
    iconTheme: const IconThemeData(color: Colors.black),
  );
}
