import 'package:investor_simulator/models/crypto_model.dart';
import 'package:investor_simulator/models/stocks_model.dart';
import 'package:investor_simulator/models/etf_model.dart' as etf;
import 'package:investor_simulator/models/forex_model.dart' as forex;

class StockInvestment {
  final Result stock;
  int shares;
  final double purchasePrice;
  final DateTime purchaseDate;

  StockInvestment({
    required this.stock,
    required this.shares,
    required this.purchasePrice,
    required this.purchaseDate,
  });

  double get currentValue {
    // Calculate the current value based on the current market price of the stock
    // You might need to implement a method to fetch the current market price
    double? currentMarketPrice = stock.regularMarketPrice;
    return shares * currentMarketPrice!;
  }
}

class ETFInvestment {
  final etf.Result stock;
  int shares;
  final double purchasePrice;
  final DateTime purchaseDate;

  ETFInvestment({
    required this.stock,
    required this.shares,
    required this.purchasePrice,
    required this.purchaseDate,
  });

  double get currentValue {
    // Calculate the current value based on the current market price of the stock
    // You might need to implement a method to fetch the current market price
    double? currentMarketPrice = stock.regularMarketPrice;
    return shares * currentMarketPrice!;
  }
}

class ForexInvestment {
  final forex.Result stock;
  int shares;
  final double purchasePrice;
  final DateTime purchaseDate;

  ForexInvestment({
    required this.stock,
    required this.shares,
    required this.purchasePrice,
    required this.purchaseDate,
  });

  double get currentValue {
    // Calculate the current value based on the current market price of the stock
    // You might need to implement a method to fetch the current market price
    double? currentMarketPrice = stock.regularMarketPrice;
    return shares * currentMarketPrice;
  }
}

class CryptoInvestment {
  final CoinModel stock;
  int shares;
  final double purchasePrice;
  final DateTime purchaseDate;

  CryptoInvestment({
    required this.stock,
    required this.shares,
    required this.purchasePrice,
    required this.purchaseDate,
  });

  double get currentValue {
    // Calculate the current value based on the current market price of the cryptocurrency
    // You might need to implement a method to fetch the current market price
    double currentMarketPrice = stock.regularMarketPrice;
    return shares * currentMarketPrice;
  }
}
