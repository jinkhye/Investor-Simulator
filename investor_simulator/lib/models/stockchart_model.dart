// To parse this JSON data, do
//
//     final stocksChartModel = stocksChartModelFromJson(jsonString);

import 'dart:convert';

StocksChartModel stocksChartModelFromJson(String str) =>
    StocksChartModel.fromJson(json.decode(str));

String stocksChartModelToJson(StocksChartModel data) =>
    json.encode(data.toJson());

class StocksChartModel {
  Chart chart;

  StocksChartModel({
    required this.chart,
  });

  factory StocksChartModel.fromJson(Map<String, dynamic> json) =>
      StocksChartModel(
        chart: Chart.fromJson(json["chart"]),
      );

  Map<String, dynamic> toJson() => {
        "chart": chart.toJson(),
      };
}

class Chart {
  List<ChartResult> result;
  dynamic error;

  Chart({
    required this.result,
    required this.error,
  });

  factory Chart.fromJson(Map<String, dynamic> json) => Chart(
        result: List<ChartResult>.from(
            json["result"].map((x) => ChartResult.fromJson(x))),
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
        "error": error,
      };
}

class ChartResult {
  List<int> timestamp;
  Indicators indicators;
  dynamic error;

  ChartResult({
    required this.timestamp,
    required this.indicators,
    required this.error,
  });

  factory ChartResult.fromJson(Map<String, dynamic> json) => ChartResult(
        timestamp: List<int>.from(json["timestamp"].map((x) => x)),
        indicators: Indicators.fromJson(json["indicators"]),
        error: null,
      );

  Map<String, dynamic> toJson() => {
        "timestamp": List<dynamic>.from(timestamp.map((x) => x)),
        "indicators": indicators.toJson(),
      };
}

class Indicators {
  List<Quote> quote;

  Indicators({
    required this.quote,
  });

  factory Indicators.fromJson(Map<String, dynamic> json) => Indicators(
        quote: List<Quote>.from(json["quote"].map((x) => Quote.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "quote": List<dynamic>.from(quote.map((x) => x.toJson())),
      };
}

class Quote {
  List<double> open;
  List<double> close;
  List<double> low;
  List<double> high;
  // List<int> volume;

  Quote({
    required this.open,
    required this.close,
    required this.low,
    required this.high,
    // required this.volume,
  });

  factory Quote.fromJson(Map<String, dynamic> json) => Quote(
        open: List<double>.from(json["open"].map((x) => x?.toDouble() ?? 0.0)),
        close:
            List<double>.from(json["close"].map((x) => x?.toDouble() ?? 0.0)),
        low: List<double>.from(json["low"].map((x) => x?.toDouble() ?? 0.0)),
        high: List<double>.from(json["high"].map((x) => x?.toDouble() ?? 0.0)),
        // volume: List<int>.from(json["volume"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "open": List<dynamic>.from(open.map((x) => x)),
        "close": List<dynamic>.from(close.map((x) => x)),
        "low": List<dynamic>.from(low.map((x) => x)),
        "high": List<dynamic>.from(high.map((x) => x)),
        // "volume": List<dynamic>.from(volume.map((x) => x)),
      };
}
