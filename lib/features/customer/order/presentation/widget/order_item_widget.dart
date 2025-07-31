import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuongmaidientu/core/app_color.dart';
import 'package:thuongmaidientu/core/app_text_style.dart';
import 'package:thuongmaidientu/features/customer/order/domain/entities/order_item.dart';
import 'package:thuongmaidientu/features/customer/order/presentation/bloc/order_bloc/order_bloc.dart';
import 'package:thuongmaidientu/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:thuongmaidientu/features/review/presentation/page/create_review_page.dart';
import 'package:thuongmaidientu/shared/service/navigator_service.dart';
import 'package:thuongmaidientu/shared/utils/extension.dart';
import 'package:thuongmaidientu/shared/utils/helper.dart';
import 'package:thuongmaidientu/shared/widgets/button_custom.dart';
import 'package:thuongmaidientu/shared/widgets/image_cache_custom.dart';

class OrderItemWidget extends StatefulWidget {
  final OrderItem orderItem;
  final bool isCreating;
  const OrderItemWidget(
      {super.key, required this.orderItem, this.isCreating = false});

  @override
  State<OrderItemWidget> createState() => _OrderItemWidgetState();
}

class _OrderItemWidgetState extends State<OrderItemWidget> {
  late OrderBloc _bloc;
  @override
  void initState() {
    super.initState();
    _bloc = context.read<OrderBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColor.primary.withAlpha(30)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.orderItem.store.name ?? "",
                style: AppTextStyles.textSize20(),
              ),
              if (!widget.isCreating)
                Text(orderStatusToText(widget.orderItem.status))
            ],
          ),
          const Divider(),
          5.h,
          ...widget.orderItem.productItem.asMap().entries.map((entrie) =>
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    CustomCacheImageNetwork(
                      borderRadius: 5,
                      imageUrl: entrie.value.variant?.cover,
                      height: 60,
                      width: 60,
                      boxFit: BoxFit.fill,
                    ),
                    20.w,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            entrie.value.productDetail?.productName ?? "",
                            style: AppTextStyles.textSize18(),
                          ),
                          8.h,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                entrie.value.variant?.name ?? "",
                                style: AppTextStyles.textSize14(),
                              ),
                              Text(
                                "x ${entrie.value.number}",
                                style: AppTextStyles.textSize14(),
                              )
                            ],
                          ),
                          5.h,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                Helper.formatCurrencyVND(
                                    (entrie.value.variant?.price ?? 0)),
                                style: AppTextStyles.textSize12(),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          if (!entrie.value.isReviewed &&
                              widget.orderItem.status == OrderStatus.delivered)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CustomButton(
                                  padding: const EdgeInsets.all(10),
                                  borderRadius: 15,
                                  isMinWidth: true,
                                  text: "key_review".tr(),
                                  onPressed: () {
                                    NavigationService.instance
                                        .push(CreateReviewPage(
                                      product: entrie.value,
                                    ));
                                  },
                                ),
                              ],
                            ),
                          if (entrie.value.isReviewed)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CustomButton(
                                  backgroundColor: AppColor.whiteColor,
                                  textStyle: AppTextStyles.textSize16(
                                      color: AppColor.primary),
                                  borderColor: AppColor.primary,
                                  padding: const EdgeInsets.all(10),
                                  borderRadius: 15,
                                  isMinWidth: true,
                                  text: "key_view_review".tr(),
                                  onPressed: () {
                                    NavigationService.instance
                                        .push(CreateReviewPage(
                                      product: entrie.value,
                                    ));
                                  },
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  "${"key_total_currency".tr()}: ${Helper.formatCurrencyVND(widget.orderItem.total)}"),
              if (widget.orderItem.status == OrderStatus.pending &&
                  !widget.isCreating)
                Row(
                  children: [
                    CustomButton(
                      isMinWidth: true,
                      text: "key_cancel_order".tr(),
                      onPressed: () {
                        _bloc.add(UpdateOrder(
                            id: context.read<ProfileBloc>().state.profile?.id ??
                                "",
                            order: widget.orderItem,
                            newStatus: OrderStatus.cancelled));
                      },
                    ),
                  ],
                ),
              if (widget.orderItem.status == OrderStatus.awaiting)
                Row(
                  children: [
                    CustomButton(
                      isMinWidth: true,
                      text: "key_cancel_order".tr(),
                      onPressed: () {
                        _bloc.add(UpdateOrder(
                            id: context.read<ProfileBloc>().state.profile?.id ??
                                "",
                            order: widget.orderItem,
                            newStatus: OrderStatus.cancelled));
                      },
                    ),
                  ],
                ),
            ],
          )
        ],
      ),
    );
  }
}
