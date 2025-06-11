import 'package:flutter/material.dart';
import 'package:thuongmaidientu/core/app_color.dart';
import 'package:thuongmaidientu/core/app_text_style.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final TextStyle? titleStyle;
  final Color backgroundColor;
  final bool showLeading;
  final Widget? leading;
  final List<Widget>? actions;
  final double height;

  const CustomAppBar({
    super.key,
    this.title,
    this.titleStyle,
    this.backgroundColor = AppColor.primary,
    this.showLeading = true,
    this.leading,
    this.actions,
    this.height = kToolbarHeight,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title != null
          ? Text(
              title!,
              style: titleStyle ??
                  AppTextStyles.textSize18(fontWeight: FontWeight.w400),
            )
          : null,
      centerTitle: true,
      backgroundColor: backgroundColor,
      automaticallyImplyLeading: false,
      leading: showLeading
          ? (leading ??
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
              ))
          : null,
      actions: actions,
    );
  }
}
