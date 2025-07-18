import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thuongmaidientu/core/app_assets.dart';
import 'package:thuongmaidientu/core/app_color.dart';
import 'package:thuongmaidientu/features/cart/presentation/page/cart_page.dart';
import 'package:thuongmaidientu/features/chat/presentation/page/conversation_page.dart';
import 'package:thuongmaidientu/features/order/presentation/page/order_list_tab.dart';
import 'package:thuongmaidientu/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:thuongmaidientu/shared/service/navigator_service.dart';
import 'package:thuongmaidientu/shared/widgets/appbar_custom.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with TickerProviderStateMixin {
  final List<String> _tabs = [
    "Chờ duyệt",
    "Chuẩn bị hàng",
    "Đang giao",
    "Đã giao",
    "Đã hủy",
    "Đánh giá"
  ];

  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: _tabs.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: CustomAppBar(
        title: "Đơn hàng",
        showLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                final id = context.read<ProfileBloc>().state.profile?.id;
                NavigationService.instance
                    .push(ConversationPage(currentUserId: id ?? ""));
              },
              icon: SvgPicture.asset(
                AppAssets.chatIcon,
                height: 25,
                width: 25,
              )),
          IconButton(
              onPressed: () {
                NavigationService.instance.push(const CartPage());
              },
              icon: SvgPicture.asset(
                AppAssets.cartIcon,
                height: 25,
                width: 25,
              )),
        ],
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
              tabs: _tabs.map((e) => Tab(text: e)).toList(),
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
