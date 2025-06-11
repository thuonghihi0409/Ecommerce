import 'package:flutter/material.dart';
import 'package:thuongmaidientu/core/app_color.dart';
import 'package:thuongmaidientu/features/product/domain/entities/product.dart';
import 'package:thuongmaidientu/shared/utils/extension.dart';
import 'package:thuongmaidientu/shared/widgets/image_cache_custom.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: AspectRatio(
                  aspectRatio: 1,
                  child: CustomCacheImageNetwork(imageUrl: product.cover)),
            ),
            const SizedBox(height: 8),

            // Product Name
            Text(
              product.productName,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),

            5.h,

            // Product Price
            Text(
              "\$${product.price}",
              style: const TextStyle(
                fontSize: 15,
                color: AppColor.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
