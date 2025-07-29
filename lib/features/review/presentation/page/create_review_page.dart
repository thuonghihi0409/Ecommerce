import 'dart:developer';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thuongmaidientu/core/app_assets.dart';
import 'package:thuongmaidientu/core/app_color.dart';
import 'package:thuongmaidientu/core/app_text_style.dart';
import 'package:thuongmaidientu/features/order/domain/entities/order_item.dart';
import 'package:thuongmaidientu/features/order/domain/entities/order_product_item.dart';
import 'package:thuongmaidientu/features/order/presentation/bloc/order_bloc/order_bloc.dart';
import 'package:thuongmaidientu/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:thuongmaidientu/features/review/domain/entities/review.dart';
import 'package:thuongmaidientu/features/review/presentation/bloc/review_bloc/review_bloc.dart';
import 'package:thuongmaidientu/shared/service/firebase_service.dart';
import 'package:thuongmaidientu/shared/service/navigator_service.dart';
import 'package:thuongmaidientu/shared/utils/extension.dart';
import 'package:thuongmaidientu/shared/utils/helper.dart';
import 'package:thuongmaidientu/shared/utils/parse_error_model.dart';
import 'package:thuongmaidientu/shared/widgets/appbar_custom.dart';
import 'package:thuongmaidientu/shared/widgets/button_custom.dart';
import 'package:thuongmaidientu/shared/widgets/laoding_custom.dart';
import 'package:thuongmaidientu/shared/widgets/overlay_custom.dart';
import 'package:thuongmaidientu/shared/widgets/rating_custom.dart';
import 'package:thuongmaidientu/shared/widgets/textfield_custom.dart';

class CreateReviewPage extends StatefulWidget {
  final OrderProductItem product;
  const CreateReviewPage({super.key, required this.product});

  @override
  State<CreateReviewPage> createState() => _CreateReviewPageState();
}

class _CreateReviewPageState extends State<CreateReviewPage> {
  int rating = 5;
  final TextEditingController _contentController = TextEditingController();
  final List<String> _images = [];
  late ProfileBloc _profileBloc;
  late ReviewBloc _reviewBloc;
  late OrderBloc _orderBloc;

  @override
  void initState() {
    super.initState();
    _profileBloc = context.read<ProfileBloc>();
    _reviewBloc = context.read<ReviewBloc>();
    _orderBloc = context.read<OrderBloc>();
  }

  void _submitReview() async {
    try {
      final content = _contentController.text.trim();
      if (content.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("key_please_enter_content_review".tr())),
        );
        return;
      }
      final listImage = await Future.wait(_images.map((image) async {
        final url = await FirebaseService.instance.uploadImages(File(image));
        return url ?? "";
      }).toList());
      final review = Review(
          id: '',
          content: content,
          imageUrls: listImage,
          rating: rating,
          likesCount: 0,
          user: _profileBloc.state.profile,
          productId: widget.product.productDetail?.productId,
          variant: widget.product.variant,
          createdAt: null);
      _reviewBloc.add(CreateReview(
          productOrderItemId: widget.product.id,
          review: review,
          onSuccess: () {
            _orderBloc.add(GetListOrder(
                id: _profileBloc.state.profile?.id,
                orderStatus: OrderStatus.delivered));
            NavigationService.instance.goBack();
          }));
    } catch (e) {
      Helper.showToastBottom(message: ParseError.fromJson(e).message);
      log(ParseError.fromJson(e).message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return OverlayLoadingCustom(
      loadingWidget:
          BlocBuilder<ReviewBloc, ReviewState>(builder: (context, state) {
        return CustomLoading(
          isOverlay: true,
          isLoading: state.isLoading,
        );
      }),
      child: Scaffold(
        appBar: CustomAppBar(title: "key_review_product".tr()),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("key_satisfy_level".tr(),
                  style: AppTextStyles.textSize16(fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              CustomRatingBar(
                rating: rating,
                starSize: 36,
                activeColor: Colors.amber,
                inactiveColor: Colors.grey.shade300,
                onRatingChanged: (value) {
                  setState(() {
                    rating = value;
                  });
                },
              ),
              25.h,
              Text("key_content_review".tr(),
                  style: AppTextStyles.textSize16(fontWeight: FontWeight.bold)),
              10.h,
              CustomTextField(
                borderColor: AppColor.primary,
                controller: _contentController,
                hintText: "key_your_experient_about_product".tr(),
                maxLine: 5,
              ),
              30.h,
              Text("key_image_optional".tr(),
                  style: AppTextStyles.textSize16(fontWeight: FontWeight.bold)),
              10.h,
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ..._images.map(
                    (file) => SizedBox(
                      width: context.widthScreen * 0.45,
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(File(file)),
                          ),
                          Positioned(
                            top: 10,
                            right: 10,
                            child: InkWell(
                              onTap: () {
                                setState(() => _images.remove(file));
                              },
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor:
                                    AppColor.greyColor.withAlpha(120),
                                child: SvgPicture.asset(
                                  AppAssets.deleteIcon,
                                  height: 30,
                                  width: 30,
                                  colorFilter: const ColorFilter.mode(
                                      AppColor.blackColor, BlendMode.srcIn),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Helper.showImagePickerDialog(context, onPickers: (p0) {
                        setState(() {
                          _images.addAll(p0 ?? []);
                        });
                      }, onCamera: (p1) {
                        setState(() {
                          _images.add(p1 ?? "");
                        });
                      });
                    },
                    child: DottedBorder(
                      options: const RectDottedBorderOptions(
                        color: AppColor.primary,
                        strokeWidth: 2,
                        dashPattern: [6, 3],
                      ),
                      child: Container(
                        height: 80,
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: SvgPicture.asset(AppAssets.cameraIcon),
                      ),
                    ),
                  ),
                ],
              ),
              30.h,
              CustomButton(
                text: "key_send_review".tr(),
                onPressed: _submitReview,
              )
            ],
          ),
        ),
      ),
    );
  }
}
