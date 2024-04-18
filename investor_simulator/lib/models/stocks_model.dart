// To parse this JSON data, do
//
//     final stocksModel = stocksModelFromJson(jsonString);

import 'dart:convert';

StocksModel stocksModelFromJson(String str) =>
    StocksModel.fromJson(json.decode(str) as Map<String, dynamic>);

String stocksModelToJson(StocksModel data) => json.encode(data.toJson());

class StocksModel {
  final QuoteResponse quoteResponse;

  StocksModel({
    required this.quoteResponse,
  });

  factory StocksModel.fromJson(Map<String, dynamic> json) => StocksModel(
        quoteResponse: QuoteResponse.fromJson(
            json["quoteResponse"] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        "quoteResponse": quoteResponse.toJson(),
      };
}

class QuoteResponse {
  final List<Result> result;
  final dynamic error;

  QuoteResponse({
    required this.result,
    required this.error,
  });

  factory QuoteResponse.fromJson(Map<String, dynamic> json) => QuoteResponse(
        result: List<Result>.from(
            json["result"].map((x) => Result.fromJson(x)) as Iterable<dynamic>),
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
        "error": error,
      };
}

class Result {
  final String type = 'stock';
  final double? regularMarketChangePercent;
  final double? regularMarketPrice;
  final String? longName;
  final double? pegRatio;
  final double? dividendYield;
  final int? marketCap;
  final String? symbol;
  final double preMarketPrice;
  final double priceToBook;
  final double forwardPE;
  final String marketState;
  QuoteSummary quoteSummary;

  Result({
    required this.regularMarketChangePercent,
    required this.regularMarketPrice,
    required this.longName,
    required this.pegRatio,
    required this.dividendYield,
    required this.marketCap,
    required this.symbol,
    required this.quoteSummary,
    required this.preMarketPrice,
    required this.priceToBook,
    required this.forwardPE,
    required this.marketState,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        regularMarketChangePercent:
            json["regularMarketChangePercent"]?.toDouble() ?? 0.0,
        regularMarketPrice: json["regularMarketPrice"]?.toDouble() ?? 0.0,
        longName: json["longName"]?.toString() ?? '',
        pegRatio: json["pegRatio"]?.toDouble() ?? 0.0,
        dividendYield: json["dividendYield"]?.toDouble() ?? 0.0,
        marketCap: json["marketCap"]?.toInt() ?? 0,
        symbol: json["symbol"]?.toString() ?? '',
        quoteSummary: QuoteSummary.fromJson(json["quoteSummary"]),
        preMarketPrice: json["preMarketPrice"]?.toDouble() ?? 0.0,
        priceToBook: json["priceToBook"]?.toDouble() ?? 0.0,
        forwardPE: json["forwardPE"]?.toDouble() ?? 0.0,
        marketState: json["marketState"]?.toString() ?? '',
      );

  Map<String, dynamic> toJson() => {
        "regularMarketChangePercent": regularMarketChangePercent,
        "regularMarketPrice": regularMarketPrice,
        "longName": longName,
        "pegRatio": pegRatio,
        "dividendYield": dividendYield,
        "marketCap": marketCap,
        "symbol": symbol,
        "quoteSummary": quoteSummary.toJson(),
        "preMarketPrice": preMarketPrice,
        "priceToBook": priceToBook,
        "forwardPE": forwardPE,
        "marketState": marketState,
      };
}

class QuoteSummary {
  Earnings earnings;

  QuoteSummary({
    required this.earnings,
  });

  factory QuoteSummary.fromJson(Map<String, dynamic> json) => QuoteSummary(
        earnings: Earnings.fromJson(json["earnings"]),
      );

  Map<String, dynamic> toJson() => {
        "earnings": earnings.toJson(),
      };
}

class Earnings {
  EarningsChart earningsChart;
  FinancialsChart financialsChart;

  Earnings({
    required this.earningsChart,
    required this.financialsChart,
  });

