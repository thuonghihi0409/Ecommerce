import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thuongmaidientu/core/app_assets.dart';
import 'package:thuongmaidientu/core/app_color.dart';
import 'package:thuongmaidientu/core/app_text_style.dart';
import 'package:thuongmaidientu/features/auth/presentation/page/login_page.dart';
import 'package:thuongmaidientu/features/chat/presentation/page/conversation_page.dart';
import 'package:thuongmaidientu/features/customer/cart/presentation/bloc/cart_bloc/cart_bloc.dart';
import 'package:thuongmaidientu/features/customer/cart/presentation/page/cart_page.dart';
import 'package:thuongmaidientu/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:thuongmaidientu/shared/service/navigator_service.dart';
import 'package:thuongmaidientu/shared/utils/extension.dart';
import 'package:thuongmaidientu/shared/widgets/badge_icon.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isShowChatIcon;
  final bool isShowCartIcon;
  final String? title;
  final TextStyle? titleStyle;
  final Color backgroundColor;
  final bool showLeading;
  final Widget? leading;
  final List<Widget>? actions;
  final double height;
  final Widget? customTitle;

  const CustomAppBar(
      {super.key,
      this.title,
      this.titleStyle,
      this.backgroundColor = kIsWeb ? AppColor.whiteColor : AppColor.primary,
      this.showLeading = true,
      this.leading,
      this.actions,
      this.customTitle,
      this.height = kToolbarHeight,
      this.isShowCartIcon = true,
      this.isShowChatIcon = true});

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: customTitle ??
          (title != null
              ? Text(
                  title!,
                  style: titleStyle ??
                      AppTextStyles.textSize18(fontWeight: FontWeight.w400),
                )
              : null),
      centerTitle: !kIsWeb,
      backgroundColor: backgroundColor,
      automaticallyImplyLeading: false,
      leading: showLeading
          ? InkWell(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColor.greyColor.withAlpha(100)),
                child: (leading ??
                    SvgPicture.asset(
                      AppAssets.arrowLeftIcon,
                    )),
              ),
            )
          : null,
      actions: [
        if (isShowChatIcon && !kIsWeb)
          BadgeIcon(
            icon: SvgPicture.asset(
              AppAssets.chatIcon,
              height: 25,
              width: 25,
            ),
            onTap: () {
              final id = context.read<ProfileBloc>().state.profile?.id;
              if (id == null) {
                NavigationService.instance.push(const LoginScreen());
                return;
              }
              NavigationService.instance.push(const ConversationPage());
            },
          ),
        if (isShowCartIcon && isShowCartIcon && !kIsWeb) 10.w,
        if (isShowCartIcon && !kIsWeb)
          BlocBuilder<CartBloc, CartState>(builder: (context, state) {
            return BadgeIcon(
              icon: SvgPicture.asset(
                AppAssets.cartIcon,
                height: 25,
                width: 25,
              ),
              onTap: () {
                final id = context.read<ProfileBloc>().state.profile?.id;
                if (id == null) {
                  NavigationService.instance.push(const LoginScreen());
                  return;
                }
                NavigationService.instance.push(const CartPage());
              },
              count: state.totalProduct,
            );
          }),
        ...actions ?? []
      ],
    );
  }
}
