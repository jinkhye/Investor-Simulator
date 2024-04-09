import 'package:flutter/material.dart';
import 'package:investor_simulator/constant/color.dart';
import 'package:investor_simulator/invest_page/crypto.dart';
import 'package:investor_simulator/invest_page/etfmarket.dart';
import 'package:investor_simulator/invest_page/stocks.dart';
import 'package:investor_simulator/menu/topMenu.dart';
import 'package:investor_simulator/provider/game_provider.dart';
import 'package:provider/provider.dart';

class Invest extends StatefulWidget {
  const Invest({super.key});

  @override
  State<Invest> createState() => _InvestState();
}

class _InvestState extends State<Invest> {
  @override
  Widget build(BuildContext context) {
    final imagePath = Provider.of<GameProvider>(context);
    final controller = PageController(initialPage: 0);

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [purple, darkPurple],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              topMenu(context),
              Expanded(
                child: RawScrollbar(
                  thumbColor: yellow,
                  thumbVisibility: true,
                  thickness: 10,
                  radius: const Radius.circular(10),
                  controller: controller,
                  child: PageView(
                    controller: controller,
                    children: [
                      stockMenu(context),
                      etfMenu(context, imagePath),
                      const CryptoMenuPage(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
