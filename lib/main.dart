import 'package:flutter/material.dart';
import 'package:flutter_201_kartlab/src/common/utils/locator.dart';
import 'src/app.dart';

void main() async {
  await setupLocator();
  runApp(const KartLabsApp());
}
