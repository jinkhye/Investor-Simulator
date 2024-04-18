class AccomodationModel {
  String name;
  String iconPath;
  int price;
  int lvl;

  AccomodationModel(
      {required this.name,
      required this.iconPath,
      required this.price,
      required this.lvl});

  static List<AccomodationModel> getAccomodation() {
    List<AccomodationModel> accomodation = [];

    accomodation.add(AccomodationModel(
      name: 'Shabby Flat',
      iconPath: 'assets/images/area1.png',
      price: 500,
      lvl: 1,
    ));

    accomodation.add(AccomodationModel(
      name: 'Dorms',
      iconPath: 'assets/images/area2.png',
      price: 1700,
      lvl: 5,
    ));

    accomodation.add(AccomodationModel(
      name: 'Apartment',
      iconPath: 'assets/images/area3.png',
      price: 5600,
      lvl: 10,
    ));

    accomodation.add(AccomodationModel(
      name: 'House',
      iconPath: 'assets/images/area4.png',
      price: 10200,
      lvl: 20,
    ));

    return accomodation;
  }
}
