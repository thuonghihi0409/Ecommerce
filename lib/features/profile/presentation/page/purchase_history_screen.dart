import 'package:flutter/material.dart';
import 'package:thuongmaidientu/features/customer/order/domain/entities/order_item.dart';
import 'package:thuongmaidientu/features/customer/order/presentation/page/order_list_tab.dart';

class PurchaseHistoryScreen extends StatelessWidget {
  const PurchaseHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Lịch sử mua hàng'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Đã giao'),
              Tab(text: 'Đang giao'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            OrderListTab(status: OrderStatus.delivered),
            OrderListTab(status: OrderStatus.delivering),
          ],
        ),
      ),
    );
  }
}
