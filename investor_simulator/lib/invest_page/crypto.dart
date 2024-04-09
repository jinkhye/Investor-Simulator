import 'dart:async';

import 'package:flutter/material.dart';
import 'package:investor_simulator/constant/color.dart';
import 'package:investor_simulator/constant/string_format.dart';
import 'package:investor_simulator/dialog/stock_dialog/crypto_dialog.dart';
import 'package:investor_simulator/dialog/stock_help_dialog.dart';
import 'package:investor_simulator/models/crypto_model.dart';
import 'package:stroke_text/stroke_text.dart';
import 'package:provider/provider.dart';
import 'package:investor_simulator/provider/crypto_provider.dart';

class CryptoMenuPage extends StatefulWidget {
  const CryptoMenuPage({super.key});

  @override
  _CryptoMenuPageState createState() => _CryptoMenuPageState();
}

class _CryptoMenuPageState extends State<CryptoMenuPage> {
  bool _isDataFetched = false;
  late Timer _timer; // Define a timer variable

  @override
  void initState() {
    super.initState();
    _startTimer(); // Start the timer when the widget is initialized
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  void _startTimer() {
    const duration = Duration(minutes: 3);
    _timer = Timer.periodic(duration, (Timer t) {
      setState(() {
        _isDataFetched = false; // Reset the flag every minute
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: cryptoMenu(context),
    );
  }

  Column cryptoMenu(BuildContext context) {
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
        const SizedBox(height: 5),
        Container(
          width: 360,
          height: 10,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/risklevel_crypto.png'),
              fit: BoxFit.fill,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: Consumer<CryptoProvider>(
            builder: (context, provider, _) {
              if (!_isDataFetched) {
                // Fetch data only if it hasn't been fetched yet
                _isDataFetched = true;
                Provider.of<CryptoProvider>(context, listen: false)
                    .fetchCryptocurrencies();
              }
              if (provider.isLoadingChartData) {
                return const Center(child: CircularProgressIndicator());
              } else if (provider.hasError) {
                return Center(child: Text('Error: ${provider.errorMessage}'));
              } else {
                return _stocksSection(provider.cryptocurrencies);
              }
            },
          ),
        ),
      ],
    );
  }

  Column _stocksSection(List<CoinModel> stocks) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
            itemCount: stocks.length,
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.only(left: 20, right: 20),
            itemBuilder: (context, index) {
              final coin = stocks[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topRight,
                      height: 100,
                      width: 330,
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    Positioned(
                      top: 70,
                      right: 35,
                      child: StrokeText(
                        text: formatPercentageString(
                            coin.priceChangePercentage24H.toString()),
                        textStyle: TextStyle(
                            fontSize: 16,
                            color: getColorFromString(
                                (coin.priceChangePercentage24H.toString())),
                            fontFamily: 'Helvetica',
                            fontWeight: FontWeight.w700),
                        strokeColor: white,
                        strokeWidth: 5,
                      ),
                    ),
                    Positioned(
                      top: 15,
                      right: 35,
                      child: StrokeText(
                        text: '\$${coin.currentPrice.toStringAsFixed(2)}',
                        textStyle: const TextStyle(
                          fontFamily: 'Helvetica',
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0,
                          fontSize: 18,
                          color: green,
                          overflow: TextOverflow.clip,
                        ),
                        strokeColor: white,
                        strokeWidth: 5,
                      ),
                    ),
                    Positioned(
                      top: 15,
                      left: 125,
                      child: SizedBox(
                        width: 90,
                        child: StrokeText(
                          text: coin.name,
                          textStyle: const TextStyle(
                            letterSpacing: 0.5,
                            fontSize: 18,
                            color: purple,
                            overflow: TextOverflow.clip,
                          ),
                          strokeColor: white,
                          strokeWidth: 4,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      left: 30,
                      child: Container(
                        height: 85,
                        width: 85,
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
                            scale: 1.0,
                            child: Image.network(
                              coin.image,
                              width: 40,
                              height: 40,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      child: accept(context, coin),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  StrokeText stocksText() {
    return const StrokeText(
      text: "CRYPTOCURRENCY",
      textStyle: TextStyle(fontSize: 36, color: yellow),
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

ElevatedButton accept(BuildContext context, CoinModel coin) {
  return ElevatedButton(
    onPressed: () {
      openCryptoDialog(context, coin);
    },
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.all(0),
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
    child: Container(
      height: 100,
      width: 330,
      decoration: const BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(0)),
      ),
    ),
  );
}
