class PortfolioModel {
  String name;
  String iconPath;
  double price;
  int amount;
  double total;
  String percentage;
  int type;

  PortfolioModel({
    required this.name,
    required this.iconPath,
    required this.price,
    required this.amount,
    required this.total,
    required this.percentage,
    required this.type,
  });
}
