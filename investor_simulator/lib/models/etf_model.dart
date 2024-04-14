// To parse this JSON data, do
//
//     final stocksModel = stocksModelFromJson(jsonString);

import 'dart:convert';

ETFModel stocksModelFromJson(String str) =>
    ETFModel.fromJson(json.decode(str) as Map<String, dynamic>);

String stocksModelToJson(ETFModel data) => json.encode(data.toJson());

class ETFModel {
  final QuoteResponse quoteResponse;

  ETFModel({
    required this.quoteResponse,
  });

  factory ETFModel.fromJson(Map<String, dynamic> json) => ETFModel(
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
  final String type = 'etf';
  final double? regularMarketChangePercent;
  final double? regularMarketPrice;
  final String? longName;
  final double? pegRatio;
  final double? dividendYield;
  final int? marketCap;
  final String? symbol;

  Result({
    required this.regularMarketChangePercent,
    required this.regularMarketPrice,
    required this.longName,
    required this.pegRatio,
    required this.dividendYield,
    required this.marketCap,
    required this.symbol,
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
      );

  Map<String, dynamic> toJson() => {
        "regularMarketChangePercent": regularMarketChangePercent,
        "regularMarketPrice": regularMarketPrice,
        "longName": longName,
        "pegRatio": pegRatio,
        "dividendYield": dividendYield,
        "marketCap": marketCap,
        "symbol": symbol,
      };
}

// class QuoteSummary {
//   Earnings earnings;

//   QuoteSummary({
//     required this.earnings,
//   });

//   factory QuoteSummary.fromJson(Map<String, dynamic> json) => QuoteSummary(
//         earnings: Earnings.fromJson(json["earnings"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "earnings": earnings.toJson(),
//       };
// }

// class Earnings {
//   FinancialsChart financialsChart;

//   Earnings({
//     required this.financialsChart,
//   });

//   factory Earnings.fromJson(Map<String, dynamic> json) => Earnings(
//         financialsChart: FinancialsChart.fromJson(json["financialsChart"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "financialsChart": financialsChart.toJson(),
//       };
// }

// class FinancialsChart {
//   List<Yearly> yearly;
//   List<FinancialsChartQuarterly> quarterly;

//   FinancialsChart({
//     required this.yearly,
//     required this.quarterly,
//   });

//   factory FinancialsChart.fromJson(Map<String, dynamic> json) =>
//       FinancialsChart(
//         yearly:
//             List<Yearly>.from(json["yearly"].map((x) => Yearly.fromJson(x))),
//         quarterly: List<FinancialsChartQuarterly>.from(
//             json["quarterly"].map((x) => FinancialsChartQuarterly.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "yearly": List<dynamic>.from(yearly.map((x) => x.toJson())),
//         "quarterly": List<dynamic>.from(quarterly.map((x) => x.toJson())),
//       };
// }

// class FinancialsChartQuarterly {
//   String? date;
//   int? revenue;
//   int? earnings;

//   FinancialsChartQuarterly({
//     required this.date,
//     required this.revenue,
//     required this.earnings,
//   });

//   factory FinancialsChartQuarterly.fromJson(Map<String, dynamic> json) =>
//       FinancialsChartQuarterly(
//         date: json["date"]?.toString() ?? '',
//         revenue: json["revenue"] as int?,
//         earnings: json["earnings"] as int?,
//       );

//   Map<String, dynamic> toJson() => {
//         "date": date,
//         "revenue": revenue,
//         "earnings": earnings,
//       };
// }

// class Yearly {
//   int? date;
//   int? revenue;
//   int? earnings;

//   Yearly({
//     required this.date,
//     required this.revenue,
//     required this.earnings,
//   });

//   factory Yearly.fromJson(Map<String, dynamic> json) => Yearly(
//         date: json["date"] as int?,
//         revenue: json["revenue"] as int?,
//         earnings: json["earnings"] as int?,
//       );

//   Map<String, dynamic> toJson() => {
//         "date": date,
//         "revenue": revenue,
//         "earnings": earnings,
//       };
// }
