import 'package:equatable/equatable.dart';
import 'package:thuongmaidientu/features/dashboard/data/models/transaction_status_model.dart';

class TransactionModel extends Equatable {
  final int? total;
  final List<TransactionStatusModel>? statuses;

  const TransactionModel({
    this.total,
    this.statuses,
  });

  TransactionModel copyWith({
    int? total,
    List<TransactionStatusModel>? statuses,
  }) =>
      TransactionModel(
        total: total ?? this.total,
        statuses: statuses ?? this.statuses,
      );

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        total: json["total"].toInt(),
        statuses: json["statuses"] == null
            ? []
            : List<TransactionStatusModel>.from(json["statuses"]!
                .map((x) => TransactionStatusModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "statuses": statuses == null
            ? []
            : List<dynamic>.from(statuses!.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [total, statuses];
}
