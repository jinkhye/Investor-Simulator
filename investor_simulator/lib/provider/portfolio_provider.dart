import 'package:flutter/material.dart';
import 'package:investor_simulator/models/crypto_model.dart';
import 'package:investor_simulator/models/portfolio_model.dart';
import 'package:investor_simulator/models/stocks_model.dart';
import 'package:investor_simulator/models/etf_model.dart' as etf;
import 'package:investor_simulator/models/forex_model.dart' as forex;

class PortfolioProvider extends ChangeNotifier {
  final List<StockInvestment> _stockInvestments = [];
  final List<ETFInvestment> _etfInvestments = [];
  final List<CryptoInvestment> _cryptoInvestments = [];
  final List<ForexInvestment> _forexInvestments = [];
  final Map<String, Map<String, dynamic>> _portfolio = {};
  bool isLoadingPortfolio = false;

  List<StockInvestment> get stockInvestments => _stockInvestments;
  List<ETFInvestment> get etfInvestments => _etfInvestments;
  List<CryptoInvestment> get cryptoInvestments => _cryptoInvestments;
  List<ForexInvestment> get forexInvestments => _forexInvestments;
  Map<String, Map<String, dynamic>> get portfolio => _portfolio;
  bool get loadingPortfolio => isLoadingPortfolio;

  // Method to add a stock investment and refresh the portfolio
  void addStockInvestment(Result stock, int shares) {
    StockInvestment investment = StockInvestment(
      stock: stock,
      shares: shares,
      purchasePrice: stock.regularMarketPrice!,
      purchaseDate: DateTime.now(),
    );
    _stockInvestments.add(investment);
    refreshPortfolio();
    notifyListeners();
  }

  // Method to add an ETF investment and refresh the portfolio
  void addETFInvestment(etf.Result etf, int shares) {
    ETFInvestment investment = ETFInvestment(
      stock: etf,
      shares: shares,
      purchasePrice: etf.regularMarketPrice!,
      purchaseDate: DateTime.now(),
    );
    _etfInvestments.add(investment);
    refreshPortfolio();
    notifyListeners();
  }

  // Method to add a crypto investment and refresh the portfolio
  void addCryptoInvestment(CoinModel crypto, int units) {
    CryptoInvestment investment = CryptoInvestment(
      stock: crypto,
      shares: units,
      purchasePrice: crypto.regularMarketPrice,
      purchaseDate: DateTime.now(),
    );
    _cryptoInvestments.add(investment);
    refreshPortfolio();
    notifyListeners();
  }

  // Method to add an Forex investment and refresh the portfolio
  void addForexInvestment(forex.Result forex, int shares) {
    ForexInvestment investment = ForexInvestment(
      stock: forex,
      shares: shares,
      purchasePrice: forex.regularMarketPrice,
      purchaseDate: DateTime.now(),
    );
    _forexInvestments.add(investment);
    refreshPortfolio();
    notifyListeners();
  }

  // Method to sell a stock investment
  void sellStockInvestment(String stockSymbol, int sharesToSell) {
    // Iterate through the investments list
    int i = 0;
    while (i < _stockInvestments.length && sharesToSell > 0) {
      StockInvestment investment = _stockInvestments[i];

      // Check if the current investment matches the given stock symbol
      if (investment.stock.symbol == stockSymbol) {
        // Calculate the amount to sell from this investment
        int sharesToSellFromThisInvestment = sharesToSell;

        // If the investment has fewer shares than sharesToSell, adjust the amount to sell
        if (investment.shares < sharesToSell) {
          sharesToSellFromThisInvestment = investment.shares;
        }

        // Deduct the shares to sell
        investment.shares -= sharesToSellFromThisInvestment;
        sharesToSell -= sharesToSellFromThisInvestment;

        // If no shares left, remove the investment
        if (investment.shares == 0) {
          _stockInvestments.removeAt(i);
          // Do not increment i since the list shrinks
          continue;
        }
      }

      // Increment the index
      i++;
    }

    // Refresh the portfolio and notify listeners
    refreshPortfolio();
    notifyListeners();
  }

  // Method to sell an ETF investment
  void sellETFInvestment(String etfSymbol, int sharesToSell) {
    // Iterate through the investments list
    int i = 0;
    while (i < _etfInvestments.length && sharesToSell > 0) {
      ETFInvestment investment = _etfInvestments[i];

      // Check if the current investment matches the given ETF symbol
      if (investment.stock.symbol == etfSymbol) {
        // Calculate the amount to sell from this investment
        int sharesToSellFromThisInvestment = sharesToSell;

        // If the investment has fewer shares than sharesToSell, adjust the amount to sell
        if (investment.shares < sharesToSell) {
          sharesToSellFromThisInvestment = investment.shares;
        }

        // Deduct the shares to sell
        investment.shares -= sharesToSellFromThisInvestment;
        sharesToSell -= sharesToSellFromThisInvestment;

        // If no shares left, remove the investment
        if (investment.shares == 0) {
          _etfInvestments.removeAt(i);
          // Do not increment i since the list shrinks
          continue;
        }
      }

      // Increment the index
      i++;
    }

    // Refresh the portfolio and notify listeners
    refreshPortfolio();
    notifyListeners();
  }

