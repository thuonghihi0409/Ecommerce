import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuongmaidientu/core/app_assets.dart';
import 'package:thuongmaidientu/features/order/domain/entities/order_item.dart';
import 'package:thuongmaidientu/features/order/presentation/bloc/order_bloc/order_bloc.dart';
import 'package:thuongmaidientu/features/order/presentation/widget/order_item_widget.dart';
import 'package:thuongmaidientu/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:thuongmaidientu/shared/utils/extension.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';
import 'package:thuongmaidientu/shared/widgets/list_empty_widget.dart';

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
      }
      if ((_data.results ?? []).isEmpty) {
        return Center(
          child: ListEmptyWidget(
            title: 'key_no_order'.tr(),
            icon: AppAssets.orderIcon,
          ),
        );
      }

      return ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: (_data.results ?? []).length,
        separatorBuilder: (_, __) => 12.h,
        itemBuilder: (context, index) {
          final order = (_data.results ?? [])[index];
          return OrderItemWidget(orderItem: order);
        },
      );
    });
  }
}
