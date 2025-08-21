import 'package:thuongmaidientu/features/customer/product/domain/entities/promotion.dart';

class PromotionModel extends Promotion {
  PromotionModel(
      {required super.id,
      super.name,
      super.amount,
      super.startTime,
      super.max,
      super.endTime,
      super.type,
      super.storeId});

  factory PromotionModel.fromJson(Map<String, dynamic> json) {
    return PromotionModel(
      max: json["max"],
      id: json['id'],
      name: json['name'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      startTime: json['start_time'] != null
          ? DateTime.parse(json['start_time'])
          : null,
      endTime:
          json['end_time'] != null ? DateTime.parse(json['end_time']) : null,
      type: json['type'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'amount': amount,
      'start_time': startTime?.toIso8601String(),
      'end_time': endTime?.toIso8601String(),
      'type': type,
    };
  }
}
