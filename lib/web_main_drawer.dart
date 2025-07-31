import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thuongmaidientu/core/app_assets.dart';
import 'package:thuongmaidientu/core/app_color.dart';
import 'package:thuongmaidientu/core/app_text_style.dart';
import 'package:thuongmaidientu/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:thuongmaidientu/features/auth/presentation/page/intro.dart';
import 'package:thuongmaidientu/features/chat/presentation/page/conversation_page.dart';
import 'package:thuongmaidientu/features/customer/product/presentation/page/product_page.dart';
import 'package:thuongmaidientu/features/notification/presentation/bloc/notification_bloc/notification_bloc.dart';
import 'package:thuongmaidientu/features/profile/presentation/page/account_screen.dart';
import 'package:thuongmaidientu/features/seller/dashboard/presentation/page/dashboard_page.dart';
import 'package:thuongmaidientu/features/seller/order_management.dart/presentation/page/order_management_page.dart';
import 'package:thuongmaidientu/features/seller/product_management/presentation/page/create_product_page.dart';
import 'package:thuongmaidientu/features/seller/product_management/presentation/page/product_management_page.dart';
import 'package:thuongmaidientu/features/seller/product_management/presentation/page/product_restock_page.dart';
import 'package:thuongmaidientu/shared/service/navigator_service.dart';
import 'package:thuongmaidientu/shared/utils/extension.dart';
import 'package:thuongmaidientu/shared/utils/helper.dart';
import 'package:thuongmaidientu/shared/widgets/badge_icon.dart';

List<String> drawers = [
  'key_dashboard'.tr(),
  'key_product_management'.tr(),
  'key_order_management'.tr(),
  'key_conversation'.tr(),
  // 'key_chat'.tr(),
  'key_setting'.tr(),
];

List<String> drawerIcons = [
  AppAssets.cartIcon,
  AppAssets.cartIcon,
  AppAssets.orderIcon,
  AppAssets.chatIcon,
  // AppAssets.chatIcon,
  AppAssets.deleteIcon,
];

List<String> drawerRoutes = [
  "dashboard",
  "product_management",
  "order_management",
  "conversation",
  // AppConstrains.chatRoute,
  "product_detail",
];

class WebMainDrawer extends StatefulWidget {
  const WebMainDrawer({super.key});

  @override
  State<WebMainDrawer> createState() => _WebMainDrawerState();
}

class _WebMainDrawerState extends State<WebMainDrawer> {
  String _routeSelected = "";

  _logout() {
    Helper.showCustomDialog(
        context: context,
        onPressPrimaryButton: () {
          context.read<AuthBloc>().add(AuthLogout(onSuccess: () {
            NavigationService.instance
                .popUntilRootAndReplace(const IntroPage());
          }));
        },
        message: "key_confirm_logout".tr(),
        isShowSecondButton: true,
        onPressSecondButton: () {
          NavigationService.instance.goBack();
        });
  }

  Widget _buildItem(
      {required String iconPath,
      required String title,
      required String route,
      EdgeInsets? paddingIcon,
      Function()? onTap,
      double? size}) {
    bool isSelected = _routeSelected == route;
    bool isCollapsed = context.widthScreen < 1000;
    return Material(
      color:
          isSelected ? AppColor.greyColor.withAlpha(100) : Colors.transparent,
      child: InkWell(
        onTap: () {
          if (onTap != null) {
            onTap();
            return;
          }
          if (_routeSelected == route) {
            return;
          }

          setState(() {
            _routeSelected = route;
          });
          NavigationService.instance.replaceNamed(route);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
          child: Row(
            mainAxisAlignment: isCollapsed
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  width: 40,
                  padding: paddingIcon,
                  alignment: isCollapsed ? Alignment.center : null,
                  child: Stack(
                    children: [
                      SvgPicture.asset(
                        iconPath,
                        width: size ?? 30,
                        colorFilter: ColorFilter.mode(
                            isSelected ? AppColor.primary : AppColor.greyColor,
                            BlendMode.srcIn),
                      ),
                      if (route == "notification")
                        BlocBuilder<NotificationBloc, NotificationState>(
                          builder: (context, state) {
                            if (0 == 0) {
                              return const SizedBox();
                            }

                            return const Positioned(
                                right: 18,
                                child: BadgeIcon(
                                    icon: Icon(Icons.notification_add)));
                          },
                        )
                    ],
                  )),
              if (isCollapsed == false)
                Expanded(
                  child: Text(
                    title,
                    style: AppTextStyles.textSize14(
                      color:
                          isSelected ? AppColor.primary : AppColor.blackColor,
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            Positioned.fill(
              child: Row(children: [
                /// Same size drawer
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  width: context.widthScreen * 0.2,
                ),
                Expanded(
                  child: Navigator(
                    observers: [NavigationService.instance.routeObserver],
                    initialRoute: 'dashboard',
                    onGenerateRoute: (RouteSettings settings) {
                      Widget child = const ProductPage();
                      switch (settings.name) {
                        case "dashboard":
                          child = const DashboardPage();
                          break;
                        case "product_management":
                          child = const ProductManagementPage();
                          break;
                        case "setting":
                          child = const AccountScreen();
                          break;
                        case "product_detail":
                          child = const ProductPage();
                          break;
                        case "conversation":
                          child = const ConversationPage();
                          break;
                        case "create_product":
                          child = const CreateProductPage();
                          break;
                        case "order_management":
                          child = const OrderManagementPage();
                          break;
                        case "product_restock":
                          child = const ProductRestockPage();
                          break;
                      }

                      return MaterialPageRoute(builder: (_) => child);
                    },
                  ),
                )
              ]),
            ),

            /// ============================================================
            /// ======================== DRAWER ============================
            /// ============================================================
            Container(
              padding: const EdgeInsets.symmetric(vertical: 24),
              width:
                  context.widthScreen > 1000 ? context.widthScreen * 0.2 : 120,
              color: AppColor.greyColor.withAlpha(50),
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 32),
                    child: SvgPicture.asset(AppAssets.addUserIcon),
                  ),
                  36.h,
                  Expanded(
                    child: Column(
                      children: drawers
                          .asMap()
                          .entries
                          .map(
                            (drawer) => _buildItem(
                              route: drawerRoutes[drawer.key],
                              iconPath: drawerIcons[drawer.key],
                              title: drawer.value.toUpperCase(),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  _buildItem(
                    route: '',
                    iconPath: AppAssets.loginIcon,
                    title: 'key_sign_out'.tr().toUpperCase(),
                    onTap: _logout,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
