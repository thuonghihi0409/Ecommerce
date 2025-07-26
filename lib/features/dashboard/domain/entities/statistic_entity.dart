import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:thuongmaidientu/features/dashboard/domain/entities/revenue_entity.dart';
import 'package:thuongmaidientu/features/dashboard/domain/entities/top_ordered_product_entity.dart';
import 'package:thuongmaidientu/features/dashboard/domain/entities/transaction_entity.dart';

StatisticEntity statisticModelFromJson(String str) =>
    StatisticEntity.fromJson(json.decode(str));

class StatisticEntity extends Equatable {
  final int? totalOrders;
  final int? totalProducts;
  final TransactionEntity? transactions;
  final List<TopOrderedProductEntity>? topOrderedProducts;
  final List<RevenueEntity>? revenue;
  final double? totalRevenue;

  const StatisticEntity({
    this.totalOrders,
    this.totalProducts,
    this.transactions,
    this.topOrderedProducts,
    this.revenue,
    this.totalRevenue,
  });

  StatisticEntity copyWith({
    int? totalOrders,
    int? totalProducts,
    TransactionEntity? transactions,
    List<TopOrderedProductEntity>? topOrderedProducts,
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
      );

  factory StatisticEntity.fromJson(Map<String, dynamic> json) =>
      StatisticEntity(
        totalOrders: json["totalOrders"],
        totalProducts: json["totalProducts"],
        transactions: TransactionEntity.fromJson(json["transactions"]),
        topOrderedProducts: json["topOrderedProducts"] == null
            ? []
            : List<TopOrderedProductEntity>.from(json["topOrderedProducts"]!
                .map((x) => TopOrderedProductEntity.fromJson(x))),
        revenue: json["revenue"] == null
            ? []
            : List<RevenueEntity>.from(
                json["revenue"]!.map((x) => RevenueEntity.fromJson(x))),
        totalRevenue: json["totalRevenue"]?.toDouble(),
      );

  @override
  List<Object?> get props => [
        totalOrders,
        totalProducts,
        transactions,
        topOrderedProducts,
        revenue,
        totalRevenue
      ];
}
