import 'package:equatable/equatable.dart';
import 'package:thuongmaidientu/features/seller/dashboard/domain/entities/revenue_entity.dart';
import 'package:thuongmaidientu/features/seller/dashboard/domain/entities/top_ordered_product_entity.dart';
import 'package:thuongmaidientu/features/seller/dashboard/domain/entities/transaction_entity.dart';

class StatisticEntity extends Equatable {
  final int? totalOrders;
  final int? totalProducts;
  final TransactionEntity? transactions;
  final List<TopProductEntity>? topOrderedProducts;
  final List<TopProductEntity>? topAvgRatingProducts;
  final List<RevenueEntity>? revenue;
  final double? totalRevenue;

  const StatisticEntity(
      {required this.totalOrders,
      required this.totalProducts,
      required this.transactions,
      required this.topOrderedProducts,
      required this.revenue,
      required this.totalRevenue,
      required this.topAvgRatingProducts});

  StatisticEntity copyWith({
    int? totalOrders,
    int? totalProducts,
    TransactionEntity? transactions,
    List<TopProductEntity>? topOrderedProducts,
    List<TopProductEntity>? topAvgRatingProducts,
    List<RevenueEntity>? revenue,
    double? totalRevenue,
  }) =>
      StatisticEntity(
          totalOrders: totalOrders ?? this.totalOrders,
          totalProducts: totalProducts ?? this.totalProducts,
          transactions: transactions ?? this.transactions,
          topOrderedProducts: topOrderedProducts ?? this.topOrderedProducts,
          revenue: revenue ?? this.revenue,
          totalRevenue: totalRevenue ?? this.totalRevenue,
          topAvgRatingProducts:
              topOrderedProducts ?? this.topAvgRatingProducts);

  factory StatisticEntity.fromJson(Map<String, dynamic> json) =>
      StatisticEntity(
          totalOrders: json["totalOrders"],
          totalProducts: json["totalProducts"],
          transactions: TransactionEntity.fromJson(json["transactions"]),
          topOrderedProducts: json["topOrderedProducts"] == null
              ? []
              : List<TopProductEntity>.from(json["topOrderedProducts"]!
                  .map((x) => TopProductEntity.fromJson(x))),
          revenue: json["revenue"] == null
              ? []
              : List<RevenueEntity>.from(
                  json["revenue"]!.map((x) => RevenueEntity.fromJson(x))),
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
