import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:live_currency_rate/live_currency_rate.dart';
import 'package:thuongmaidientu/core/app_color.dart';
import 'package:thuongmaidientu/core/app_text_style.dart';
import 'package:thuongmaidientu/features/customer/cart/domain/entities/cart_item.dart';
import 'package:thuongmaidientu/features/customer/cart/presentation/bloc/cart_bloc/cart_bloc.dart';
import 'package:thuongmaidientu/features/customer/order/domain/entities/order_item.dart';
import 'package:thuongmaidientu/features/customer/order/presentation/bloc/order_bloc/order_bloc.dart';
import 'package:thuongmaidientu/features/customer/order/presentation/widget/order_item_widget.dart';
import 'package:thuongmaidientu/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:thuongmaidientu/features/profile/presentation/page/add_address.dart';
import 'package:thuongmaidientu/shared/service/navigator_service.dart';
import 'package:thuongmaidientu/shared/utils/extension.dart';
import 'package:thuongmaidientu/shared/utils/helper.dart';
import 'package:thuongmaidientu/shared/widgets/appbar_custom.dart';
import 'package:thuongmaidientu/shared/widgets/button_custom.dart';
import 'package:thuongmaidientu/shared/widgets/location_widget.dart';

class CreateOrderPage extends StatefulWidget {
  final List<CartItem?> cartItems;
  final int total;
  final int subtotal;
  final bool isDeleteCart;
  const CreateOrderPage(
      {super.key,
      required this.subtotal,
      required this.cartItems,
      required this.total,
      this.isDeleteCart = false});

  @override
  State<CreateOrderPage> createState() => _CreateOrderPageState();
}

