import 'package:thuongmaidientu/features/seller/dashboard/data/models/revenue_model.dart';
import 'package:thuongmaidientu/features/seller/dashboard/data/models/top_ordered_product_model.dart';
import 'package:thuongmaidientu/features/seller/dashboard/data/models/transaction_model.dart';
import 'package:thuongmaidientu/features/seller/dashboard/domain/entities/revenue_entity.dart';
import 'package:thuongmaidientu/features/seller/dashboard/domain/entities/statistic_entity.dart';
import 'package:thuongmaidientu/features/seller/dashboard/domain/entities/top_ordered_product_entity.dart';
import 'package:thuongmaidientu/features/seller/dashboard/domain/entities/transaction_entity.dart';

class StatisticModel extends StatisticEntity {
  const StatisticModel(
      {required super.totalOrders,
      required super.totalProducts,
      required super.transactions,
      required super.topOrderedProducts,
      required super.revenue,
      required super.totalRevenue,
      required super.topAvgRatingProducts});

  @override
  StatisticModel copyWith({
    List<TopProductEntity>? topAvgRatingProducts,
    int? totalOrders,
    int? totalProducts,
    TransactionEntity? transactions,
    List<TopProductEntity>? topOrderedProducts,
    List<RevenueEntity>? revenue,
    double? totalRevenue,
  }) =>
      StatisticModel(
        topAvgRatingProducts: topAvgRatingProducts ?? this.topAvgRatingProducts,
        totalOrders: totalOrders ?? this.totalOrders,
        totalProducts: totalProducts ?? this.totalProducts,
        transactions: transactions ?? this.transactions,
        topOrderedProducts: topOrderedProducts ?? this.topOrderedProducts,
        revenue: revenue ?? this.revenue,
        totalRevenue: totalRevenue ?? this.totalRevenue,
      );

  factory StatisticModel.fromJson(Map<String, dynamic> json) => StatisticModel(
      totalOrders: json["totalOrders"],
      totalProducts: json["totalProducts"],
      transactions: TransactionModel.fromJson(json["transactions"]),
      topOrderedProducts: json["topOrderedProducts"] == null
          ? []
          : List<TopProductModel>.from(json["topOrderedProducts"]!
              .map((x) => TopProductModel.fromJson(x))),
      revenue: json["revenue"] == null
          ? []
          : List<RevenueModel>.from(
              json["revenue"]!.map((x) => RevenueModel.fromJson(x))),
      totalRevenue: json["totalRevenue"]?.toDouble(),
      topAvgRatingProducts: json["topAvgRating"] == null
          ? []
          : List<TopProductEntity>.from(json["topOrderedProducts"]!
              .map((x) => TopProductEntity.fromJson(x))));

  @override
  List<Object?> get props => [
        totalOrders,
        totalProducts,
        transactions,
        topOrderedProducts,
        revenue,
        totalRevenue,
        topAvgRatingProducts
      ];
}
