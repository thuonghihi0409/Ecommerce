import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuongmaidientu/core/app_color.dart';
import 'package:thuongmaidientu/features/order/domain/entities/order_item.dart';
import 'package:thuongmaidientu/features/order/presentation/bloc/order_bloc/order_bloc.dart';
import 'package:thuongmaidientu/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:thuongmaidientu/shared/utils/extension.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';

class OrderListTab extends StatefulWidget {
  final OrderStatus status;

  const OrderListTab({super.key, required this.status});

  @override
  State<OrderListTab> createState() => _OrderListTabState();
}

class _OrderListTabState extends State<OrderListTab> {
  late OrderBloc _bloc;
  late String _userId;
  ListModel _data = const ListModel();

  @override
  void initState() {
    super.initState();
    _userId = context.read<ProfileBloc>().state.profile?.id ?? "";
    _bloc = BlocProvider.of<OrderBloc>(context);
    _bloc.add(GetListOrder(orderStatus: widget.status, id: _userId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(builder: (context, state) {
      switch (widget.status) {
        case OrderStatus.pending:
          _data = state.listOrderPending;
          break;
        case OrderStatus.delivered:
          _data = state.listOrderDelivered;
          break;
        case OrderStatus.cancelled:
          _data = state.listOrderCancelled;
          break;
        case OrderStatus.awaiting:
          _data = state.listOrderWaiting;
          break;
        case OrderStatus.delivering:
          _data = state.listOrderDelivering;
          break;
        case OrderStatus.reviewed:
          _data = state.listOrderReviewed;
          break;
      }

      return ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: (_data.results ?? []).length,
        separatorBuilder: (_, __) => 12.h,
        itemBuilder: (context, index) {
          final order = (_data.results ?? [])[index];
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColor.whiteColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black..withAlpha(10),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  order.toString(),
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
    });
  }
}
