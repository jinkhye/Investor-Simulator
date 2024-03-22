import 'package:flutter/material.dart';

class StocksModel {
  String name;
  String iconPath;
  double price;
  String percentage;
  Color colour;

  StocksModel(
      {required this.name,
      required this.iconPath,
      required this.price,
      required this.percentage,
      required this.colour});

  static List<StocksModel> getStocks() {
    List<StocksModel> stocks = [];

    stocks.add(StocksModel(
      name: 'Tesla',
      iconPath: 'assets/images/tesla.png',
      price: 172.2,
      percentage: '+6.25 %',
      colour: const Color(0xFF5CD34D),
    ));

    stocks.add(StocksModel(
      name: 'Apple',
      iconPath: 'assets/images/apple.png',
      price: 173.72,
      percentage: '+0.64 %',
      colour: const Color(0xFF5CD34D),
    ));

    stocks.add(StocksModel(
      name: 'Tenaga Nasional Berhad',
      iconPath: 'assets/images/tnb.png',
      price: 2.43,
      percentage: '-0.10 %',
      colour: const Color(0xFFE74C3C),
    ));

    stocks.add(StocksModel(
      name: 'Petronas Chemicals Group',
      iconPath: 'assets/images/petronas.png',
      price: 1.27,
      percentage: '-0.10 %',
      colour: const Color(0xFFE74C3C),
    ));

    stocks.add(StocksModel(
      name: 'CelcomDigi Berhad',
      iconPath: 'assets/images/celcomdigi.png',
      price: 4.25,
      percentage: '-0.73 %',
      colour: const Color(0xFFE74C3C),
    ));

    stocks.add(StocksModel(
      name: 'Microsoft Corporation',
      iconPath: 'assets/images/microsoft.png',
      price: 417.32,
      percentage: '-2.97 %',
      colour: const Color(0xFFE74C3C),
    ));

    stocks.add(StocksModel(
      name: 'NVIDIA Corporation',
      iconPath: 'assets/images/nvidia.png',
      price: 884.5,
      percentage: '+13.2 %',
      colour: const Color(0xFF5CD34D),
    ));

    return stocks;
  }
}
