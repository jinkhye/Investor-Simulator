import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:investor_simulator/pages/home.dart';
import 'package:investor_simulator/pages/accomodation.dart';
import 'package:investor_simulator/pages/mainmenu.dart';
import 'package:investor_simulator/pages/clothes.dart';
import 'package:investor_simulator/provider/etf_provider.dart';
import 'package:investor_simulator/provider/forex_provider.dart';
import 'package:investor_simulator/provider/game_provider.dart';
import 'package:investor_simulator/provider/news_provider.dart';
import 'package:investor_simulator/provider/portfolio_provider.dart';
import 'package:investor_simulator/provider/stocks_provider.dart';
import 'package:provider/provider.dart';
import 'package:investor_simulator/provider/crypto_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GameProvider()),
        ChangeNotifierProvider(create: (_) => CryptoProvider()),
        ChangeNotifierProvider(create: (_) => StocksProvider()),
        ChangeNotifierProvider(create: (_) => ETFProvider()),
        ChangeNotifierProvider(create: (_) => PortfolioProvider()),
        ChangeNotifierProvider(create: (_) => NewsProvider()),
        ChangeNotifierProvider(create: (_) => ForexProvider()),
        // Add other providers here if needed
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'MightySouly'),
        initialRoute: '/',
        routes: {
          '/': (context) => const HomePage(),
          '/mainMenu': (context) => const MainMenu(),
          '/accomodation': (context) => const Accomodation(),
          '/clothes': (context) => const Clothes(),
          // Add other routes here if needed
        },
      ),
    );
  }
}
