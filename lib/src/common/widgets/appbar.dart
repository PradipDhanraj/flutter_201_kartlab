import 'package:flutter/material.dart';

AppBar commonAppbar(
  String title, [
  void Function()? menuClickFunc,
  void Function()? cartClickFunc,
]) {
  return AppBar(
    title: Text(title),
    // leading: InkWell(
    //   onTap: menuClickFunc,
    //   child: const Icon(
    //     Icons.message,
    //   ),
    // ),
    actions: [
      InkWell(
        onTap: cartClickFunc,
        child: const Padding(
          padding: EdgeInsets.all(15.0),
          child: Icon(
            Icons.shopping_cart,
          ),
        ),
      ),
    ],
  );
}
