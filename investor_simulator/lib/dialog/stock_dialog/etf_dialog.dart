import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:investor_simulator/constant/color.dart';
import 'package:investor_simulator/dialog/buy_dialog.dart';
import 'package:investor_simulator/dialog/keystats_help_dialog.dart';
import 'package:investor_simulator/dialog/sell_dialog.dart';
import 'package:investor_simulator/models/chart_model.dart';
import 'package:investor_simulator/models/etf_model.dart';
import 'package:investor_simulator/provider/etf_provider.dart';
import 'package:investor_simulator/provider/portfolio_provider.dart';
import 'package:provider/provider.dart';
import 'package:stroke_text/stroke_text.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void openETFDialog(BuildContext context, Result stock) {
  final provider = Provider.of<ETFProvider>(context, listen: false);
  provider.emptyChart();
  provider.fetchChartData(stock.symbol);

  Timer? timer;

  late TrackballBehavior trackballBehavior;
  trackballBehavior = TrackballBehavior(
      enable: true,
      activationMode: ActivationMode.singleTap,
      tooltipSettings: const InteractiveTooltip(
        enable: true,
        textStyle: TextStyle(
          fontFamily: 'Helvetica', // Set font family
          fontSize: 12, // Adjust font size as needed,
        ),
      ));

  void fetchDataPeriodically() {
    // Fetch chart data every 1 minute
    timer = Timer.periodic(const Duration(minutes: 10), (timer) {
      provider.fetchChartData(stock.symbol);
    });
  }

  fetchDataPeriodically();

  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    pageBuilder: (context, animation1, animation2) {
      return Container();
    },
    transitionBuilder: (context, a1, a2, widget) {
      return ScaleTransition(
        scale: Tween<double>(begin: 0.5, end: 1).animate(a1),
        child: FadeTransition(
          opacity: Tween<double>(begin: 0.5, end: 1).animate(a1),
          child: Dialog(
            backgroundColor: white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              padding: const EdgeInsets.all(10),
              width: 400,
              height: 600,
              child: Scrollbar(
                  child: stockDetails(context, stock, trackballBehavior)),
            ),
          ),
        ),
      );
    },
  ).then((_) {
    timer?.cancel();
  });
}

GestureDetector close(BuildContext context) {
  return GestureDetector(
    onTap: () {
      // Add the action to be performed when the button is pressed
      Navigator.pop(context);
    },
    child: Container(
      width: 48, // Adjust width to contain the icon
      height: 48, // Adjust height to contain the icon
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: const Center(
        child: Icon(
          Icons.close_rounded,
          color: Colors.black,
          size: 40, // Adjust the size of the icon as needed
        ),
      ),
    ),
  );
}

Center purchaseText() {
  return const Center(
    child: StrokeText(
      text: "PURCHASE",
      textStyle: TextStyle(fontSize: 30, color: yellow),
      strokeColor: darkPurple,
      strokeWidth: 7,
    ),
  );
}

int getSharesForSymbol(PortfolioProvider portfolioProvider, String? symbol) {
  // Check if the portfolio contains the symbol
  if (portfolioProvider.portfolio.containsKey(symbol)) {
    // Get the asset associated with the symbol
    var asset = portfolioProvider.portfolio[symbol];

    // Return the total shares (quantity) of the symbol
    return asset?['quantity'].round();
  }

  // If the symbol is not in the portfolio, return 0
  return 0;
}

