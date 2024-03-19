import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:investor_simulator/pages/home.dart';
import 'package:investor_simulator/pages/accomodation.dart';
import 'package:investor_simulator/pages/mainmenu.dart';
import 'package:provider/provider.dart';
import 'provider/counter_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GameProvider(),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'MightySouly'),
        initialRoute: '/',
        routes: {
          '/': (context) => const HomePage(),
          '/mainMenu': (context) => MainMenu(),
          '/accomodation': (context) => Accomodation(),
          // Add other routes here if needed
        },
      ),
    );
  }
}
