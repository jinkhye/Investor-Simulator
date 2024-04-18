// To parse this JSON data, do
//
//     final forexModel = forexModelFromJson(jsonString);

import 'dart:convert';

ForexModel forexModelFromJson(String str) =>
    ForexModel.fromJson(json.decode(str));

String forexModelToJson(ForexModel data) => json.encode(data.toJson());

class ForexModel {
  QuoteResponse quoteResponse;

  ForexModel({
    required this.quoteResponse,
  });

  factory ForexModel.fromJson(Map<String, dynamic> json) => ForexModel(
        quoteResponse: QuoteResponse.fromJson(json["quoteResponse"]),
      );

  Map<String, dynamic> toJson() => {
        "quoteResponse": quoteResponse.toJson(),
      };
}

class QuoteResponse {
  List<Result> result;

  QuoteResponse({
    required this.result,
  });

  factory QuoteResponse.fromJson(Map<String, dynamic> json) => QuoteResponse(
        result:
            List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
      };
}

class Result {
  final String type = 'forex';
  // String language;
  // String region;
  // String quoteType;
  // String typeDisp;
  // String quoteSourceName;
  // bool triggerable;
  // String customPriceAlertConfidence;
  // String currency;
  // double regularMarketChange;
  double regularMarketChangePercent;
  double regularMarketPrice;
  // double regularMarketDayHigh;
  // double regularMarketDayLow;
  // double regularMarketPreviousClose;
  // double bid;
  // double ask;
  // String shortName;
  String longName;
  // double regularMarketOpen;
  // double fiftyTwoWeekLow;
  // double fiftyTwoWeekHigh;
  // double fiftyDayAverage;
  // double twoHundredDayAverage;
  // bool hasPrePostMarketData;
  // int firstTradeDateMilliseconds;
  // int priceHint;
  // int regularMarketTime;
  // String regularMarketDayRange;
  // int regularMarketVolume;
  // int bidSize;
  // int askSize;
  // String exchange;
  // String market;
  // String messageBoardId;
  // String fullExchangeName;
  int averageDailyVolume3Month;
  // int averageDailyVolume10Day;
  // double fiftyTwoWeekLowChange;
  // double fiftyTwoWeekLowChangePercent;
  String fiftyTwoWeekRange;
  // double fiftyTwoWeekHighChange;
  // double fiftyTwoWeekHighChangePercent;
  String marketState;
  // double fiftyDayAverageChange;
  // double fiftyDayAverageChangePercent;
  // double twoHundredDayAverageChange;
  // double twoHundredDayAverageChangePercent;
  // int sourceInterval;
  // int exchangeDataDelayedBy;
  // String exchangeTimezoneName;
  // String exchangeTimezoneShortName;
  // int gmtOffSetMilliseconds;
  // bool esgPopulated;
  // bool tradeable;
  // bool cryptoTradeable;
  String symbol;

