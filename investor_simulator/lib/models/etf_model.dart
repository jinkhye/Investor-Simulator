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
  final double preMarketPrice;
  final double priceToBook;
  final String marketState;

  Result({
    required this.regularMarketChangePercent,
    required this.regularMarketPrice,
    required this.longName,
    required this.pegRatio,
    required this.dividendYield,
    required this.marketCap,
    required this.symbol,
    required this.preMarketPrice,
    required this.priceToBook,
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
        preMarketPrice: json["preMarketPrice"]?.toDouble() ?? 0.0,
        priceToBook: json["priceToBook"]?.toDouble() ?? 0.0,
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
        "preMarketPrice": preMarketPrice,
        "priceToBook": priceToBook,
        "marketState": marketState,
      };
}
