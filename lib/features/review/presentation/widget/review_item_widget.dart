import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:thuongmaidientu/core/app_color.dart';
import 'package:thuongmaidientu/core/app_text_style.dart';
import 'package:thuongmaidientu/features/review/domain/entities/review.dart';
import 'package:thuongmaidientu/shared/utils/extension.dart';
import 'package:thuongmaidientu/shared/widgets/image_cache_custom.dart';

class ReviewItemWidget extends StatelessWidget {
  final Review? review;
  const ReviewItemWidget({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: AppColor.whiteColor, borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomCacheImageNetwork(
                imageUrl: review?.user?.image,
                height: 40,
                width: 40,
              ),
              10.w,
              Text(
                review?.user?.fullname ?? "",
                style: AppTextStyles.textSize14(),
              )
            ],
          ),
          10.h,
          Row(
            children: List.generate(
                review?.rating ?? 0,
                (_) => const Icon(Icons.star,
                    color: AppColor.yellowColor, size: 14)).toList(),
          ),
          20.h,
          Text(
            "${"key_variant".tr()}: ${review?.variant?.name ?? ""}",
            style: AppTextStyles.textSize16(color: AppColor.greyColor),
          ),
          10.h,
          Text(
            review?.content ?? "",
            style: AppTextStyles.textSize14(),
          ),
          const Wrap(
            children: [],
          )
        ],
      ),
    );
  }
}