  Result({
    // required this.language,
    // required this.region,
    // required this.quoteType,
    // required this.typeDisp,
    // required this.quoteSourceName,
    // required this.triggerable,
    // required this.customPriceAlertConfidence,
    // required this.currency,
    // required this.regularMarketChange,
    required this.regularMarketChangePercent,
    required this.regularMarketPrice,
    // required this.regularMarketDayHigh,
    // required this.regularMarketDayLow,
    // required this.regularMarketPreviousClose,
    // required this.bid,
    // required this.ask,
    // required this.shortName,
    required this.longName,
    // required this.regularMarketOpen,
    // required this.fiftyTwoWeekLow,
    // required this.fiftyTwoWeekHigh,
    // required this.fiftyDayAverage,
    // required this.twoHundredDayAverage,
    // required this.hasPrePostMarketData,
    // required this.firstTradeDateMilliseconds,
    // required this.priceHint,
    // required this.regularMarketTime,
    // required this.regularMarketDayRange,
    // required this.regularMarketVolume,
    // required this.bidSize,
    // required this.askSize,
    // required this.exchange,
    // required this.market,
    // required this.messageBoardId,
    // required this.fullExchangeName,
    required this.averageDailyVolume3Month,
    // required this.averageDailyVolume10Day,
    // required this.fiftyTwoWeekLowChange,
    // required this.fiftyTwoWeekLowChangePercent,
    required this.fiftyTwoWeekRange,
    // required this.fiftyTwoWeekHighChange,
    // required this.fiftyTwoWeekHighChangePercent,
    required this.marketState,
    // required this.fiftyDayAverageChange,
    // required this.fiftyDayAverageChangePercent,
    // required this.twoHundredDayAverageChange,
    // required this.twoHundredDayAverageChangePercent,
    // required this.sourceInterval,
    // required this.exchangeDataDelayedBy,
    // required this.exchangeTimezoneName,
    // required this.exchangeTimezoneShortName,
    // required this.gmtOffSetMilliseconds,
    // required this.esgPopulated,
    // required this.tradeable,
    // required this.cryptoTradeable,
    required this.symbol,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        // language: json["language"],
        // region: json["region"],
        // quoteType: json["quoteType"],
        // typeDisp: json["typeDisp"],
        // quoteSourceName: json["quoteSourceName"],
        // triggerable: json["triggerable"],
        // customPriceAlertConfidence: json["customPriceAlertConfidence"],
        // currency: json["currency"],
        // regularMarketChange: json["regularMarketChange"]?.toDouble(),
        regularMarketChangePercent:
            json["regularMarketChangePercent"]?.toDouble() ?? 0.0,
        regularMarketPrice: json["regularMarketPrice"]?.toDouble() ?? 0.0,
        // regularMarketDayHigh: json["regularMarketDayHigh"]?.toDouble(),
        // regularMarketDayLow: json["regularMarketDayLow"]?.toDouble(),
        // regularMarketPreviousClose:
        //     json["regularMarketPreviousClose"]?.toDouble(),
        // bid: json["bid"]?.toDouble(),
        // ask: json["ask"]?.toDouble(),
        // shortName: json["shortName"],
        longName: json["longName"]?.toString() ?? '',
        // regularMarketOpen: json["regularMarketOpen"]?.toDouble(),
        // fiftyTwoWeekLow: json["fiftyTwoWeekLow"]?.toDouble(),
        // fiftyTwoWeekHigh: json["fiftyTwoWeekHigh"]?.toDouble(),
        // fiftyDayAverage: json["fiftyDayAverage"]?.toDouble(),
        // twoHundredDayAverage: json["twoHundredDayAverage"]?.toDouble(),
        // hasPrePostMarketData: json["hasPrePostMarketData"],
        // firstTradeDateMilliseconds: json["firstTradeDateMilliseconds"],
        // priceHint: json["priceHint"],
        // regularMarketTime: json["regularMarketTime"],
        // regularMarketDayRange: json["regularMarketDayRange"],
        // regularMarketVolume: json["regularMarketVolume"],
        // bidSize: json["bidSize"],
        // askSize: json["askSize"],
        // exchange: json["exchange"],
        // market: json["market"],
        // messageBoardId: json["messageBoardId"],
        // fullExchangeName: json["fullExchangeName"],
        averageDailyVolume3Month:
            json["averageDailyVolume3Month"]?.toInt() ?? 0,
        // averageDailyVolume10Day: json["averageDailyVolume10Day"],
        // fiftyTwoWeekLowChange: json["fiftyTwoWeekLowChange"]?.toDouble(),
        // fiftyTwoWeekLowChangePercent:
        // json["fiftyTwoWeekLowChangePercent"]?.toDouble(),
        fiftyTwoWeekRange: json["fiftyTwoWeekRange"]?.toString() ?? '',
        // fiftyTwoWeekHighChange: json["fiftyTwoWeekHighChange"]?.toDouble(),
        // fiftyTwoWeekHighChangePercent:
        //     json["fiftyTwoWeekHighChangePercent"]?.toDouble(),
        marketState: json["marketState"]?.toString() ?? '',
        // fiftyDayAverageChange: json["fiftyDayAverageChange"]?.toDouble(),
        // fiftyDayAverageChangePercent:
        //     json["fiftyDayAverageChangePercent"]?.toDouble(),
        // twoHundredDayAverageChange:
        //     json["twoHundredDayAverageChange"]?.toDouble(),
        // twoHundredDayAverageChangePercent:
        //     json["twoHundredDayAverageChangePercent"]?.toDouble(),
        // sourceInterval: json["sourceInterval"],
        // exchangeDataDelayedBy: json["exchangeDataDelayedBy"],
        // exchangeTimezoneName: json["exchangeTimezoneName"],
        // exchangeTimezoneShortName: json["exchangeTimezoneShortName"],
        // gmtOffSetMilliseconds: json["gmtOffSetMilliseconds"],
        // esgPopulated: json["esgPopulated"],
        // tradeable: json["tradeable"],
        // cryptoTradeable: json["cryptoTradeable"],
        symbol: json["symbol"]?.toString() ?? '',
      );

  Map<String, dynamic> toJson() => {
        // "language": language,
        // "region": region,
        // "quoteType": quoteType,
        // "typeDisp": typeDisp,
        // "quoteSourceName": quoteSourceName,
        // "triggerable": triggerable,
        // "customPriceAlertConfidence": customPriceAlertConfidence,
        // "currency": currency,
        // "regularMarketChange": regularMarketChange,
        "regularMarketChangePercent": regularMarketChangePercent,
        "regularMarketPrice": regularMarketPrice,
        // "regularMarketDayHigh": regularMarketDayHigh,
        // "regularMarketDayLow": regularMarketDayLow,
        // "regularMarketPreviousClose": regularMarketPreviousClose,
        // "bid": bid,
        // "ask": ask,
        // "shortName": shortName,
        "longName": longName,
        // "regularMarketOpen": regularMarketOpen,
        // "fiftyTwoWeekLow": fiftyTwoWeekLow,
        // "fiftyTwoWeekHigh": fiftyTwoWeekHigh,
        // "fiftyDayAverage": fiftyDayAverage,
        // "twoHundredDayAverage": twoHundredDayAverage,
        // "hasPrePostMarketData": hasPrePostMarketData,
        // "firstTradeDateMilliseconds": firstTradeDateMilliseconds,
        // "priceHint": priceHint,
        // "regularMarketTime": regularMarketTime,
        // "regularMarketDayRange": regularMarketDayRange,
        // "regularMarketVolume": regularMarketVolume,
        // "bidSize": bidSize,
        // "askSize": askSize,
        // "exchange": exchange,
        // "market": market,
        // "messageBoardId": messageBoardId,
        // "fullExchangeName": fullExchangeName,
        "averageDailyVolume3Month": averageDailyVolume3Month,
        // "averageDailyVolume10Day": averageDailyVolume10Day,
        // "fiftyTwoWeekLowChange": fiftyTwoWeekLowChange,
        // "fiftyTwoWeekLowChangePercent": fiftyTwoWeekLowChangePercent,
        "fiftyTwoWeekRange": fiftyTwoWeekRange,
        // "fiftyTwoWeekHighChange": fiftyTwoWeekHighChange,
        // "fiftyTwoWeekHighChangePercent": fiftyTwoWeekHighChangePercent,
        "marketState": marketState,
        // "fiftyDayAverageChange": fiftyDayAverageChange,
        // "fiftyDayAverageChangePercent": fiftyDayAverageChangePercent,
        // "twoHundredDayAverageChange": twoHundredDayAverageChange,
        // "twoHundredDayAverageChangePercent": twoHundredDayAverageChangePercent,
        // "sourceInterval": sourceInterval,
        // "exchangeDataDelayedBy": exchangeDataDelayedBy,
        // "exchangeTimezoneName": exchangeTimezoneName,
        // "exchangeTimezoneShortName": exchangeTimezoneShortName,
        // "gmtOffSetMilliseconds": gmtOffSetMilliseconds,
        // "esgPopulated": esgPopulated,
        // "tradeable": tradeable,
        // "cryptoTradeable": cryptoTradeable,
        "symbol": symbol,
      };
}
