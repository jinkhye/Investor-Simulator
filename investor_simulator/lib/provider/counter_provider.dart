import 'package:flutter/material.dart';

class GameProvider extends ChangeNotifier {
  String _imagePath = 'assets/images/area0.png';
  String _maxPath = 'assets/images/Maxtshirt.png';
  String get imagePath => _imagePath;
  String get maxPath => _maxPath;

  void setImagePath(String image) {
    _imagePath = image;
    notifyListeners();
  }

  void setMaxPath(String image) {
    _maxPath = image;
    notifyListeners();
  }
}
