import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_201_kartlab/src/common/utils/locator.dart';
import 'src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  HttpOverrides.global = MyHttpOverrides();
  runApp(const KartLabsApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
