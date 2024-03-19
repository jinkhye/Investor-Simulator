class ClothesModel {
  String name;
  String iconPath;
  int price;

  ClothesModel(
      {required this.name, required this.iconPath, required this.price});

  static List<ClothesModel> getClothes() {
    List<ClothesModel> clothes = [];

    clothes.add(ClothesModel(
      name: 'T-shirt',
      iconPath: 'assets/images/Maxtshirt.png',
      price: 0,
    ));

    clothes.add(ClothesModel(
      name: 'Casual',
      iconPath: 'assets/images/Max.png',
      price: 15,
    ));

    clothes.add(ClothesModel(
      name: 'Shirt and Tie',
      iconPath: 'assets/images/Maxshirttie.png',
      price: 65,
    ));

    clothes.add(ClothesModel(
      name: 'Office Suit',
      iconPath: 'assets/images/Maxofficesuit.png',
      price: 125,
    ));

    clothes.add(ClothesModel(
      name: 'High-Quality Suit',
      iconPath: 'assets/images/Maxsuit.png',
      price: 250,
    ));

    return clothes;
  }
}
