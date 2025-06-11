class Product {
  final String productId;
  final String cover;
  final String storeId;
  final String categoryId;

  final String productName;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final double price;

  Product({
    required this.productId,
    required this.cover,
    required this.storeId,
    required this.categoryId,
    required this.productName,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.price,
  });
}
