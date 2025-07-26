import 'package:equatable/equatable.dart';

class RevenueModel extends Equatable {
  final String? key;
  final double? value;

  const RevenueModel({
    this.key,
    this.value,
  });

  RevenueModel copyWith({
    String? key,
    double? value,
  }) =>
      RevenueModel(
        key: key ?? this.key,
        value: value ?? this.value,
      );

  factory RevenueModel.fromJson(Map<String, dynamic> json) => RevenueModel(
        key: json["key"],
        value: json["value"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "value": value,
      };

  @override
  List<Object?> get props => [key, value];
}
