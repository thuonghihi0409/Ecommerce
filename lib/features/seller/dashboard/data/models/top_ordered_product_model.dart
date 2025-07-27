import 'package:thuongmaidientu/features/seller/dashboard/domain/entities/top_ordered_product_entity.dart';

class TopOrderedProductModel extends TopOrderedProductEntity {
  const TopOrderedProductModel(
      {required super.id, required super.totalOrdered, required super.name});

  @override
  TopOrderedProductModel copyWith({
    String? id,
    int? totalOdered,
    String? name,
  }) =>
      TopOrderedProductModel(
        id: id ?? this.id,
        totalOrdered: totalOdered ?? totalOrdered,
        name: name ?? this.name,
      );

  factory TopOrderedProductModel.fromJson(Map<String, dynamic> json) =>
      TopOrderedProductModel(
        id: json["id"],
        totalOrdered: json["totalOrdered"],
        name: json["name"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "totalOrdered": totalOrdered,
        "name": name,
      };

  @override
  List<Object?> get props => [id, totalOrdered, name];
}
