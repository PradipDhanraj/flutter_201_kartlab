import 'package:flutter/material.dart';
import 'package:flutter_201_kartlab/src/common/widgets/appbar.dart';

class Home extends StatelessWidget {
  static const String routeName = 'home';
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppbar('KartLabs'),
      body: const Placeholder(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.call),
            label: 'Registry',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            label: 'Add Item',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Share List',
          ),
        ],
      ),
    );
  }
}
