import 'package:flutter/material.dart';
import 'package:investor_simulator/constant/color.dart';
import 'package:investor_simulator/constant/string_format.dart';
import 'package:investor_simulator/dialog/stock_dialog/forex_dialog.dart';
import 'package:investor_simulator/dialog/stock_help_dialog.dart';
import 'package:investor_simulator/models/forex_model.dart';
import 'package:investor_simulator/provider/forex_provider.dart';
import 'package:stroke_text/stroke_text.dart';
import 'package:provider/provider.dart';

class ForexMenuPage extends StatefulWidget {
  const ForexMenuPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ForexMenuPageState createState() => _ForexMenuPageState();
}

class _ForexMenuPageState extends State<ForexMenuPage> {
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
              image: AssetImage('assets/images/risklevel_forex.png'),
              fit: BoxFit.fill,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: Consumer<ForexProvider>(
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
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topRight,
                      height: 110,
                      width: 330,
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    Positioned(
                      bottom: 8,
                      right: 25,
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
                      top: 13,
                      right: 25,
                      child: StrokeText(
                        text:
                            '\$${stock.regularMarketPrice.toStringAsFixed(2)}',
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
                      top: 5,
                      left: 25,
                      child: SizedBox(
                        width: 230,
                        child: Text(
                          stock.longName,
                          style: const TextStyle(
                            letterSpacing: 0,
                            fontFamily: 'Helvetica',
                            fontWeight: FontWeight.w800,
                            fontSize: 28,
                            color: darkPurple,
                            overflow: TextOverflow.clip,
                          ),
                          maxLines: 4,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 25,
                      bottom: 8,
                      child: Text(
                        '(${stock.symbol})',
                        style: TextStyle(
                          letterSpacing: 0,
                          fontFamily: 'Helvetica',
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                          color: Colors.grey[600],
                          overflow: TextOverflow.clip,
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
      text: "FOREX MARKET",
      textStyle: TextStyle(fontSize: 36, color: yellow),
      strokeColor: darkPurple,
      strokeWidth: 7,
    );
  }

  ElevatedButton _helpButton(BuildContext context) {
    final pageController = PageController(initialPage: 2);
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
        openForexDialog(context, stock);
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
        height: 110,
        width: 330,
        decoration: const BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(0)),
        ),
      ),
    );
  }
}
