import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thuongmaidientu/core/app_assets.dart';
import 'package:thuongmaidientu/core/app_color.dart';
import 'package:thuongmaidientu/core/app_text_style.dart';
import 'package:thuongmaidientu/features/cart/presentation/page/cart_page.dart';
import 'package:thuongmaidientu/features/chat/presentation/page/conversation_page.dart';
import 'package:thuongmaidientu/features/product/presentation/bloc/product_bloc/product_bloc.dart';
import 'package:thuongmaidientu/features/product/presentation/page/product_detail_page.dart';
import 'package:thuongmaidientu/features/product/presentation/widget/product_card.dart';
import 'package:thuongmaidientu/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:thuongmaidientu/shared/service/navigator_service.dart';
import 'package:thuongmaidientu/shared/utils/extension.dart';
import 'package:thuongmaidientu/shared/widgets/appbar_custom.dart';
import 'package:thuongmaidientu/shared/widgets/image_cache_custom.dart';
import 'package:thuongmaidientu/shared/widgets/laoding_custom.dart';
import 'package:thuongmaidientu/shared/widgets/textfield_custom.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final ScrollController _scrollController = ScrollController();
  int _selectCategory = -1;

  @override
  void initState() {
    super.initState();
    _getDate();
  }

  _getDate() async {
    context.read<ProductBloc>()
      ..add(const GetListProduct())
      ..add(const GetListCategory());
  }

  void _onRefresh() {}

  void _onLoading() {}

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
      return Scaffold(
        backgroundColor: AppColor.greyColor.withAlpha(20),
        appBar: CustomAppBar(
          customTitle: const CustomSearchField(),
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
        body: Builder(builder: (context) {
          if (state.isLoading) {
            return const CustomLoading(
              isLoading: true,
            );
          }
          return Column(
            children: [
              5.h,
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    children: (state.listCategory ??
                            [
                             
                            ])
                        .asMap()
                        .entries
                        .map((e) => Container(
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                  color: _selectCategory == e.key
                                      ? AppColor.primary.withAlpha(50)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(5)),
                              child: InkWell(
                                onTap: () {
                                  if (_selectCategory != e.key) {
                                    setState(() {
                                      _selectCategory = e.key;
                                    });
                                  } else {
                                    setState(() {
                                      _selectCategory = -1;
                                    });
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  child: Column(
                                    children: [
                                      CustomCacheImageNetwork(
                                        height: 100,
                                        width: 80,
                                        borderRadius: 5,
                                        imageUrl: e.value.cover,
                                        isShowLoading: false,
                                      ),
                                      Text(
                                        e.value.name ?? "",
                                        style: AppTextStyles.textSize12(),
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ))
                        .toList()),
              ),
              Expanded(
                child: GridView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: state.listProduct.results?.length ?? 0,
                  itemBuilder: (context, index) {
                    final product = state.listProduct.results?[index];
                    return ProductCard(
                      product: product!,
                      onTap: () {
                        NavigationService.instance.push(ProductDetailPage(
                          product: product,
                        ));
                      },
                    );
                  },
                ),
              ),
            ],
          );
        }),
      );
    });
  }
}
