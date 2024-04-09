import 'package:flutter/material.dart';
import 'package:investor_simulator/models/etf_model.dart';
import 'package:investor_simulator/models/portfolio_model.dart';
import 'package:investor_simulator/models/stocks_model.dart';

class GameProvider extends ChangeNotifier {
  String _imagePath = 'assets/images/area0.png';
  String _maxPath = 'assets/images/Maxtshirt.png';
  String get imagePath => _imagePath;
  String get maxPath => _maxPath;
  final List<PortfolioModel> _portfolio = [];
  List<PortfolioModel> get portfolio => _portfolio;
  double _money = 10000;
  double get money => _money;
  int _accommodationUse = 0;
  int get accommodationUse => _accommodationUse;
  int _clothesUse = 0;
  int get clothesUse => _clothesUse;
  final List<StocksModel> _stocks = StocksModel.getStocks();
  List<StocksModel> get stocks => _stocks;
  final List<ETFModel> _etf = ETFModel.getETF();
  List<ETFModel> get etf => _etf;

  void setETFAmount(int index, int amount) {
    _etf[index].amount = amount;
    notifyListeners();
  }

  void setStocksAmount(int index, int amount) {
    _stocks[index].amount = amount;
    notifyListeners();
  }

  void setClothesUse(int value) {
    _clothesUse = value;
    notifyListeners();
  }

  void setAccommodationUse(int value) {
    _accommodationUse = value;
    notifyListeners();
  }

  void addMoney(double amount) {
    _money += amount;
    notifyListeners();
  }

  void subtractMoney(double amount) {
    _money -= amount;
    notifyListeners();
  }

  void setImagePath(String image) {
    _imagePath = image;
    notifyListeners();
  }

  void setMaxPath(String image) {
    _maxPath = image;
    notifyListeners();
  }

  void insertPortfolio(
      stockName, image, stockPrice, int quantity, total, percentage, type) {
    _portfolio.insert(
      0,
      PortfolioModel(
        name: stockName,
        iconPath: image,
        price: stockPrice,
        amount: quantity,
        total: total,
        percentage: percentage,
        type: type,
      ),
    );
    notifyListeners();
  }

  void removeFromPortfolio(int index) {
    if (index >= 0 && index < _portfolio.length) {
      _portfolio.removeAt(index);
      notifyListeners();
    }
  }
}