SingleChildScrollView stockDetails(
    BuildContext context, Result stock, TrackballBehavior trackballBehavior) {
  final provider = Provider.of<ETFProvider>(context);
  final portfolio = Provider.of<PortfolioProvider>(context);
  int quantity = getSharesForSymbol(portfolio, stock.symbol);
  List<String> text = ['D', 'W', 'M', '3M', '6M', 'Y'];

  return SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: Column(
      children: [
        SizedBox(
          width: 350,
          height: 55,
          child: Stack(
            children: [
              Positioned(top: -2, right: 0, child: close(context)),
              purchaseText(),
            ],
          ),
        ),
        SizedBox(
          width: 300,
          height: 105,
          child: stockDetailsLogoName(context, stock),
        ),
        const SizedBox(
          height: 10,
        ),
        RichText(
          text: TextSpan(
            children: <TextSpan>[
              const TextSpan(
                text: "You currently own ",
                style: TextStyle(
                  fontFamily: 'Helvetica',
                  letterSpacing: 0,
                  fontSize: 14,
                  color: black,
                ),
              ),
              TextSpan(
                text: quantity.toString(),
                style: TextStyle(
                  fontFamily: 'Helvetica',
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0,
                  fontSize: 14,
                  color: getColorFromQuantity(
                      quantity), // Change the color of the number
                ),
              ),
              const TextSpan(
                text: " units of this stock.",
                style: TextStyle(
                  fontFamily: 'Helvetica',
                  letterSpacing: 0,
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(width: 15),
            StrokeText(
              text: '\$${stock.regularMarketPrice?.toStringAsFixed(2)}',
              textStyle: const TextStyle(
                fontFamily: 'Helvetica',
                fontWeight: FontWeight.w800,
                letterSpacing: 0,
                fontSize: 20,
                color: green,
                overflow: TextOverflow.clip,
              ),
              strokeColor: Colors.transparent,
            ),
            Expanded(child: Container()),
            StrokeText(
              text:
                  '(${stock.regularMarketChangePercent?.toStringAsFixed(2)}%)',
              textStyle: TextStyle(
                  fontSize: 16,
                  color: getColour(stock.regularMarketChangePercent),
                  fontFamily: 'Helvetica',
                  fontWeight: FontWeight.w700),
              strokeColor: Colors.transparent,
              strokeWidth: 5,
            ),
            const SizedBox(width: 15),
          ],
        ),
        const SizedBox(height: 5),
        Consumer<ETFProvider>(
          builder: (context, provider, _) {
            if (provider.itemChart != null) {
              // Data loaded, return chart
              return stockChart(trackballBehavior, provider.chartModel);
            } else if (provider.isLoadingChartData) {
              // Data loading, return loading indicator
              return const Center(child: CircularProgressIndicator());
            } else if (provider.hasChartError) {
              // Error fetching data, handle error
              return Center(
                child: Text(
                  'Error: ${provider.errorMessage} \n\nAttention this Api is free, so you cannot send multiple requests per second, please wait and try again later.',
                ),
              );
            } else {
              // Data not yet loaded (initial state), return placeholder
              return const Center(
                  child: Text('Loading chart data...')); // Placeholder text
            }
          },
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 30,
          width: 311,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: text.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (provider.isLoadingChartData == false) {
                      provider.setDays(text[index]);
                      provider.fetchChartData(stock.symbol);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                    backgroundColor: provider.getDayColour(
                        text[index]), // Set the background color to transparent
                    elevation: 0, // Remove the elevation
                  ),
                  child: Text(text[index],
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Helvetica',
                          fontWeight: FontWeight.w600,
                          color: provider.getTextDayColour(text[index]))),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            sellStock(context, stock, quantity),
            buyStock(context, stock),
          ],
        ),
        const Divider(
          thickness: 4,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Row(
            children: [
              const Text('Key Stats',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 35,
                    color: purple,
                  )),
              Expanded(child: Container()),
              statsHelp(context),
            ],
          ),
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                marketcap(stock),
                dividend(stock),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                priceToBook(stock),
                marketState(stock),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
      ],
    ),
  );
}

