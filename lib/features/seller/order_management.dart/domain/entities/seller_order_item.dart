import 'package:thuongmaidientu/features/customer/cart/domain/entities/product_item.dart';
import 'package:thuongmaidientu/features/customer/order/domain/entities/order_item.dart';
import 'package:thuongmaidientu/features/profile/domain/entities/address_entity.dart';
import 'package:thuongmaidientu/features/profile/domain/entities/profile_entity.dart';

class SellerOrderItem {
  final String id;
  final ProfileEntity user;
  final int subtotal;
  final int total;
  final OrderStatus status;
  final List<ProductItem> productItem;
  final AddressEntity? address;

  SellerOrderItem(
      {required this.user,
      required this.productItem,
      required this.id,
      required this.status,
      required this.address,
      required this.subtotal,
      required this.total});
  SellerOrderItem copyWith({required OrderStatus? orderStatus}) {
    return SellerOrderItem(
        user: user,
        productItem: productItem,
        id: id,
        status: orderStatus ?? status,
        address: address,
        subtotal: subtotal,
        total: total);
  }
}
