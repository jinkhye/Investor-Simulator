import 'package:flutter/material.dart';
import 'package:investor_simulator/models/portfolio_model.dart';

class GameProvider extends ChangeNotifier {
  String _imagePath = 'assets/images/area0.png';
  String _maxPath = 'assets/images/Maxtshirt.png';
  String get imagePath => _imagePath;
  String get maxPath => _maxPath;
  final List<PortfolioModel> _portfolio = [];
  List<PortfolioModel> get portfolio => _portfolio;
  double _money = 10000;
  double get money => _money;
  int _accomodationUse = 0;
  int get accomodationUse => _accomodationUse;
  int _clothesUse = 0;
  int get clothesUse => _clothesUse;

  void setClothesUse(int value) {
    _clothesUse = value;
    notifyListeners();
  }

  void setAccomodationUse(int value) {
    _accomodationUse = value;
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
      stockName, image, stockPrice, quantity, total, percentage) {
    portfolio.insert(
      0,
      PortfolioModel(
        name: stockName,
        iconPath: image,
        price: stockPrice,
        amount: quantity,
        total: total,
        percentage: percentage,
      ),
    );
    notifyListeners();
  }

  void removeFromPortfolio(int index) {
    if (index >= 0 && index < portfolio.length) {
      portfolio.removeAt(index);
      notifyListeners();
    }
  }
}
