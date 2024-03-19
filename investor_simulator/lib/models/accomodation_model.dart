import 'package:flutter/material.dart';

class AccomodationModel {
  String name;
  String iconPath;
  int price;
  Color boxColor;

  AccomodationModel(
      {required this.name,
      required this.iconPath,
      required this.boxColor,
      required this.price});

  static List<AccomodationModel> getAccomodation() {
    List<AccomodationModel> accomodation = [];

    accomodation.add(AccomodationModel(
      name: 'Streets',
      iconPath: 'assets/images/area0.png',
      boxColor: Color(0xff9DCEFF),
      price: 0,
    ));

    accomodation.add(AccomodationModel(
      name: 'Shabby Flat',
      iconPath: 'assets/images/area1.png',
      boxColor: Color(0xffEEA4CE),
      price: 75,
    ));

    accomodation.add(AccomodationModel(
      name: 'Dorms',
      iconPath: 'assets/images/area2.png',
      boxColor: Color(0xff9DCEFF),
      price: 170,
    ));

    accomodation.add(AccomodationModel(
      name: 'Apartment',
      iconPath: 'assets/images/area3.png',
      boxColor: Color(0xffEEA4CE),
      price: 560,
    ));

    accomodation.add(AccomodationModel(
      name: 'House',
      iconPath: 'assets/images/area4.png',
      boxColor: Color(0xffEEA4CE),
      price: 820,
    ));

    return accomodation;
  }
}
