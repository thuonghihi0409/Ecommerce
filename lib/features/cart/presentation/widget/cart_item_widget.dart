import 'package:flutter/material.dart';
import 'package:thuongmaidientu/features/cart/domain/entities/cart_item.dart';

class CartItemWidget extends StatefulWidget {
  final CartItem cartItem;
  const CartItemWidget({super.key, required this.cartItem});

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