  factory Earnings.fromJson(Map<String, dynamic> json) => Earnings(
        earningsChart: EarningsChart.fromJson(json["earningsChart"]),
        financialsChart: FinancialsChart.fromJson(json["financialsChart"]),
      );

  Map<String, dynamic> toJson() => {
        "earningsChart": earningsChart.toJson(),
        "financialsChart": financialsChart.toJson(),
      };
}

class EarningsChart {
  List<EarningsChartQuarterly> quarterly;
  double currentQuarterEstimate;
  String currentQuarterEstimateDate;
  int currentQuarterEstimateYear;
  List<int> earningsDate;

  EarningsChart({
    required this.quarterly,
    required this.currentQuarterEstimate,
    required this.currentQuarterEstimateDate,
    required this.currentQuarterEstimateYear,
    required this.earningsDate,
  });

  factory EarningsChart.fromJson(Map<String, dynamic> json) => EarningsChart(
        quarterly: List<EarningsChartQuarterly>.from(
            json["quarterly"].map((x) => EarningsChartQuarterly.fromJson(x))),
        currentQuarterEstimate:
            json["currentQuarterEstimate"]?.toDouble() ?? 0.0,
        currentQuarterEstimateDate:
            json["currentQuarterEstimateDate"]?.toString() ?? '',
        currentQuarterEstimateYear:
            json["currentQuarterEstimateYear"]?.toInt() ?? 0,
        earningsDate: List<int>.from(json["earningsDate"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "quarterly": List<dynamic>.from(quarterly.map((x) => x.toJson())),
        "currentQuarterEstimate": currentQuarterEstimate,
        "currentQuarterEstimateDate": currentQuarterEstimateDate,
        "currentQuarterEstimateYear": currentQuarterEstimateYear,
        "earningsDate": List<dynamic>.from(earningsDate.map((x) => x)),
      };
}

class EarningsChartQuarterly {
  String date;
  double actual;
  double estimate;

  EarningsChartQuarterly({
    required this.date,
    required this.actual,
    required this.estimate,
  });

  factory EarningsChartQuarterly.fromJson(Map<String, dynamic> json) =>
      EarningsChartQuarterly(
        date: json["date"]?.toString() ?? '',
        actual: json["actual"]?.toDouble() ?? 0.0,
        estimate: json["estimate"]?.toDouble() ?? 0.0,
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "actual": actual,
        "estimate": estimate,
      };
}

class FinancialsChart {
  List<Yearly> yearly;
  List<FinancialsChartQuarterly> quarterly;

  FinancialsChart({
    required this.yearly,
    required this.quarterly,
  });

  factory FinancialsChart.fromJson(Map<String, dynamic> json) =>
      FinancialsChart(
        yearly:
            List<Yearly>.from(json["yearly"].map((x) => Yearly.fromJson(x))),
        quarterly: List<FinancialsChartQuarterly>.from(
            json["quarterly"].map((x) => FinancialsChartQuarterly.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "yearly": List<dynamic>.from(yearly.map((x) => x.toJson())),
        "quarterly": List<dynamic>.from(quarterly.map((x) => x.toJson())),
      };
}

class FinancialsChartQuarterly {
  String date;
  int revenue;
  int earnings;

  FinancialsChartQuarterly({
    required this.date,
    required this.revenue,
    required this.earnings,
  });

  factory FinancialsChartQuarterly.fromJson(Map<String, dynamic> json) =>
      FinancialsChartQuarterly(
        date: json["date"]?.toString() ?? '',
        revenue: json["revenue"]?.toInt() ?? 0,
        earnings: json["earnings"]?.toInt() ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "revenue": revenue,
        "earnings": earnings,
      };
}

class Yearly {
  int date;
  int revenue;
  int earnings;

  Yearly({
    required this.date,
    required this.revenue,
    required this.earnings,
  });

  factory Yearly.fromJson(Map<String, dynamic> json) => Yearly(
        date: json["date"]?.toInt() ?? 0,
        revenue: json["revenue"]?.toInt() ?? 0,
        earnings: json["earnings"]?.toInt() ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "revenue": revenue,
        "earnings": earnings,
      };
}
