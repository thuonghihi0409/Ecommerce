class Product {
  final int productId;
  final String? cover;
  final int? storeId;
  final int? categoryId;
  final String? productName;
  final String? description;

  final double? price;
  final double? avgRating;
  final int? totalSold;

  Product(
      {required this.productId,
      this.cover,
      this.storeId,
      this.categoryId,
      this.productName,
      this.description,
      this.price,
      this.avgRating,
      this.totalSold});
}
