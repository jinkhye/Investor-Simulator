import 'package:flutter/material.dart';

class CryptoModel {
  String name;
  String iconPath;
  double price;
  String percentage;
  Color colour;
  int amount;

  CryptoModel(
      {required this.name,
      required this.iconPath,
      required this.price,
      required this.percentage,
      required this.colour,
      required this.amount});

  static List<CryptoModel> getCrypto() {
    List<CryptoModel> crypto = [];

    crypto.add(CryptoModel(
      name: 'Bitcoin',
      iconPath: 'assets/images/bitcoin.png',
      price: 67058.30,
      percentage: '-1.17 %',
      colour: const Color(0xFFE74C3C),
      amount: 0,
    ));

    crypto.add(CryptoModel(
      name: 'Ethereum',
      iconPath: 'assets/images/ethereum.png',
      price: 3514.54,
      percentage: '-0.06 %',
      colour: const Color(0xFFE74C3C),
      amount: 0,
    ));

    crypto.add(CryptoModel(
      name: 'Tether',
      iconPath: 'assets/images/tether.png',
      price: 202.18,
      percentage: '+1.19 %',
      colour: const Color(0xFF5CD34D),
      amount: 0,
    ));

    crypto.add(CryptoModel(
      name: 'Dogecoin',
      iconPath: 'assets/images/dogecoin.png',
      price: 0.15,
      percentage: '0.00%',
      colour: Colors.grey,
      amount: 0,
    ));

    return crypto;
  }
}