class _CreateOrderPageState extends State<CreateOrderPage> {
  bool _isOnline = true;
  int index = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final addresses = context.read<ProfileBloc>().state.address ?? [];
    return Scaffold(
      appBar: const CustomAppBar(
        height: 10,
        isShowCartIcon: false,
        isShowChatIcon: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "key_address_delivery".tr(),
                      style: AppTextStyles.textSize16(),
                    ),
                    (addresses).isNotEmpty
                        ? LocationWidget(
                            address: addresses[index],
                            onTap: () {
                              Helper.showCustomDialog(
                                  context: context,
                                  onPressPrimaryButton: () {},
                                  isShowPrimaryButton: false,
                                  message: "Chọn địa chỉ giao hàng",
                                  headerCustom: Column(
                                    children: [
                                      ...addresses
                                          .map(((item) => LocationWidget(
                                                address: item,
                                                onTap: () {
                                                  setState(
                                                    () {
                                                      index = addresses
                                                          .indexOf(item);
                                                    },
                                                  );
                                                  NavigationService.instance
                                                      .goBack();
                                                },
                                              ))),
                                      _addLocation()
                                    ],
                                  ));
                            },
                          )
                        : _addLocation(),
                    10.h,
                    ...widget.cartItems.map((product) => OrderItemWidget(
                          isCreating: true,
                          orderItem: OrderItem.copyFromCartItem(
                              product!, null, "cash", false),
                        )),
                    10.h,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${"key_total_currency".tr()}: "),
                        Text(Helper.formatCurrencyVND(widget.subtotal))
                      ],
                    ),
                    20.h,
                    const Divider(),
                    10.h,
                    Text(
                      "key_select_payment_method".tr(),
                      style:
                          AppTextStyles.textSize18(fontWeight: FontWeight.bold),
                    ),
                    CheckboxListTile(
                      checkColor: AppColor.primary,
                      fillColor: WidgetStatePropertyAll(
                          AppColor.primary.withAlpha(50)),
                      checkboxShape: RoundedRectangleBorder(
                          side: const BorderSide(
                              width: 0.01, color: AppColor.primary),
                          borderRadius: BorderRadiusGeometry.circular(5)),
                      value: _isOnline,
                      onChanged: (val) {
                        setState(() {
                          _isOnline = true;
                        });
                      },
                      title: Text("key_payment_online".tr(),
                          style: AppTextStyles.textSize16()),
                    ),
                    10.h,
                    CheckboxListTile(
                      checkColor: AppColor.primary,
                      fillColor: WidgetStatePropertyAll(
                          AppColor.primary.withAlpha(50)),
                      checkboxShape: RoundedRectangleBorder(
                          side: const BorderSide(
                              width: 0.01, color: AppColor.primary),
                          borderRadius: BorderRadiusGeometry.circular(5)),
                      value: !_isOnline,
                      onChanged: (value) {
                        setState(() {
                          _isOnline = false;
                        });
                      },
                      title: Text("key_payment_after_recieve_product".tr(),
                          style: AppTextStyles.textSize16()),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: "key_cancel".tr(),
                    onPressed: () {
                      NavigationService.instance.goBack();
                    },
                  ),
                ),
                10.w,
                Expanded(
                  child: CustomButton(
                    isEnable: addresses.isNotEmpty,
                    text: _isOnline ? "key_payment".tr() : "key_ordering".tr(),
                    onPressed: () async {
                      final userId =
                          context.read<ProfileBloc>().state.profile?.id ?? "";
                      final totalUSD = await LiveCurrencyRate.convertCurrency(
                          "VND", "USD", widget.total.toDouble());

                      if (_isOnline) {
                        NavigationService.instance.push(
                          PaypalCheckoutView(
                            sandboxMode: true,
                            clientId: dotenv.env["PAYPAL_CLIENT_ID"]!,
                            secretKey:
                                "", // Có thể bỏ qua nếu không dùng server
                            transactions: [
                              {
                                "amount": {
                                  "total": totalUSD.result.round().toString(),
                                  "currency": 'USD',
                                  "details": {
                                    "subtotal":
                                        totalUSD.result.round().toString(),
                                    "shipping": '0',
                                    "shipping_discount": '0'
                                  }
                                },
                                "description": "Mua sản phẩm công nghệ",
                                "item_list": {
                                  "items": [
                                    {
                                      "name": "Tai nghe Bluetooth",
                                      "quantity": 1,
                                      "price":
                                          totalUSD.result.round().toString(),
                                      "currency": 'USD'
                                    }
                                  ],
                                }
                              }
                            ],
                            note: "Cảm ơn bạn đã mua hàng!",
                            onSuccess: (Map params) {
                              log(params.toString());
                              context.read<OrderBloc>().add(CreateOrder(
                                  onSuccess: () {
                                    // context
                                    //     .read<CartBloc>()
                                    //     .add(GetListCart(id: userId));
                                    context
                                        .read<CartBloc>()
                                        .add(GetCountCart(userId: userId));
                                    NavigationService.instance.goBack();
                                    NavigationService.instance.goBack();
                                  },
                                  isDeleteCart: widget.isDeleteCart,
                                  userId: userId,
                                  orders: widget.cartItems
                                      .map((item) => OrderItem.copyFromCartItem(
                                          item!, addresses[0], "online", true))
                                      .toList()));
                              Navigator.pop(context);
                            },
                            onCancel: () {
                              NavigationService.instance.goBack();
                            },
                            onError: (error) {
                              NavigationService.instance.goBack();
                            },
                          ),
                        );
                      } else {
                        context.read<OrderBloc>().add(CreateOrder(
                            onSuccess: () {
                              // context
                              //     .read<CartBloc>()
                              //     .add(GetListCart(id: userId));
                              NavigationService.instance.goBack();
                              NavigationService.instance.goBack();
                            },
                            isDeleteCart: widget.isDeleteCart,
                            userId: userId,
                            orders: widget.cartItems
                                .map((item) => OrderItem.copyFromCartItem(
                                    item!, addresses[index], "cash", false))
                                .toList()));
                      }
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  _addLocation() {
    return InkWell(
      onTap: () {
        NavigationService.instance.push(AddAddressPage(
          onSuccess: () {
            setState(() {});
          },
        ));
      },
      child: Row(
        children: [
          const Icon(Icons.add),
          20.w,
          Text(
            "key_add_location".tr(),
            style: AppTextStyles.textSize18(),
          )
        ],
      ),
    );
  }
}
