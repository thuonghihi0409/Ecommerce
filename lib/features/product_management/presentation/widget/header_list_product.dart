import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:thuongmaidientu/core/app_color.dart';
import 'package:thuongmaidientu/core/app_text_style.dart';
import 'package:thuongmaidientu/shared/utils/extension.dart';

enum SortStatus { none, asc, desc }

class HeaderListProduct extends StatefulWidget {
  final List<SortStatus>? orderByNameASC;
  final Function(List<SortStatus>)? onAction;

  const HeaderListProduct({super.key, this.orderByNameASC, this.onAction});

  @override
  State<HeaderListProduct> createState() => _HeaderListProductState();
}

class _HeaderListProductState extends State<HeaderListProduct> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.symmetric(
        vertical: 2,
      ),
      child: Row(
        children: [
          _headerCell("key_#".tr(), false, flex: 1),
          _headerCell("key_name".tr(), true, flex: 4),
          _headerCell("key_categories".tr(), false, flex: 4),
          _headerCell("key_type".tr(), false, flex: 2),
          _headerCell("key_sold_out".tr(), false, flex: 2),
          _headerCell("key_actions".tr(), false, flex: 2),
        ],
      ),
    );
  }

  Widget _headerCell(String title, bool isOrder, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: InkWell(
        onTap: () {
          if (!isOrder) return;
          if (widget.orderByNameASC?[0] == SortStatus.none) {
            setState(() {
              widget.orderByNameASC?[0] = SortStatus.asc;
            });
          } else if (widget.orderByNameASC?[0] == SortStatus.asc) {
            setState(() {
              widget.orderByNameASC?[0] = SortStatus.desc;
            });
          } else {
            setState(() {
              widget.orderByNameASC?[0] = SortStatus.none;
            });
          }
          widget.onAction?.call(widget.orderByNameASC ?? [SortStatus.none]);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  title,
                  style: AppTextStyles.textSize12(color: AppColor.whiteColor),
                  textAlign: TextAlign.center,
                ),
              ),
              if (isOrder) 4.w,
              if (isOrder) _sortButtom()
            ],
          ),
        ),
      ),
    );
  }

  Widget _sortButtom() {
    return Container(
      padding: const EdgeInsets.only(left: 3),

      // widget.orderByNameASC?[0] == SortStatus.none
      //     ? Column(
      //         children: [
      //           SvgPicture.asset(
      //             AppAssets.orderDecsIcon,
      //             colorFilter:
      //                 ColorFilter.mode(AppColor.whiteColor, BlendMode.srcIn),
      //             width: 4.5,
      //             height: 4.5,
      //           ),
      //           1.h,
      //           SvgPicture.asset(
      //             AppAssets.ordorAscIcon,
      //             colorFilter:
      //                 ColorFilter.mode(AppColor.whiteColor, BlendMode.srcIn),
      //             width: 4.5,
      //             height: 4.5,
      //           )
      //         ],
      //       )
      //     : widget.orderByNameASC?[0] == SortStatus.desc
      //         ? SvgPicture.asset(
      //             AppAssets.orderDecsIcon,
      //             colorFilter:
      //                 ColorFilter.mode(AppColors.whiteColor, BlendMode.srcIn),
      //             width: 4.5,
      //             height: 4.5,
      //           )
      //         : SvgPicture.asset(
      //             AppAssets.ordorAscIcon,
      //             colorFilter:
      //                 ColorFilter.mode(AppColors.whiteColor, BlendMode.srcIn),
      //             width: 4.5,
      //             height: 4.5,
      //           )
    );
  }
}
