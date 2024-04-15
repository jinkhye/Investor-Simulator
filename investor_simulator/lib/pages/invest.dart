import 'package:flutter/material.dart';
import 'package:investor_simulator/constant/color.dart';
import 'package:investor_simulator/invest_page/crypto.dart';
import 'package:investor_simulator/invest_page/etf.dart';
import 'package:investor_simulator/invest_page/stocks.dart';
import 'package:investor_simulator/menu/topMenu.dart';
import 'package:stroke_text/stroke_text.dart';

class Invest extends StatefulWidget {
  const Invest({super.key});

  @override
  State<Invest> createState() => _InvestState();
}

class _InvestState extends State<Invest> {
  final PageController pageController = PageController();
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();

    // Listen to the page controller to update the current page index
    pageController.addListener(() {
      setState(() {
        _currentPageIndex = pageController.page?.round() ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
              const SizedBox(height: 15),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 50,
                decoration: BoxDecoration(
                  color: lightPurple,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      navigationButton('STOCKS', 0),
                      navigationButton('ETF', 1),
                      navigationButton('CRYPTO', 2),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Expanded(
                child: PageView(
                  controller: pageController,
                  children: const [
                    StocksMenuPage(),
                    ETFMenuPage(),
                    CryptoMenuPage(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget navigationButton(String text, int index) {
    return GestureDetector(
      onTap: () {
        pageController.jumpToPage(index);
        setState(() {
          _currentPageIndex = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(
          left: 10,
        ),
        child: Container(
          height: 40,
          width: 100,
          decoration: BoxDecoration(
            color: (_currentPageIndex == index) ? yellow : darkPurple,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: darkPurple,
              width: 2,
            ),
          ),
          child: Center(
            child: StrokeText(
              text: text,
              textStyle: TextStyle(
                  letterSpacing: 1.5,
                  fontSize: 20,
                  color:
                      (_currentPageIndex == index) ? white : Colors.grey[400],
                  fontWeight: FontWeight.w100),
              strokeWidth: 4,
              strokeColor: black,
            ),
          ),
        ),
      ),
    );
  }
}
