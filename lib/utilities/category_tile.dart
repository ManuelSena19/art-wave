import 'package:flutter/material.dart';

Widget categoryTileWidget(String category, Color color) {
  return Expanded(
    child: ListTile(
      title: Text(
        category,
        style: const TextStyle(color: Colors.white),
        textAlign: TextAlign.center,
      ),
      tileColor: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
  );
}
