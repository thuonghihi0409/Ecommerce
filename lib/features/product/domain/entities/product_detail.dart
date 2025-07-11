class ProductDetail {
  final int productId;
  final String? productName;
  final String? description;
  final double? price;
  final int? storeId;
  final int? categoryId;

  final List<ImageItem>? images;
  final List<Variant>? variants;
  final double? avgRating;
  final int? totalSold;
  final int? totalRating;

  ProductDetail(
      {required this.productId,
      required this.productName,
      required this.description,
      required this.price,
      required this.storeId,
      required this.categoryId,
      required this.images,
      required this.variants,
      required this.avgRating,
      required this.totalRating,
      required this.totalSold});
}

class ImageItem {
  final String id;
  final String url;
  final String alt;

  ImageItem({
    required this.id,
    required this.url,
    required this.alt,
  });
}

class Variant {
  final String id;
  final String cover;
  final String name;
  final double price;
  final int stock;

  Variant(
      {required this.id,
      required this.name,
      required this.price,
      required this.stock,
      required this.cover});
}
