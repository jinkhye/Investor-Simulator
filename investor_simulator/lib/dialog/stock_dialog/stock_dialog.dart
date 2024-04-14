import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:investor_simulator/constant/color.dart';
import 'package:investor_simulator/dialog/buy_dialog.dart';
import 'package:investor_simulator/dialog/keystats_help_dialog.dart';
import 'package:investor_simulator/dialog/revenue_dialog.dart';
import 'package:investor_simulator/dialog/sell_dialog.dart';
import 'package:investor_simulator/models/chart_model.dart';
import 'package:investor_simulator/models/stocks_model.dart';
import 'package:investor_simulator/provider/portfolio_provider.dart';
import 'package:investor_simulator/provider/stocks_provider.dart';
import 'package:provider/provider.dart';
import 'package:stroke_text/stroke_text.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void openStockDialog(BuildContext context, Result stock) {
  final provider = Provider.of<StocksProvider>(context, listen: false);
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

SingleChildScrollView stockDetails(
    BuildContext context, Result stock, TrackballBehavior trackballBehavior) {
  final provider = Provider.of<StocksProvider>(context);
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
          height: 85,
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

        Consumer<StocksProvider>(
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
        buyStock(context, stock),
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
        Row(
          children: [
            marketcap(stock),
            Expanded(child: Container()),
            dividend(stock),
          ],
        ),
        const SizedBox(height: 10),
        peRatio(stock),
        const SizedBox(height: 10),
        const Divider(
          thickness: 4,
        ),
        const SizedBox(height: 10),
        // revenueReport(context, stocks, index),
        const SizedBox(height: 10),
      ],
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

SizedBox stockChart(
    TrackballBehavior trackballBehavior, List<ChartModel>? itemChart) {
  return SizedBox(
    height: 200,
    width: 311,
    child: SfCartesianChart(
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
          emptyPointSettings: const EmptyPointSettings(
              // Mode of empty point
              mode: EmptyPointMode.average),
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

ElevatedButton revenueReport(BuildContext context, stocks, index) {
  return ElevatedButton(
    onPressed: () {
      openRevenueDialog(context, stocks[index].iconPath, stocks[index].name);
    },
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.all(0),
      backgroundColor:
          Colors.transparent, // Set the background color to transparent
      elevation: 0, // Remove the elevation
    ),
    child: Container(
      alignment: Alignment.center,
      height: 50,
      width: 220,
      decoration: BoxDecoration(
        color: yellow,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: orangeRed,
          width: 3,
        ),
      ),
      child: const StrokeText(
        text: 'VIEW REVENUE GROWTH',
        textStyle: TextStyle(
          fontSize: 18,
          color: white,
          letterSpacing: 1,
        ),
        strokeColor: black,
        strokeWidth: 4,
      ),
    ),
  );
}

Container peRatio(Result stock) {
  return Container(
    width: 200,
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
          'Price-to-Earnings-to-Growth (PEG) Ratio',
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
          stock.pegRatio.toString(),
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'Helvetica',
            fontSize: 16,
            color: red,
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
  return Container(
    width: 150,
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
          style: const TextStyle(
            fontFamily: 'Helvetica',
            fontSize: 16,
            color: red,
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
  return Container(
    width: 150,
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
          style: const TextStyle(
            fontFamily: 'Helvetica',
            fontSize: 16,
            color: green,
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
        child: Container(
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
              scale: 1.0, // Adjust the scale factor to make the image smaller
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
        left: 80,
        top: 5,
        child: SizedBox(
          height: 80,
          width: 218,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              stock.longName ?? '',
              textAlign: TextAlign.left,
              maxLines: 3,
              style: const TextStyle(
                fontSize: 22,
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

ElevatedButton sellStock(BuildContext context, Result stock) {
  return ElevatedButton(
    onPressed: () {
      openSellDialog(context, stock, 'stock');
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
      openBuyDialog(context, stock, 'stock');
    },
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.all(0),
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
    child: Container(
      alignment: Alignment.center,
      height: 40,
      width: 311,
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