  // Method to sell a crypto investment
  void sellCryptoInvestment(String cryptoSymbol, int unitsToSell) {
    // Iterate through the investments list
    int i = 0;
    while (i < _cryptoInvestments.length && unitsToSell > 0) {
      CryptoInvestment investment = _cryptoInvestments[i];

      // Check if the current investment matches the given crypto symbol
      if (investment.stock.symbol == cryptoSymbol) {
        // Calculate the amount to sell from this investment
        int unitsToSellFromThisInvestment = unitsToSell;

        // If the investment has fewer shares than unitsToSell, adjust the amount to sell
        if (investment.shares < unitsToSell) {
          unitsToSellFromThisInvestment = investment.shares;
        }

        // Deduct the shares to sell
        investment.shares -= unitsToSellFromThisInvestment;
        unitsToSell -= unitsToSellFromThisInvestment;

        // If no shares left, remove the investment
        if (investment.shares == 0) {
          _cryptoInvestments.removeAt(i);
          // Do not increment i since the list shrinks
          continue;
        }
      }

      // Increment the index
      i++;
    }

    // Refresh the portfolio and notify listeners
    refreshPortfolio();
    notifyListeners();
  }

  // Method to sell an ETF investment
  void sellForexInvestment(String forexSymbol, int sharesToSell) {
    // Iterate through the investments list
    int i = 0;
    while (i < _forexInvestments.length && sharesToSell > 0) {
      ForexInvestment investment = _forexInvestments[i];

      // Check if the current investment matches the given ETF symbol
      if (investment.stock.symbol == forexSymbol) {
        // Calculate the amount to sell from this investment
        int sharesToSellFromThisInvestment = sharesToSell;

        // If the investment has fewer shares than sharesToSell, adjust the amount to sell
        if (investment.shares < sharesToSell) {
          sharesToSellFromThisInvestment = investment.shares;
        }

        // Deduct the shares to sell
        investment.shares -= sharesToSellFromThisInvestment;
        sharesToSell -= sharesToSellFromThisInvestment;

        // If no shares left, remove the investment
        if (investment.shares == 0) {
          _forexInvestments.removeAt(i);
          // Do not increment i since the list shrinks
          continue;
        }
      }

      // Increment the index
      i++;
    }

    // Refresh the portfolio and notify listeners
    refreshPortfolio();
    notifyListeners();
  }

  // Method to group investments by symbol and calculate total combined value for each symbol
  void refreshPortfolio() {
    isLoadingPortfolio = true;
    _portfolio.clear(); // Clear the current portfolio map

    // Group stock investments
    for (StockInvestment investment in _stockInvestments) {
      String? symbol = investment.stock.symbol;
      double currentValue = investment.currentValue;
      double quantity = investment.shares.toDouble();
      double purchasePrice = investment.purchasePrice;
      Result stock = investment.stock;

      if (!_portfolio.containsKey(symbol)) {
        _portfolio[symbol!] = {
          'totalValue': 0.0,
          'investments': [],
          'name': 'null',
          'quantity': 0.0,
          'date': investment.purchaseDate,
          'type': 'stock',
          'result': stock,
          'purchasePrice': purchasePrice,
        };
      }

      _portfolio[symbol]?['totalValue'] += currentValue;
      _portfolio[symbol]?['investments'].add(investment);
      _portfolio[symbol]?['name'] = investment.stock.longName;
      _portfolio[symbol]?['quantity'] += quantity;
    }

    // Group ETF investments
    for (ETFInvestment investment in _etfInvestments) {
      String? symbol = investment.stock.symbol;
      double currentValue = investment.currentValue;
      double quantity = investment.shares.toDouble();
      double purchasePrice = investment.purchasePrice;
      etf.Result stock = investment.stock;

      if (!_portfolio.containsKey(symbol)) {
        _portfolio[symbol!] = {
          'totalValue': 0.0,
          'investments': [],
          'name': 'null',
          'quantity': 0.0,
          'date': investment.purchaseDate,
          'type': 'etf',
          'result': stock,
          'purchasePrice': purchasePrice,
        };
      }

      _portfolio[symbol]?['totalValue'] += currentValue;
      _portfolio[symbol]?['investments'].add(investment);
      _portfolio[symbol]?['name'] = investment.stock.longName;
      _portfolio[symbol]?['quantity'] += quantity;
    }

    // Group crypto investments
    for (CryptoInvestment investment in _cryptoInvestments) {
      String? symbol = investment.stock.symbol;
      double currentValue = investment.currentValue;
      double quantity = investment.shares.toDouble();
      double purchasePrice = investment.purchasePrice;
      CoinModel stock = investment.stock;

      if (!_portfolio.containsKey(symbol)) {
        _portfolio[symbol] = {
          'totalValue': 0.0,
          'investments': [],
          'name': 'null',
          'quantity': 0.0,
          'date': investment.purchaseDate,
          'type': 'crypto',
          'result': stock,
          'purchasePrice': purchasePrice,
        };
      }

      _portfolio[symbol]?['totalValue'] += currentValue;
      _portfolio[symbol]?['investments'].add(investment);
      _portfolio[symbol]?['name'] = investment.stock.longName;
      _portfolio[symbol]?['quantity'] += quantity;
    }

    // Group Forex investments
    for (ForexInvestment investment in _forexInvestments) {
      String? symbol = investment.stock.symbol;
      double currentValue = investment.currentValue;
      double quantity = investment.shares.toDouble();
      double purchasePrice = investment.purchasePrice;
      forex.Result stock = investment.stock;

      if (!_portfolio.containsKey(symbol)) {
        _portfolio[symbol] = {
          'totalValue': 0.0,
          'investments': [],
          'name': 'null',
          'quantity': 0.0,
          'date': investment.purchaseDate,
          'type': 'etf',
          'result': stock,
          'purchasePrice': purchasePrice,
        };
      }

      _portfolio[symbol]?['totalValue'] += currentValue;
      _portfolio[symbol]?['investments'].add(investment);
      _portfolio[symbol]?['name'] = investment.stock.longName;
      _portfolio[symbol]?['quantity'] += quantity;
    }
  }
}
