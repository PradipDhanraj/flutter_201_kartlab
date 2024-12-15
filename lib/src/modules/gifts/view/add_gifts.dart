import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddGiftsPage extends StatelessWidget {
  static const String routeName = "registry_details";
  const AddGiftsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments;
    if (args != null) {}
    return Scaffold(
      body: Column(
        children: [
          Text("data"),
        ],
      ),
    );
  }
}
