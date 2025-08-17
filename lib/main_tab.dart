import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thuongmaidientu/core/app_assets.dart';
import 'package:thuongmaidientu/core/app_color.dart';
import 'package:thuongmaidientu/features/customer/cart/presentation/bloc/cart_bloc/cart_bloc.dart';
import 'package:thuongmaidientu/features/customer/order/presentation/bloc/order_bloc/order_bloc.dart';
import 'package:thuongmaidientu/features/customer/order/presentation/page/order_page.dart';
import 'package:thuongmaidientu/features/customer/product/presentation/page/product_page.dart';
import 'package:thuongmaidientu/features/notification/presentation/page/notification_screen.dart';
import 'package:thuongmaidientu/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:thuongmaidientu/features/profile/presentation/page/account_screen.dart';
import 'package:thuongmaidientu/shared/service/firebase_service.dart';
import 'package:thuongmaidientu/shared/widgets/badge_icon.dart';

class MainTab extends StatefulWidget {
  const MainTab({super.key});

  @override
  State<MainTab> createState() => _MainTabState();
}

class _MainTabState extends State<MainTab> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  final List<Widget> _screens = [
    const ProductPage(),
    // const VideosPage(),
    const OrderPage(),
    const NotificationScreen(),
    const AccountScreen()
  ];

  @override
  void initState() {
    super.initState();
    FirebaseService.init();
    _getData();
  }

  _getData() async {
    final userId = context.read<ProfileBloc>().state.profile?.id ?? "";
    log("userId =$userId");
    context.read<OrderBloc>().add(GetCountOrder(userId: userId));
    context.read<CartBloc>().add(GetCountCart(userId: userId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: Colors.black.withAlpha(100),
          // borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(30),
              offset: const Offset(0, 4),
              blurRadius: 10,
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
            // move page when selected
            _pageController.jumpToPage(index);
          },
          items: [
            _buildNavItem(
              icon: const Icon(
                Icons.home_outlined,
                size: 25,
              ),
              activeIcon: const Icon(
                Icons.home_outlined,
                size: 25,
              ),
              index: 0,
              label: 'Trang Chủ',
            ),
            // _buildNavItem(
            //   icon: const Icon(Icons.live_tv_outlined),
            //   activeIcon: const Icon(Icons.live_tv_outlined),
            //   index: 1,
            //   label: 'Video',
            // ),
            _buildNavItem(
              icon:
                  BlocBuilder<OrderBloc, OrderState>(builder: (context, state) {
                return BadgeIcon(
                  icon: SvgPicture.asset(
                    AppAssets.orderIcon,
                    height: 25,
                    width: 25,
                  ),
                  count: state.count,
                );
              }),
              activeIcon:
                  BlocBuilder<OrderBloc, OrderState>(builder: (context, state) {
                return BadgeIcon(
                  icon: SvgPicture.asset(
                    AppAssets.orderIcon,
                    height: 25,
                    width: 25,
                    colorFilter: const ColorFilter.mode(
                        AppColor.secondary, BlendMode.srcIn),
                  ),
                  count: state.count,
                );
              }),
              index: 2,
              label: 'Đơn Hàng',
            ),
            _buildNavItem(
              icon: const Icon(Icons.notifications),
              activeIcon: const Icon(Icons.notifications),
              index: 3,
              label: 'Thông báo',
            ),
            _buildNavItem(
              icon: const Icon(Icons.account_circle_outlined),
              activeIcon: const Icon(Icons.account_circle_outlined),
              index: 4,
              label: 'Tài khỏan',
            ),
          ],
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: _screens,
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(
      {required Widget icon,
      required int index,
      required String label,
      required Widget activeIcon}) {
    return BottomNavigationBarItem(
        icon: icon, label: label, activeIcon: activeIcon);
  }
}
