import 'package:equatable/equatable.dart';

class TopOrderedProductModel extends Equatable {
  final String? id;
  final int? totalOrdered;
  final String? name;

  const TopOrderedProductModel({
    this.id,
    this.totalOrdered,
    this.name,
  });

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

  Map<String, dynamic> toJson() => {
        "id": id,
        "totalOrdered": totalOrdered,
        "name": name,
      };

  @override
  List<Object?> get props => [id, totalOrdered, name];
}
