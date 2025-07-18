import 'package:flutter/material.dart';
import 'package:thuongmaidientu/core/app_color.dart';
import 'package:thuongmaidientu/shared/utils/extension.dart';

class OrderListTab extends StatelessWidget {
  final String status;

  const OrderListTab({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    // TODO: Replace with BlocBuilder or FutureBuilder to fetch data
    final fakeOrders = List.generate(3, (index) => "Đơn hàng $index - $status");

    return fakeOrders.isEmpty
        ? Center(child: Text("Không có đơn hàng $status"))
        : ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: fakeOrders.length,
            separatorBuilder: (_, __) => 12.h,
            itemBuilder: (context, index) {
              final order = fakeOrders[index];
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColor.whiteColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    8.h,
                    const Text("Chi tiết đơn hàng hiển thị ở đây..."),
                    12.h,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: const Text("Xem chi tiết"),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          );
  }
}
