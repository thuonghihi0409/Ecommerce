import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:thuongmaidientu/features/dashboard/data/models/revenue_model.dart';
import 'package:thuongmaidientu/features/dashboard/data/models/top_ordered_product_model.dart';
import 'package:thuongmaidientu/features/dashboard/data/models/transaction_model.dart';

StatisticModel statisticModelFromJson(String str) =>
    StatisticModel.fromJson(json.decode(str));

class StatisticModel extends Equatable {
  final int? totalOrders;
  final int? totalProducts;
  final TransactionModel? transactions;
  final List<TopOrderedProductModel>? topOrderedProducts;
  final List<RevenueModel>? revenue;
  final double? totalRevenue;

  const StatisticModel({
    this.totalOrders,
    this.totalProducts,
    this.transactions,
    this.topOrderedProducts,
    this.revenue,
    this.totalRevenue,
  });

  StatisticModel copyWith({
    int? totalOrders,
    int? totalProducts,
    TransactionModel? transactions,
    List<TopOrderedProductModel>? topOrderedProducts,
    List<RevenueModel>? revenue,
    double? totalRevenue,
  }) =>
      StatisticModel(
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
            : List<TopOrderedProductModel>.from(json["topOrderedProducts"]!
                .map((x) => TopOrderedProductModel.fromJson(x))),
        revenue: json["revenue"] == null
            ? []
            : List<RevenueModel>.from(
                json["revenue"]!.map((x) => RevenueModel.fromJson(x))),
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
