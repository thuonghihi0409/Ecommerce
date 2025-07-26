import 'package:equatable/equatable.dart';

class TopOrderedProductEntity extends Equatable {
  final String? id;
  final int? totalOrdered;
  final String? name;

  const TopOrderedProductEntity({
    this.id,
    this.totalOrdered,
    this.name,
  });

  TopOrderedProductEntity copyWith({
    String? id,
    int? totalOdered,
    String? name,
  }) =>
      TopOrderedProductEntity(
        id: id ?? this.id,
        totalOrdered: totalOdered ?? totalOrdered,
        name: name ?? this.name,
      );

  factory TopOrderedProductEntity.fromJson(Map<String, dynamic> json) =>
      TopOrderedProductEntity(
        id: json["id"],
        totalOrdered: json["totalOrdered"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "totalOrdered": totalOrdered,
        "name": name,
      };

  @override
  List<Object?> get props => [id, totalOrdered, name];
}
