import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thuongmaidientu/core/app_assets.dart';
import 'package:thuongmaidientu/core/app_color.dart';
import 'package:thuongmaidientu/core/app_text_style.dart';
import 'package:thuongmaidientu/features/customer/product/presentation/bloc/product_bloc/product_bloc.dart';
import 'package:thuongmaidientu/features/customer/product/presentation/page/product_detail_page.dart';
import 'package:thuongmaidientu/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:thuongmaidientu/shared/service/navigator_service.dart';
import 'package:thuongmaidientu/shared/utils/helper.dart';
import 'package:thuongmaidientu/shared/widgets/appbar_custom.dart';
import 'package:thuongmaidientu/shared/widgets/image_cache_custom.dart';
import 'package:thuongmaidientu/shared/widgets/laoding_custom.dart';
import 'package:thuongmaidientu/shared/widgets/overlay_custom.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  late ProductBloc _bloc;
  late String _userId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = context.read<ProductBloc>();
    _userId = context.read<ProfileBloc>().state.profile?.id ?? "";
    _getData();
  }

  _getData() async {
    _bloc.add(GetWistlist(userId: _userId));
  }

  @override
  Widget build(BuildContext context) {
    return OverlayLoadingCustom(
      loadingWidget: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) => CustomLoading(
                isOverlay: true,
                isLoading: state.isLoading,
              )),
      child: Scaffold(
        appBar: CustomAppBar(
          title: "key_wishlist".tr(),
        ),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            final products = state.wishlist ?? [];
            return Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 12),
              child: ListView.separated(
                  itemBuilder: (conttext, index) => ListTile(
                        onTap: () {
                          NavigationService.instance.push(ProductDetailPage(
                              productId: products[index].productId,
                              categoryId: products[index].categoryId ?? ""));
                        },
                        trailing: InkWell(
                          onTap: () {
                            context.read<ProductBloc>().add(UpdateWistlist(
                                productId: products[index].productId,
                                userId: _userId,
                                isLike: false));
                          },
                          child: SvgPicture.asset(
                            height: 30,
                            width: 30,
                            AppAssets.deleteIcon,
                            colorFilter: const ColorFilter.mode(
                                AppColor.primary, BlendMode.srcIn),
                          ),
                        ),
                        title: Text(
                          products[index].productName ?? "",
                          style: AppTextStyles.textSize16(
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              products[index].store?.name ?? "",
                              style: AppTextStyles.textSize14(
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.greyColor),
                            ),
                            Text(
                              "${"key_price".tr()}: ${Helper.formatCurrencyVND(products[index].price)}",
                              style: AppTextStyles.textSize14(),
                            )
                          ],
                        ),
                        leading: CustomCacheImageNetwork(
                            height: 60,
                            width: 60,
                            borderRadius: 30,
                            imageUrl: products[index].cover),
                      ),
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: products.length),
            );
          },
        ),
      ),
    );
  }
}