SizedBox stockChart(
    TrackballBehavior trackballBehavior, List<ChartModel>? itemChart) {
  return SizedBox(
    height: 200,
    width: 311,
    child: SfCartesianChart(
      enableAxisAnimation: true,
      trackballBehavior: trackballBehavior,
      zoomPanBehavior:
          ZoomPanBehavior(enablePinching: true, zoomMode: ZoomMode.x),
      primaryXAxis: DateTimeCategoryAxis(
        interval: 5,
        dateFormat: DateFormat('d/M HH:mm'),
        labelStyle: const TextStyle(
            fontFamily: 'Helvetica', fontSize: 12, fontWeight: FontWeight.w600),
      ),
      primaryYAxis: const NumericAxis(
        labelStyle: TextStyle(
            fontFamily: 'Helvetica', fontSize: 12, fontWeight: FontWeight.w600),
      ),
      series: <CandleSeries>[
        CandleSeries<ChartModel, DateTime>(
          enableSolidCandles: true,
          enableTooltip: true,
          bullColor: Colors.green,
          bearColor: Colors.red,
          dataSource: itemChart,
          xValueMapper: (ChartModel sales, _) =>
              DateTime.fromMillisecondsSinceEpoch((sales.time) * 1000),
          lowValueMapper: (ChartModel sales, _) => sales.low,
          highValueMapper: (ChartModel sales, _) => sales.high,
          openValueMapper: (ChartModel sales, _) => sales.open,
          closeValueMapper: (ChartModel sales, _) => sales.close,
          animationDuration: 55,
        )
      ],
    ),
  );
}

ElevatedButton statsHelp(BuildContext context) {
  final pageController = PageController(initialPage: 0);
  return ElevatedButton(
    onPressed: () {
      openKeyStatsHelpDialog(context, pageController);
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
          color: Colors.white,
          size: 40,
        ),
      ),
    ),
  );
}

