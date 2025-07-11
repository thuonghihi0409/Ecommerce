class Store {
  final int id;
  final String? name;
  final String? logoUrl;
  final String? address;
  final double? averageRating;
  final int? totalProducts;

  const Store({
    required this.id,
    required this.name,
    required this.logoUrl,
    required this.address,
    required this.averageRating,
    required this.totalProducts,
  });
}
