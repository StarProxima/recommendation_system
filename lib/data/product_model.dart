class Product {
  const Product({
    required this.name,
    required this.price,
    required this.merchant,
  });
  final String name;
  final double price;
  final String merchant;

  static Product fromJson(json) {
    return Product(name: json["name"], price: double.parse(json["cost"].toString()), merchant: json["merchantName"]);
  }
}
