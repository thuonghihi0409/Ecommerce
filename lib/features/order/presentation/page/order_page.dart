import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuongmaidientu/core/app_color.dart';
import 'package:thuongmaidientu/features/order/domain/entities/order_item.dart';
import 'package:thuongmaidientu/features/order/presentation/bloc/order_bloc/order_bloc.dart';
import 'package:thuongmaidientu/features/order/presentation/page/order_list_tab.dart';
import 'package:thuongmaidientu/shared/widgets/appbar_custom.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with TickerProviderStateMixin {
  late OrderBloc _bloc;
  final List<OrderStatus> _tabs = [
    OrderStatus.pending,
    OrderStatus.awaiting,
    OrderStatus.delivering,
    OrderStatus.delivered,
    OrderStatus.cancelled,
    OrderStatus.reviewed
  ];

  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: _tabs.length, vsync: this);
    super.initState();
    _bloc = BlocProvider.of<OrderBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: const CustomAppBar(
        title: "Đơn hàng",
        showLeading: false,
      ),
      body: Column(
        children: [
          Container(
            color: AppColor.primary.withAlpha(20),
            child: TabBar(
              tabAlignment: TabAlignment.start,
              padding: EdgeInsets.zero,
              controller: _tabController,
              isScrollable: true,
              indicatorColor: AppColor.primary,
              labelColor: AppColor.primary,
              unselectedLabelColor: Colors.grey,
              labelStyle: const TextStyle(fontWeight: FontWeight.w600),
              tabs: _tabs.map((e) => Tab(text: orderStatusToText(e))).toList(),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: _tabs.map((status) {
                return OrderListTab(status: status);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
