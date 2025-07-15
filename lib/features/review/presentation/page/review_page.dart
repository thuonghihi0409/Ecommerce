import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thuongmaidientu/core/app_assets.dart';
import 'package:thuongmaidientu/features/cart/presentation/bloc/cart_bloc/cart_bloc.dart';
import 'package:thuongmaidientu/features/cart/presentation/page/cart_page.dart';
import 'package:thuongmaidientu/features/chat/presentation/page/conversation_page.dart';
import 'package:thuongmaidientu/features/product/domain/entities/product_detail.dart';
import 'package:thuongmaidientu/features/product/presentation/widget/add_cart_widget.dart';
import 'package:thuongmaidientu/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:thuongmaidientu/features/review/presentation/bloc/review_bloc/review_bloc.dart';
import 'package:thuongmaidientu/features/review/presentation/page/create_review_page.dart';
import 'package:thuongmaidientu/features/review/presentation/widget/review_item_widget.dart';
import 'package:thuongmaidientu/shared/service/navigator_service.dart';
import 'package:thuongmaidientu/shared/utils/extension.dart';
import 'package:thuongmaidientu/shared/utils/helper.dart';
import 'package:thuongmaidientu/shared/widgets/appbar_custom.dart';
import 'package:thuongmaidientu/shared/widgets/button_custom.dart';
import 'package:thuongmaidientu/shared/widgets/laoding_custom.dart';

class ReviewPage extends StatefulWidget {
  final ProductDetail? productDetail;
  const ReviewPage({super.key, required this.productDetail});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _getDate();
  }

  _getDate() async {
    context
        .read<ReviewBloc>()
        .add(GetListReview(id: widget.productDetail?.productId ?? ""));
  }

  void _onRefresh() {}

  void _onLoading() {}

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewBloc, ReviewState>(builder: (context, state) {
      return Scaffold(
        appBar: CustomAppBar(
          title: "key_review".tr(),
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
        body: Builder(builder: (context) {
          if (state.isLoading) {
            return const CustomLoading(
              isLoading: true,
            );
          }
          return Column(
            children: [
              5.h,
              CustomButton(
                text: "Danh Gia",
                onPressed: () {
                  NavigationService.instance.push(const CreateReviewPage());
                },
              ),
              Expanded(
                child: ListView.separated(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(8),
                  itemCount: state.listReview.results?.length ?? 0,
                  itemBuilder: (context, index) {
                    final review = state.listReview.results?[index];
                    return ReviewItemWidget(review: review);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider();
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: "key_chat".tr(),
                      borderRadius: 0,
                    ),
                  ),
                  2.w,
                  Expanded(
                      child: CustomButton(
                    text: "key_add_to_cart".tr(),
                    borderRadius: 0,
                    onPressed: () {
                      Helper.showCustomBottomSheet(
                        headerCustom: Column(
                          children: [
                            AddCartWidget(productDetail: widget.productDetail),
                            CustomButton(
                              text: "key_add_to_cart".tr(),
                              onPressed: () {
                                BlocProvider.of<CartBloc>(context)
                                    .add(const AddToCart());
                                NavigationService.instance.goBack();
                              },
                            ),
                            10.h
                          ],
                        ),
                        context: context,
                      );
                    },
                  )),
                  2.w,
                  Expanded(
                      child: CustomButton(
                    text: "key_buy_now".tr(),
                    borderRadius: 0,
                    onPressed: () {
                      Helper.showCustomBottomSheet(
                        headerCustom: Column(
                          children: [
                            AddCartWidget(productDetail: widget.productDetail),
                            CustomButton(
                              text: "key_buy_now".tr(),
                              onPressed: () {
                                BlocProvider.of<CartBloc>(context)
                                    .add(const AddToCart());
                                NavigationService.instance.goBack();
                              },
                            ),
                            10.h
                          ],
                        ),
                        context: context,
                      );
                    },
                  )),
                ],
              )
            ],
          );
        }),
      );
    });
  }
}
