import 'package:thuongmaidientu/features/customer/cart/domain/entities/cart_item.dart';
import 'package:thuongmaidientu/features/customer/order/domain/entities/order_product_item.dart';
import 'package:thuongmaidientu/features/customer/product/domain/entities/store.dart';
import 'package:thuongmaidientu/features/profile/domain/entities/address_entity.dart';

enum OrderStatus {
  pending, // Chờ duyệt
  awaiting, // Chuẩn bị hàng
  delivering, // Đang giao
  delivered, // Đã giao
  cancelled, // Đã hủy
  returnRequested, // Yêu cầu trả hàng
  returned, // Đã trả hàng
}

OrderStatus orderStatusFromString(String status) {
  switch (status) {
    case 'pending':
      return OrderStatus.pending;
    case 'awaiting':
      return OrderStatus.awaiting;
    case 'delivering':
      return OrderStatus.delivering;
    case 'delivered':
      return OrderStatus.delivered;
    case 'cancelled':
      return OrderStatus.cancelled;
    case 'returnRequested':
      return OrderStatus.returnRequested;
    case 'returned':
      return OrderStatus.returned;
    default:
      throw Exception('Unknown order status: $status');
  }
}

String orderStatusToString(OrderStatus status) {
  switch (status) {
    case OrderStatus.pending:
      return 'pending';
    case OrderStatus.awaiting:
      return 'awaiting';
    case OrderStatus.delivering:
      return 'delivering';
    case OrderStatus.delivered:
      return 'delivered';
    case OrderStatus.cancelled:
      return 'cancelled';
    case OrderStatus.returnRequested:
      return 'returnRequested';
    case OrderStatus.returned:
      return 'returned';
  }
}

String orderStatusToText(OrderStatus status) {
  switch (status) {
    case OrderStatus.pending:
      return 'Chờ duyệt';
    case OrderStatus.awaiting:
      return 'Chuẩn bị hàng';
    case OrderStatus.delivering:
      return 'Đang giao';
    case OrderStatus.delivered:
      return 'Đã giao';
    case OrderStatus.cancelled:
      return 'Đã hủy';
    case OrderStatus.returnRequested:
      return 'Yêu cầu trả hàng';
    case OrderStatus.returned:
      return 'Đã trả hàng';
  }
}

class OrderItem {
  final String id;
  final Store store;
  final int subtotal;
  final int total;
  final OrderStatus status;
  final String? paymentMethod;
  final List<OrderProductItem> productItem;
  final AddressEntity? address;

  OrderItem(
      {required this.store,
      required this.productItem,
      required this.id,
      required this.status,
      required this.address,
      required this.subtotal,
      required this.paymentMethod,
      required this.total});
  factory OrderItem.copyFromCartItem(CartItem item, AddressEntity? address) {
    return OrderItem(
        paymentMethod: null,
        store: item.store,
        productItem: item.productItem
            .map((item) => OrderProductItem(
                id: item.id,
                productDetail: item.productDetail,
                variant: item.variant,
                number: item.number,
                isReviewed: false))
            .toList(),
        id: item.id,
        status: OrderStatus.pending,
        address: address,
        subtotal: item.productItem
            .fold(0, (sum, item) => sum + (item.variant?.price ?? 0)),
        total: item.productItem
            .fold(0, (sum, item) => sum + (item.variant?.price ?? 0)));
  }

  OrderItem copyWith({required OrderStatus? orderStatus}) {
    return OrderItem(
        paymentMethod: paymentMethod,
        store: store,
        productItem: productItem,
        id: id,
        status: orderStatus ?? status,
        address: address,
        subtotal: subtotal,
        total: total);
  }
}