Container marketState(Result stock) {
  String market = '';

  Color color = green;

  if (stock.marketState == 'PRE') {
    market = 'Pre-Market';
    color = green;
  } else if (stock.marketState == 'REGULAR') {
    market = 'Regular Market';
  } else {
    market = 'Post-Market';
  }

  if (stock.marketState == 'PRE') {
    color = blue;
  } else if (stock.marketState == 'REGULAR') {
    color = green;
  } else {
    color = orangeRed;
  }

  return Container(
    width: 140,
    height: 100,
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      color: Colors.transparent,
      border: Border.all(
        color: darkPurple,
        width: 4,
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Market State',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Helvetica',
            fontSize: 16,
            color: black,
            letterSpacing: 0,
            height: 0,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          market,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Helvetica',
            fontSize: 16,
            color: color,
            letterSpacing: 0,
            height: 0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

Container priceToBook(Result stock) {
  double pbRatio = stock.priceToBook;
  Color color = red;

  if (pbRatio < 1.0) {
    // P/B ratio less than 1.0 is considered undervalued (green)
    color = green;
  } else if (pbRatio >= 1.0 && pbRatio <= 3.0) {
    // P/B ratio between 1.0 and 3.0 is considered fairly valued (yellow)
    color = orangeRed;
  } else {
    // P/B ratio above 3.0 is considered overvalued (red)
    color = red;
  }

  return Container(
    width: 140,
    height: 100,
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      color: Colors.transparent,
      border: Border.all(
        color: darkPurple,
        width: 4,
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Price-To-Book Ratio',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Helvetica',
            fontSize: 16,
            color: black,
            letterSpacing: 0,
            height: 0,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          stock.priceToBook.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Helvetica',
            fontSize: 16,
            color: color,
            letterSpacing: 0,
            height: 0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

Container dividend(Result stock) {
  double dividendYield = stock.dividendYield ?? 0.0;
  Color color = red;

  if (dividendYield < 1.0) {
    // Dividend yield below 1% is considered too low (red)
    color = red;
  } else if (dividendYield >= 1.0 && dividendYield < 2.0) {
    // Dividend yield between 1% and 2% is in the caution range (yellow)
    color = orangeRed;
  } else if (dividendYield >= 2.0 && dividendYield <= 6.0) {
    // Dividend yield between 2% and 6% is considered ideal (green)
    color = green;
  } else if (dividendYield > 6.0 && dividendYield <= 8.0) {
    // Dividend yield between 6% and 8% is in the caution range (yellow)
    color = orangeRed;
  } else {
    // Dividend yield above 8% is considered too high (red)
    color = red;
  }

  return Container(
    width: 140,
    height: 100,
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      color: Colors.transparent,
      border: Border.all(
        color: darkPurple,
        width: 4,
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Dividend Yield',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Helvetica',
            fontSize: 16,
            color: black,
            letterSpacing: 0,
            height: 0,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          stock.dividendYield.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Helvetica',
            fontSize: 16,
            color: color,
            letterSpacing: 0,
            height: 0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

Container marketcap(Result stock) {
  Color color = red;
  int marketCap = stock.marketCap ?? 0;

  if (marketCap > 10000000000) {
    // Market cap greater than $10 billion (Large Cap) is considered green (good)
    color = green;
  } else if (marketCap >= 2000000000 && marketCap <= 10000000000) {
    // Market cap between $2 billion and $10 billion (Mid Cap) is considered yellow (caution)
    color = orangeRed;
  } else {
    // Market cap less than $2 billion (Small Cap or smaller) is considered red (bad)
    color = red;
  }

  return Container(
    width: 140,
    height: 100,
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      color: Colors.transparent,
      border: Border.all(
        color: darkPurple,
        width: 4,
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Market Capitalization',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Helvetica',
            fontSize: 16,
            color: black,
            letterSpacing: 0,
            height: 0,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          NumberFormat.compactSimpleCurrency(locale: 'en-US')
              .format(stock.marketCap),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Helvetica',
            fontSize: 16,
            color: color,
            letterSpacing: 0,
            height: 0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

Stack stockDetailsLogoName(BuildContext context, Result stock) {
  return Stack(
    children: [
      Positioned(
        top: 8,
        left: 2,
        child: Column(
          children: [
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
                border: Border.all(
                  color: darkPurple,
                  width: 4,
                ),
              ),
              child: Center(
                child: Transform.scale(
                  scale:
                      1.0, // Adjust the scale factor to make the image smaller
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
            const SizedBox(height: 8),
            Text(
              '(${stock.symbol})',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Helvetica',
                fontWeight: FontWeight.w800,
                fontSize: 14,
                color: Colors.grey[600],
                letterSpacing: 0,
                height: 0,
              ),
            ),
          ],
        ),
      ),
      Positioned(
        left: 80,
        top: 0,
        child: SizedBox(
          height: 80,
          width: 218,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              stock.longName ?? '',
              textAlign: TextAlign.left,
              maxLines: 4,
              style: const TextStyle(
                fontFamily: 'Helvetica',
                fontWeight: FontWeight.w800,
                fontSize: 20,
                color: purple,
                overflow: TextOverflow.clip,
                height: 0,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

ElevatedButton sellStock(BuildContext context, Result stock, int quantity) {
  return ElevatedButton(
    onPressed: () {
      openSellDialog(context, stock, 'etf', quantity);
    },
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.all(0),
      backgroundColor:
          Colors.transparent, // Set the background color to transparent
      elevation: 0, // Remove the elevation
    ),
    child: Container(
      alignment: Alignment.center,
      height: 40,
      width: 100,
      decoration: BoxDecoration(
        color: red,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: darkRed,
          width: 4,
        ),
      ),
      child: const StrokeText(
        text: 'SELL',
        textStyle: TextStyle(fontSize: 18, color: white),
        strokeColor: black,
        strokeWidth: 4,
      ),
    ),
  );
}

ElevatedButton buyStock(BuildContext context, Result stock) {
  return ElevatedButton(
    onPressed: () {
      openBuyDialog(context, stock, 'etf');
    },
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.all(0),
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
    child: Container(
      alignment: Alignment.center,
      height: 40,
      width: 100,
      decoration: BoxDecoration(
        color: lightGreen,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: green,
          width: 4,
        ),
      ),
      child: const StrokeText(
        text: 'BUY',
        textStyle: TextStyle(fontSize: 18, color: white),
        strokeColor: black,
        strokeWidth: 4,
      ),
    ),
  );
}

Color getColour(double? percentage) {
  if (percentage! > 0) {
    return green;
  } else if (percentage == 0) {
    return Colors.grey;
  } else {
    return red;
  }
}
