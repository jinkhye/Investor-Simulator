class AccomodationModel {
  String name;
  String iconPath;
  int price;
  int lvl;
  int current;
  int income;
  int upgradePrice;

  AccomodationModel(
      {required this.name,
      required this.iconPath,
      required this.price,
      required this.lvl,
      required this.current,
      required this.income,
      required this.upgradePrice});

  static List<AccomodationModel> getAccomodation() {
    List<AccomodationModel> accomodation = [];

    accomodation.add(AccomodationModel(
      name: 'Shabby Flat',
      iconPath: 'assets/images/area1.png',
      price: 1000,
      lvl: 1,
      current: 1,
      income: 100,
      upgradePrice: 500,
    ));

    accomodation.add(AccomodationModel(
      name: 'Dorms',
      iconPath: 'assets/images/area2.png',
      price: 3600,
      lvl: 5,
      current: 1,
      income: 300,
      upgradePrice: 800,
    ));

    accomodation.add(AccomodationModel(
      name: 'Apartment',
      iconPath: 'assets/images/area3.png',
      price: 10200,
      lvl: 10,
      current: 1,
      income: 800,
      upgradePrice: 2000,
    ));

    accomodation.add(AccomodationModel(
      name: 'House',
      iconPath: 'assets/images/area4.png',
      price: 56000,
      lvl: 20,
      current: 1,
      income: 1500,
      upgradePrice: 6000,
    ));

    return accomodation;
  }
}
