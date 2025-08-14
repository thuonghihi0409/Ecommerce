import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thuongmaidientu/features/customer/order/domain/entities/order_item.dart';
import 'package:thuongmaidientu/features/seller/order_management.dart/domain/entities/seller_order_item.dart';
import 'package:thuongmaidientu/shared/widgets/image_cache_custom.dart';

class OrderDetailPage extends StatelessWidget {
  final SellerOrderItem order;

  const OrderDetailPage({super.key, required this.order});

  String _formatCurrency(int amount) {
    final formatCurrency = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
    return formatCurrency.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Thông tin khách hàng
        _buildSectionTitle("Thông tin khách hàng"),
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            leading: const CircleAvatar(
              child: Icon(Icons.person),
            ),
            title: Text(order.user.name),
            subtitle: Text(order.user.email ?? ""),
          ),
        ),
        const SizedBox(height: 16),

        // Địa chỉ giao hàng
        _buildSectionTitle("Địa chỉ giao hàng"),
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              order.address?.address ?? "",
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Danh sách sản phẩm
        _buildSectionTitle("Sản phẩm"),
        Column(
          children: order.productItem.map((product) {
            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: product.variant?.cover != null
                    ? CustomCacheImageNetwork(
                        imageUrl: product.variant?.cover,
                        height: 50,
                        width: 50,
                      )
                    : const Icon(Icons.image),
                title: Text(product.productDetail?.productName ?? ""),
                subtitle: Text(
                    "Số lượng: ${product.number} | Giá: ${_formatCurrency(product.variant?.prices?.price ?? 0)}"),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 16),

        // Tổng tiền & trạng thái
        _buildSectionTitle("Tóm tắt đơn hàng"),
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                _buildRow("Tạm tính", _formatCurrency(order.subtotal)),
                _buildRow("Tổng cộng", _formatCurrency(order.total)),
                _buildRow("Trạng thái", orderStatusToText(order.status)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
