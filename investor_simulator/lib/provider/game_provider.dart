import 'package:flutter/material.dart';

class GameProvider extends ChangeNotifier {
  String _imagePath = 'assets/images/area0.png';
  String _maxPath = 'assets/images/Maxtshirt.png';
  String get imagePath => _imagePath;
  String get maxPath => _maxPath;
  double _money = 10000;
  double get money => _money;
  int _accommodationUse = 0;
  int get accommodationUse => _accommodationUse;
  int _clothesUse = 0;
  int get clothesUse => _clothesUse;

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
}
