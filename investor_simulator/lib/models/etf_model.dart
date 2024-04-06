import 'package:flutter/material.dart';

class ETFModel {
  String name;
  String iconPath;
  double price;
  String percentage;
  Color colour;
  int amount;

  ETFModel(
      {required this.name,
      required this.iconPath,
      required this.price,
      required this.percentage,
      required this.colour,
      required this.amount});

  static List<ETFModel> getETF() {
    List<ETFModel> etf = [];

    etf.add(ETFModel(
      name: 'SPDR S&P 500 ETF TRUST',
      iconPath: 'assets/images/spdr.png',
      price: 5224.62,
      percentage: '+0.89 %',
      colour: const Color(0xFF5CD34D),
      amount: 0,
    ));

    etf.add(ETFModel(
      name: 'Ishares Msci Malaysia',
      iconPath: 'assets/images/ishares.png',
      price: 21.88,
      percentage: '-0.04 %',
      colour: const Color(0xFFE74C3C),
      amount: 0,
    ));

    etf.add(ETFModel(
      name: 'SPDR Gold Trust',
      iconPath: 'assets/images/gld.png',
      price: 202.18,
      percentage: '+1.19 %',
      colour: const Color(0xFF5CD34D),
      amount: 0,
    ));

    etf.add(ETFModel(
      name: 'Vanguard Total Stock Market',
      iconPath: 'assets/images/vanguard.png',
      price: 259.07,
      percentage: '+1.01 %',
      colour: const Color(0xFF5CD34D),
      amount: 0,
    ));

    return etf;
  }
}
