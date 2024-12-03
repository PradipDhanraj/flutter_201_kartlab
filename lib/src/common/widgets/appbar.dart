import 'package:flutter/material.dart';

AppBar commonAppbar(
  String title, [
  void Function()? menuClickFunc,
  void Function()? cartClickFunc,
]) {
  return AppBar(
    title: Text(title),
    leading: InkWell(
      onTap: menuClickFunc,
      child: const Icon(
        Icons.arrow_back_ios,
      ),
    ),
    actions: [
      InkWell(
        onTap: cartClickFunc,
        child: const Icon(
          Icons.menu,
        ),
      ),
    ],
  );
}
