
import 'package:flutter/material.dart';
import 'package:investor_simulator/constant/color.dart';
import 'package:investor_simulator/constant/string_format.dart';
import 'package:investor_simulator/dialog/stock_dialog/stock_dialog.dart';
import 'package:investor_simulator/dialog/stock_help_dialog.dart';
import 'package:investor_simulator/models/stocks_model.dart';
import 'package:investor_simulator/provider/stocks_provider.dart';
import 'package:stroke_text/stroke_text.dart';
import 'package:provider/provider.dart';

class StocksMenuPage extends StatefulWidget {
  const StocksMenuPage({super.key});

  @override
  _StocksMenuPageState createState() => _StocksMenuPageState();
}

class _StocksMenuPageState extends State<StocksMenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: _buildStocksMenu(context),
    );
  }

  Widget _buildStocksMenu(BuildContext context) {
    return Column(
      children: <Widget>[
        Stack(
          children: [
            Center(child: _stocksText()),
            Positioned(
              right: 10,
              top: 5,
              child: _helpButton(context),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Container(
          width: 360,
          height: 10,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/risklevel_stock.png'),
              fit: BoxFit.fill,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: Consumer<StocksProvider>(
            builder: (context, provider, _) {
              if (provider.isLoadingStocks) {
                return const Center(child: CircularProgressIndicator());
              } else if (provider.hasError) {
                return Center(child: Text('Error: ${provider.errorMessage}'));
              } else {
                return _stocksSection(provider.stocks);
              }
            },
          ),
        ),
      ],
    );
  }

  Column _stocksSection(List<Result> stocks) {
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
              final stock = stocks[index];

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
                            stock.regularMarketChangePercent.toString()),
                        textStyle: TextStyle(
                            fontSize: 16,
                            color: getColorFromString(
                                (stock.regularMarketChangePercent.toString())),
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
                        text:
                            '\$${stock.regularMarketPrice?.toStringAsFixed(2)}',
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
                      left: 115,
                      child: SizedBox(
                        width: 130,
                        child: Text(
                          stock.longName ?? '',
                          style: const TextStyle(
                            letterSpacing: 0,
                            fontFamily: 'Helvetica',
                            fontWeight: FontWeight.w800,
                            fontSize: 17,
                            color: darkPurple,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      left: 25,
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
                            child: Image.asset(
                              'assets/stocks/${stock.symbol}.png',
                              width: 40,
                              height: 40,
                              errorBuilder: (context, error, stackTrace) {
                                // Return a placeholder widget in case of error
                                return const Icon(Icons.error, size: 40);
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      child: accept(context, stock),
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

  StrokeText _stocksText() {
    return const StrokeText(
      text: "STOCKS",
      textStyle: TextStyle(fontSize: 36, color: yellow),
      strokeColor: darkPurple,
      strokeWidth: 7,
    );
  }

  ElevatedButton _helpButton(BuildContext context) {
    final pageController = PageController(initialPage: 0);
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

  ElevatedButton accept(BuildContext context, Result stock) {
    return ElevatedButton(
      onPressed: () {
        openStockDialog(context, stock);
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
}
