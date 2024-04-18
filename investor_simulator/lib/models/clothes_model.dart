class ClothesModel {
  String name;
  String iconPath;
  int price;
  int lvl;

  ClothesModel(
      {required this.name,
      required this.iconPath,
      required this.price,
      required this.lvl});

  static List<ClothesModel> getClothes() {
    List<ClothesModel> clothes = [];

    clothes.add(ClothesModel(
      name: 'Casual',
      iconPath: 'assets/images/Max.png',
      price: 500,
      lvl: 1,
    ));

    clothes.add(ClothesModel(
      name: 'Shirt and Tie',
      iconPath: 'assets/images/Maxshirttie.png',
      price: 1000,
      lvl: 5,
    ));

    clothes.add(ClothesModel(
      name: 'Office Suit',
      iconPath: 'assets/images/Maxofficesuit.png',
      price: 3600,
      lvl: 10,
    ));

    clothes.add(ClothesModel(
      name: 'High-Quality Suit',
      iconPath: 'assets/images/Maxsuit.png',
      price: 10200,
      lvl: 20,
    ));

    return clothes;
  }
}
