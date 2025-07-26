import 'package:equatable/equatable.dart';

class TransactionStatusModel extends Equatable {
  final String? status;
  final int? count;

  const TransactionStatusModel({
    this.status,
    this.count,
  });

  TransactionStatusModel copyWith({
    String? status,
    int? count,
  }) =>
      TransactionStatusModel(
        status: status ?? this.status,
        count: count ?? this.count,
      );

  factory TransactionStatusModel.fromJson(Map<String, dynamic> json) =>
      TransactionStatusModel(
        status: json["status"],
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "count": count,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [status, count];
}
