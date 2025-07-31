import '../../domain/entities/store.dart';

class StoreModel extends Store {
  const StoreModel(
      {required super.id,
      required super.name,
      required super.logoUrl,
      required super.address,
      required super.averageRating,
      required super.totalProducts,
      required super.backgroundUrl});

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return StoreModel(
      backgroundUrl: json["background_url"],
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      logoUrl: json['logo_url'] ?? '',
      address: json['address'] ?? '',
      averageRating: (json['average_rating'] ?? 0).toDouble(),
      totalProducts: json['total_products'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'logo_url': logoUrl,
      'address': address,
      'average_rating': averageRating,
      'total_products': totalProducts,
      'background_url': backgroundUrl
    };
  }
}
