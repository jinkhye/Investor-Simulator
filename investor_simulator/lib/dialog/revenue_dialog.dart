import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:investor_simulator/constant/color.dart';
import 'package:investor_simulator/models/stocks_model.dart';
import 'package:stroke_text/stroke_text.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void openRevenueDialog(BuildContext context, Result stock) {
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
              width: 400,
              height: 600,
              padding: const EdgeInsets.all(10), // Adjust padding as needed
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Container(
                      width: 350,
                      color: Colors.transparent,
                      child: Stack(
                        children: [
                          Positioned(
                              top: -2, left: -10, child: revenueBack(context)),
                          Align(
                              alignment: Alignment.center,
                              child: revenueText("REVENUE GROWTH")),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                        width: 400,
                        height: 100,
                        color: Colors.transparent,
                        child: stockDetailsLogoName(context, stock)),
                    const SizedBox(
                      height: 15,
                    ),
                    const Divider(
                      thickness: 4,
                    ),
                    const Text(
                      'QUARTERLY EARNINGS',
                      style: TextStyle(
                        fontSize: 23,
                        color: purple,
                      ),
                    ),
                    quarterlyChart(trackballBehavior,
                        stock.quoteSummary.earnings.earningsChart.quarterly),
                    const Divider(
                      thickness: 4,
                    ),
                    const Text(
                      'YEARLY FINANCIALS',
                      style: TextStyle(
                        fontSize: 23,
                        color: purple,
                      ),
                    ),
                    yearlyChart(trackballBehavior,
                        stock.quoteSummary.earnings.financialsChart.yearly),
                    const Divider(
                      thickness: 4,
                    ),
                    const Text(
                      'QUARTERLY FINANCIALS',
                      style: TextStyle(
                        fontSize: 23,
                        color: purple,
                      ),
                    ),
                    quarterlyFinancialChart(trackballBehavior,
                        stock.quoteSummary.earnings.financialsChart.quarterly),
                    const Divider(
                      thickness: 4,
                    ),
                    const Text(
                      'REVENUE REPORT',
                      style: TextStyle(
                        fontSize: 25,
                        color: purple,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          fontFamily: 'Helvetica',
                          letterSpacing: 0,
                          wordSpacing: 0,
                          fontSize: 20,
                          color: black,
                          fontWeight: FontWeight.w600,
                        ),
                        children: [
                          TextSpan(
                            text: 'Quarterly Earnings:\n\n',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w800),
                          ),
                          TextSpan(
                            text:
                                'This section provides information about the company\'s earnings per share (EPS) for each quarter. It helps investors assess the company\'s profitability over time and compare its performance from one quarter to another.',
                            style: TextStyle(
                              fontFamily: 'Helvetica',
                              letterSpacing: 0,
                              wordSpacing: 0,
                              fontSize: 16,
                              color: black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: '\n\nYearly Financials:\n\n',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w800),
                          ),
                          TextSpan(
                            text:
                                'This section includes data on the company\'s revenue and earnings for different years. It allows investors to evaluate the company\'s overall financial performance across multiple years and identify long-term trends.',
                            style: TextStyle(
                              fontFamily: 'Helvetica',
                              letterSpacing: 0,
                              wordSpacing: 0,
                              fontSize: 16,
                              color: black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: '\n\nQuarterly Financials:\n\n',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w800),
                          ),
                          TextSpan(
                            text:
                                'This section shows the company\'s revenue and earnings for each quarter. It helps investors analyze how the company performs throughout the year and identify seasonal patterns or fluctuations in the company\'s financial health.',
                            style: TextStyle(
                              fontFamily: 'Helvetica',
                              letterSpacing: 0,
                              wordSpacing: 0,
                              fontSize: 16,
                              color: black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}

SizedBox quarterlyFinancialChart(TrackballBehavior trackballBehavior,
    List<FinancialsChartQuarterly> itemChart) {
  return SizedBox(
    height: 200,
    width: 311,
    child: SfCartesianChart(
      legend: const Legend(
          textStyle: TextStyle(
              fontFamily: 'Helvetica',
              fontSize: 12,
              fontWeight: FontWeight.w600),
          isVisible: true,
          position: LegendPosition.bottom,
          toggleSeriesVisibility: false),
      palette: const <Color>[Color(0xFF1E90FF), Color(0xFFFF69B4)],
      trackballBehavior: trackballBehavior,
      zoomPanBehavior:
          ZoomPanBehavior(enablePinching: true, zoomMode: ZoomMode.x),
      primaryXAxis: const CategoryAxis(
        interval: 1,
        labelStyle: TextStyle(
            fontFamily: 'Helvetica', fontSize: 12, fontWeight: FontWeight.w600),
      ),
      primaryYAxis: NumericAxis(
        numberFormat: NumberFormat.compactSimpleCurrency(),
        decimalPlaces: 2,
        isVisible: false,
        labelStyle: const TextStyle(
            fontFamily: 'Helvetica', fontSize: 12, fontWeight: FontWeight.w600),
      ),
      series: <BarSeries<FinancialsChartQuarterly, String>>[
        BarSeries<FinancialsChartQuarterly, String>(
          name: 'Revenue',
          enableTooltip: true,
          dataLabelSettings: const DataLabelSettings(
              isVisible: true,
              useSeriesColor: false,
              textStyle: TextStyle(
                  fontFamily: 'Helvetica',
                  fontSize: 12,
                  fontWeight: FontWeight.w600)),
          dataSource: itemChart,
          xValueMapper: (FinancialsChartQuarterly data, _) =>
              data.date.toString(),
          yValueMapper: (FinancialsChartQuarterly data, _) => data.revenue,
          animationDuration: 55,
        ),
        BarSeries<FinancialsChartQuarterly, String>(
          name: 'Earnings',
          enableTooltip: true,
          dataLabelSettings: const DataLabelSettings(
              isVisible: true,
              useSeriesColor: false,
              textStyle: TextStyle(
                  fontFamily: 'Helvetica',
                  fontSize: 12,
                  fontWeight: FontWeight.w600)),
          dataSource: itemChart,
          xValueMapper: (FinancialsChartQuarterly data, _) =>
              data.date.toString(),
          yValueMapper: (FinancialsChartQuarterly data, _) => data.earnings,
          animationDuration: 55,
        ),
      ],
    ),
  );
}

SizedBox yearlyChart(
    TrackballBehavior trackballBehavior, List<Yearly> itemChart) {
  return SizedBox(
    height: 200,
    width: 311,
    child: SfCartesianChart(
      legend: const Legend(
          textStyle: TextStyle(
              fontFamily: 'Helvetica',
              fontSize: 12,
              fontWeight: FontWeight.w600),
          isVisible: true,
          position: LegendPosition.bottom,
          toggleSeriesVisibility: false),
      palette: const <Color>[Colors.teal, Colors.orange],
      trackballBehavior: trackballBehavior,
      zoomPanBehavior:
          ZoomPanBehavior(enablePinching: true, zoomMode: ZoomMode.x),
      primaryXAxis: const CategoryAxis(
        interval: 1,
        labelStyle: TextStyle(
            fontFamily: 'Helvetica', fontSize: 12, fontWeight: FontWeight.w600),
      ),
      primaryYAxis: NumericAxis(
        numberFormat: NumberFormat.compactSimpleCurrency(),
        decimalPlaces: 2,
        isVisible: false,
        labelStyle: const TextStyle(
            fontFamily: 'Helvetica', fontSize: 12, fontWeight: FontWeight.w600),
      ),
      series: <BarSeries<Yearly, String>>[
        BarSeries<Yearly, String>(
          name: 'Revenue',
          enableTooltip: true,
          dataLabelSettings: const DataLabelSettings(
              isVisible: true,
              useSeriesColor: false,
              textStyle: TextStyle(
                  fontFamily: 'Helvetica',
                  fontSize: 12,
                  fontWeight: FontWeight.w600)),
          dataSource: itemChart,
          xValueMapper: (Yearly data, _) => data.date.toString(),
          yValueMapper: (Yearly data, _) => data.revenue,
          animationDuration: 55,
        ),
        BarSeries<Yearly, String>(
          name: 'Earnings',
          enableTooltip: true,
          dataLabelSettings: const DataLabelSettings(
              isVisible: true,
              useSeriesColor: false,
              textStyle: TextStyle(
                  fontFamily: 'Helvetica',
                  fontSize: 12,
                  fontWeight: FontWeight.w600)),
          dataSource: itemChart,
          xValueMapper: (Yearly data, _) => data.date.toString(),
          yValueMapper: (Yearly data, _) => data.earnings,
          animationDuration: 55,
        ),
      ],
    ),
  );
}

SizedBox quarterlyChart(TrackballBehavior trackballBehavior,
    List<EarningsChartQuarterly> itemChart) {
  return SizedBox(
    height: 200,
    width: 311,
    child: SfCartesianChart(
      palette: const <Color>[Colors.teal],
      trackballBehavior: trackballBehavior,
      zoomPanBehavior:
          ZoomPanBehavior(enablePinching: true, zoomMode: ZoomMode.x),
      primaryXAxis: const CategoryAxis(
        interval: 1,
        labelStyle: TextStyle(
            fontFamily: 'Helvetica', fontSize: 12, fontWeight: FontWeight.w600),
      ),
      primaryYAxis: NumericAxis(
        numberFormat: NumberFormat.compactSimpleCurrency(),
        isVisible: false,
        decimalPlaces: 2,
        labelStyle: const TextStyle(
            fontFamily: 'Helvetica', fontSize: 12, fontWeight: FontWeight.w600),
      ),
      series: <CartesianSeries>[
        LineSeries<EarningsChartQuarterly, String>(
          enableTooltip: true,
          dataLabelSettings: const DataLabelSettings(
              isVisible: true,
              useSeriesColor: true,
              textStyle: TextStyle(
                  fontFamily: 'Helvetica',
                  fontSize: 12,
                  fontWeight: FontWeight.w600)),
          dataSource: itemChart,
          xValueMapper: (EarningsChartQuarterly data, _) => data.date,
          yValueMapper: (EarningsChartQuarterly data, _) => data.actual,
          animationDuration: 55,
        )
      ],
    ),
  );
}

StrokeText revenueText(String text) {
  return StrokeText(
    text: text,
    textStyle: const TextStyle(fontSize: 30, color: yellow),
    strokeColor: darkPurple,
    strokeWidth: 7,
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

GestureDetector revenueBack(BuildContext context) {
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
          Icons.arrow_back_ios_new_rounded,
          color: Colors.black,
          size: 30, // Adjust the size of the icon as needed
        ),
      ),
    ),
  );
}
