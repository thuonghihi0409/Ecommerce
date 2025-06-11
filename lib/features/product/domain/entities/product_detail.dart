class ProductDetail {
  final String productId;
  final String productName;
  final String description;
  final double price;
  final String storeId;
  final String categoryId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<ImageItem> images;
  final List<Variant> variants;

  ProductDetail({
    required this.productId,
    required this.productName,
    required this.description,
    required this.price,
    required this.storeId,
    required this.categoryId,
    required this.createdAt,
    required this.updatedAt,
    required this.images,
    required this.variants,
  });
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
  final String name;
  final double price;
  final int stock;

  Variant({
    required this.id,
    required this.name,
    required this.price,
    required this.stock,
  });
}
