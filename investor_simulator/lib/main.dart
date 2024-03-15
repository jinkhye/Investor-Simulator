import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:investor_simulator/pages/home.dart';
import 'package:investor_simulator/pages/invest.dart';
import 'package:investor_simulator/pages/mainmenu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'MightySouly'),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/mainMenu': (context) => MainMenu(),
        '/invest': (context) => Invest(),
        // Add other routes here if needed
      },
    );
  }
}
