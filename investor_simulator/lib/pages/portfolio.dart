import 'package:flutter/material.dart';
import 'package:investor_simulator/constant/color.dart';
import 'package:investor_simulator/constant/string_format.dart';
import 'package:investor_simulator/dialog/portfolio_dialog.dart';
import 'package:investor_simulator/dialog/stock_help_dialog.dart';

import 'package:investor_simulator/menu/topMenu.dart';
import 'package:investor_simulator/provider/crypto_provider.dart';
import 'package:investor_simulator/provider/etf_provider.dart';
import 'package:investor_simulator/provider/portfolio_provider.dart';
import 'package:investor_simulator/provider/stocks_provider.dart';
import 'package:provider/provider.dart';
import 'package:stroke_text/stroke_text.dart';
import 'package:intl/intl.dart';

class Portfolio extends StatefulWidget {
  const Portfolio({super.key});

  @override
  State<Portfolio> createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  @override
  Widget build(BuildContext context) {
    final portfolioProvider = Provider.of<PortfolioProvider>(context);

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
                child: stockMenu(context, portfolioProvider),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double getTotal(PortfolioProvider portfolioProvider) {
    double total = 0;

    for (var entry in portfolioProvider.portfolio.entries) {
      total += entry.value['totalValue'];
    }

    return total;
  }

  Column stockMenu(BuildContext context, PortfolioProvider portfolioProvider) {
    return Column(
      children: <Widget>[
        Stack(
          children: [
            Center(child: stocksText()),
            Positioned(
              right: 10,
              top: 5,
              child: help(context),
            ),
          ],
        ),
        const SizedBox(height: 10),
        RichText(
          text: TextSpan(
            children: [
              const TextSpan(
                text: '\$ ',
                style: TextStyle(
                  fontFamily: 'MightySouly',
                  fontSize: 40,
                  color: lightGreen,
                ),
              ),
              TextSpan(
                text: getTotal(portfolioProvider).toStringAsFixed(2),
                style: const TextStyle(
                  fontFamily: 'Helvetica',
                  color: white,
                  fontWeight: FontWeight.w800,
                  fontSize: 40,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 15),
            child: StrokeText(
              text: "YOUR ASSETS",
              textStyle: TextStyle(fontSize: 30, color: yellow),
              strokeColor: darkPurple,
              strokeWidth: 7,
            ),
          ),
        ),
        const Divider(
          thickness: 4,
          indent: 15,
          endIndent: 15,
        ),
        Builder(
          builder: (context) {
            if (portfolioProvider.portfolio.isEmpty) {
              return const Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          'YOUR PORTFOLIO IS EMPTY!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Expanded(
                  child: Scrollbar(child: _stocksSection(portfolioProvider)));
            }
          },
        ),
        // Padding(
        //   padding: const EdgeInsets.only(bottom: 15.0, top: 10),
        //   child: aiAssessment(context, portfolio),
        // )
      ],
    );
  }

  // ElevatedButton aiAssessment(
  //     BuildContext context, List<PortfolioModel> portfolio) {
  //   return ElevatedButton(
  //     onPressed: () {
  //       Get.to(() => const Assessment(),
  //           transition: Transition.circularReveal,
  //           duration: const Duration(milliseconds: 800));
  //     },
  //     style: ElevatedButton.styleFrom(
  //       padding: const EdgeInsets.all(0),
  //       backgroundColor:
  //           Colors.transparent, // Set the background color to transparent
  //       elevation: 0, // Remove the elevation
  //     ),
  //     child: Container(
  //       alignment: Alignment.center,
  //       height: 70,
  //       width: 280,
  //       decoration: BoxDecoration(
  //         color: yellow,
  //         borderRadius: BorderRadius.circular(10),
  //         border: Border.all(
  //           color: orangeRed,
  //           width: 3,
  //         ),
  //       ),
  //       child: const StrokeText(
  //         text: 'BEGIN AI ASSESSMENT',
  //         textStyle: TextStyle(
  //           fontSize: 24,
  //           color: white,
  //           letterSpacing: 1,
  //         ),
  //         strokeColor: black,
  //         strokeWidth: 4,
  //       ),
  //     ),
  //   );
  // }

  Column _stocksSection(PortfolioProvider portfolioProvider) {
    // Format the date using a DateFormat object
    DateFormat formatter = DateFormat('dd/MM/yyyy hh:mm a');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: portfolioProvider.portfolio.entries.map((entry) {
              final symbol = entry.key;
              final asset = entry.value;

              double percentage =
                  getPercentageChange(symbol, asset['type'], portfolioProvider);

              return Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topRight,
                      height: 120,
                      width: 330,
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    Positioned(
                      bottom: 5,
                      right: 35,
                      child: Text(
                        formatPercentageString(percentage.toString()),
                        style: TextStyle(
                          fontFamily: 'Helvetica',
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.5,
                          fontSize: 18,
                          color: getColorFromPercentage(percentage),
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 1,
                      ),
                    ),
                    Positioned(
                      top: 5,
                      left: 105,
                      child: SizedBox(
                        width: 210,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              asset['name'],
                              style: const TextStyle(
                                fontFamily: 'Helvetica',
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0.5,
                                fontSize: 20,
                                color: darkPurple,
                                overflow: TextOverflow.ellipsis,
                              ),
                              maxLines: 1,
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text: 'Total: ',
                                    style: TextStyle(
                                      fontFamily: 'Helvetica',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                      color: purple,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        '\$${asset['totalValue'].toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontFamily: 'Helvetica',
                                      color: green,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text: 'Quantity: ',
                                    style: TextStyle(
                                      fontFamily: 'Helvetica',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color: purple,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '${asset['quantity'].round()}',
                                    style: const TextStyle(
                                      fontFamily: 'Helvetica',
                                      color: green,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      left: 30,
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: white,
                          border: Border.all(
                            color: darkPurple,
                            width: 4,
                          ),
                        ),
                        child: Center(
                          child: Transform.scale(
                            scale: 0.75,
                            child: iconStock(asset),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 5,
                      left: 30,
                      child: Text(
                        formatter.format(asset['date']),
                        style: const TextStyle(
                          fontFamily: 'Helvetica',
                          color: darkPurple,
                          fontSize: 14,
                          letterSpacing: 0,
                          wordSpacing: 0,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    Positioned(
                      child: accept(context, symbol, asset['type']),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget iconStock(Map<String, dynamic> asset) {
    String type = asset['type'];
    String symbol = asset['result'].symbol.toUpperCase();

    switch (type) {
      case 'crypto':
        {
          return Image.network(
            asset['result'].image,
            width: 40,
            height: 40,
            errorBuilder: (context, error, stackTrace) {
              // Return a placeholder widget in case of error
              return const Icon(Icons.error, size: 40);
            },
          );
        }
      default:
        {
          return Image.network(
            'https://eodhd.com/img/logos/US/$symbol.png',
            width: 40,
            height: 40,
            errorBuilder: (context, error, stackTrace) {
              // Return a placeholder widget in case of error
              return const Icon(Icons.error, size: 40);
            },
          );
        }
    }
  }

  double getPercentageChange(
      String symbol, String type, PortfolioProvider portfolioProvider) {
    // Fetch the relevant provider based on the type (stock, etf, or crypto)

    double currentPrice = 0.0;
    switch (type) {
      case 'stock':
        StocksProvider provider =
            Provider.of<StocksProvider>(context, listen: false);
        currentPrice = provider.stocks
            .firstWhere((stock) => stock.symbol == symbol)
            .regularMarketPrice!;
        break;
      case 'etf':
        ETFProvider provider = Provider.of<ETFProvider>(context, listen: false);
        currentPrice = provider.stocks
            .firstWhere((stock) => stock.symbol == symbol)
            .regularMarketPrice!;
        break;
      case 'crypto':
        CryptoProvider provider =
            Provider.of<CryptoProvider>(context, listen: false);
        currentPrice = provider.cryptocurrencies
            .firstWhere((stock) => stock.symbol == symbol)
            .regularMarketPrice;
        break;
    }

    // Fetch all the entries for the given symbol from the portfolio
    List<Map<String, dynamic>> purchases = portfolioProvider.portfolio.entries
        .where((entry) => entry.key == symbol)
        .map((entry) => entry.value)
        .toList();

    double totalQuantity = 0;
    double weightedPercentageChangeSum = 0;

    // Calculate the weighted percentage change
    for (var purchase in purchases) {
      double purchasePrice = purchase['purchasePrice'];
      double quantity = purchase['quantity'];

      double purchasePercentageChange =
          ((currentPrice - purchasePrice) / purchasePrice) * 100;

      // Add the weighted percentage change to the sum
      weightedPercentageChangeSum += purchasePercentageChange * quantity;
      // Keep track of the total quantity for the symbol
      totalQuantity += quantity;
    }

    // Calculate the overall weighted average percentage change
    double overallPercentageChange =
        weightedPercentageChangeSum / totalQuantity;

    return overallPercentageChange;
  }

  ElevatedButton accept(BuildContext context, symbol, type) {
    return ElevatedButton(
      onPressed: () {
        openPortfolioDialog(context, symbol, type);
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(0),
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        backgroundColor:
            Colors.transparent, // Set the background color to transparent
        elevation: 0, // Remove the elevation
      ),
      child: Container(
        height: 115,
        width: 330,
        decoration: const BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(0)),
        ),
      ),
    );
  }

  StrokeText stocksText() {
    return const StrokeText(
      text: "MY PORTFOLIO",
      textStyle: TextStyle(fontSize: 40, color: yellow),
      strokeColor: darkPurple,
      strokeWidth: 7,
    );
  }

  ElevatedButton help(BuildContext context) {
    final pageController = PageController(initialPage: 1);
    return ElevatedButton(
      onPressed: () {
        openStockHelpDialog(context, pageController);
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(0),
        backgroundColor: Colors.transparent,
        elevation: 0,
        shape: const CircleBorder(
          side: BorderSide(color: darkPurple, width: 4),
        ),
      ),
      child: Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          color: purple,
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Icon(
            Icons.help_outline,
            color: white,
            size: 40,
          ),
        ),
      ),
    );
  }
}
