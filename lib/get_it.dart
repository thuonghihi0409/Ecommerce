import 'package:get_it/get_it.dart';
import 'package:thuongmaidientu/features/auth/di/auth_dependecy.dart';
import 'package:thuongmaidientu/features/chat/di/chat_dependecy.dart';
import 'package:thuongmaidientu/features/customer/cart/di/cart_dependecy.dart';
import 'package:thuongmaidientu/features/customer/order/di/order_dependecy.dart';
import 'package:thuongmaidientu/features/customer/product/di/product_dependecy.dart';
import 'package:thuongmaidientu/features/profile/di/profile_dependecy.dart';
import 'package:thuongmaidientu/features/review/di/review_dependecy.dart';
import 'package:thuongmaidientu/features/seller/dashboard/di/dashboard_dependecy.dart';
import 'package:thuongmaidientu/features/seller/order_management.dart/di/order_management_dependecy.dart';
import 'package:thuongmaidientu/features/seller/product_management/di/product_management_dependecy.dart';

final sl = GetIt.instance;

Future<void> init() async {
  AuthDependecy.init();
  CartDependecy.init();
  ChatDependecy.init();
  ProductDependecy.init();
  OrderDependecy.init();
  ProfileDependecy.init();
  ReviewDependecy.init();
  DashboardDependecy.init();
  OrderManagementDependecy.init();
  ProductManagementDependecy.init();
}
