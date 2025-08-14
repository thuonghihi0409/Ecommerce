import 'package:flutter/material.dart';
import 'package:thuongmaidientu/features/customer/product/domain/entities/product_detail.dart';

class VariantInput {
  final String id;
  final String name;
  final String? cover;

  final Price? prices;
  final int stock;
  final TextEditingController controller = TextEditingController();

  VariantInput(
      {required this.id,
      required this.name,
      required this.prices,
      required this.stock,
      required this.cover});
}
