import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuongmaidientu/core/app_text_style.dart';
import 'package:thuongmaidientu/features/product/domain/entities/product.dart';
import 'package:thuongmaidientu/features/product_management/presentation/bloc/product_management_bloc/product_management_bloc.dart';
import 'package:thuongmaidientu/shared/utils/extension.dart';
import 'package:thuongmaidientu/shared/widgets/image_cache_custom.dart';

class ItemProducts extends StatefulWidget {
  const ItemProducts(
      {super.key,
      required this.item,
      required this.index,
      this.function,
      this.onAction});
  final int index;
  final Product item;
  final Function? onAction;
  final Function(Product)? function;

  @override
  State<ItemProducts> createState() => _ItemProductsState();
}

class _ItemProductsState extends State<ItemProducts> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.function!.call(widget.item);
        //log("lick product");
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 0,
        ),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
          //color: Colors.pink
        ),
        child: Row(
          children: [
            _tableCell(
                Text(
                  "${widget.index + 1}",
                  style: AppTextStyles.textSize10(),
                ),
                flex: 1,
                isCenter: true),
            _tableCell(LayoutBuilder(builder: (context, constrains) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomCacheImageNetwork(
                    imageUrl: widget.item.cover!,
                    width: 25,
                    height: 25,
                  ),
                  5.w,
                  Expanded(
                    child: Text(
                      widget.item.productName ?? "",
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.textSize10(),
                    ),
                  ),
                  5.w
                ],
              );
            }), flex: 4),
            _tableCell(
                Text(
                  widget.item.categoryId ?? "",
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.textSize10(),
                ),
                flex: 4,
                isCenter: true),
            _tableCell(Text(widget.item.totalSold.toString()),
                flex: 2, isCenter: true),
            _tableCell(
                ButtonCustom(
                    height: 25,
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    title: widget.item.status == StatusProduct.published
                        ? "key_unpublish".tr()
                        : "key_publish".tr(),
                    onPressed: () {
                      BlocProvider.of<ProductsBloc>(context).add(
                        UpdateStatus(
                            productId: widget.item.id ?? "",
                            status:
                                widget.item.status == StatusProduct.published
                                    ? StatusProduct.unpublished
                                    : StatusProduct.published,
                            onSuccess: widget.onAction),
                      );
                    }),
                flex: 2,
                isCenter: true),
          ],
        ),
      ),
    );
  }

  Widget _tableCell(Widget child, {int flex = 1, bool isCenter = false}) {
    return Expanded(
      flex: flex,
      child: Container(
        //color: Colors.amber,
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: Align(
          alignment: isCenter ? Alignment.center : Alignment.centerLeft,
          child: child,
        ),
      ),
    );
  }
}
