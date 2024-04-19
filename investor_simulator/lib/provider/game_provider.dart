import 'package:flutter/material.dart';
import 'package:investor_simulator/models/accommodation_model.dart';

class GameProvider extends ChangeNotifier {
  String _imagePath = 'assets/images/area0.png';
  String _maxPath = 'assets/images/Maxtshirt.png';
  String get imagePath => _imagePath;
  String get maxPath => _maxPath;
  double _money = 10000;
  double get money => _money;
  final List<AccomodationModel> _accomodation =
      AccomodationModel.getAccomodation();
  List<AccomodationModel> get accomodation => _accomodation;
  int _accommodationUse = -1;
  int get accommodationUse => _accommodationUse;
  int _clothesUse = -1;
  int get clothesUse => _clothesUse;
  int _level = 1;
  int get level => _level;
  double _currentXp = 0;
  double _requiredXp = 100;
  double get currentXp => _currentXp;
  double get requiredXp => _requiredXp;
  bool _isClose = false;
  bool get isClose => _isClose;
  int _openCount = 0;
  int get openCount => _openCount;

  void setOpenCount(int count) {
    _openCount = count;
  }

  void setClose(bool close) {
    _isClose = close;

    notifyListeners();
  }

  void addAccomodationLevel(index) {
    _accomodation[index].current++;
    notifyListeners();
  }

  void adminMoney(double money) {
    _money += money;
    notifyListeners();
  }

  void adminLevel(int level) {
    _level += level;
    _requiredXp += 200 * _level;
    notifyListeners();
  }

  void addLevel() {
    _level++;
    _requiredXp += 200;
    notifyListeners();
  }

  void addXp(double xp) {
    _currentXp += xp;

    // Loop to handle leveling up multiple times if necessary
    while (_currentXp >= _requiredXp) {
      // Calculate the excess XP for the next level
      double excessXp = _currentXp - _requiredXp;

      // Level up and update the required XP for the new level
      addLevel();

      // Update the current XP with the excess XP
      _currentXp = excessXp;
    }

    // Notify listeners of changes
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
}
