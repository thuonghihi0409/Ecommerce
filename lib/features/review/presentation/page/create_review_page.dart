import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thuongmaidientu/core/app_assets.dart';
import 'package:thuongmaidientu/core/app_color.dart';
import 'package:thuongmaidientu/shared/utils/extension.dart';
import 'package:thuongmaidientu/shared/utils/helper.dart';
import 'package:thuongmaidientu/shared/widgets/appbar_custom.dart';
import 'package:thuongmaidientu/shared/widgets/button_custom.dart';
import 'package:thuongmaidientu/shared/widgets/rating_custom.dart';
import 'package:thuongmaidientu/shared/widgets/textfield_custom.dart';

class CreateReviewPage extends StatefulWidget {
  const CreateReviewPage({super.key});

  @override
  State<CreateReviewPage> createState() => _CreateReviewPageState();
}

class _CreateReviewPageState extends State<CreateReviewPage> {
  double rating = 5;
  final TextEditingController _contentController = TextEditingController();
  final List<String> _images = [];

  void _submitReview() {
    final content = _contentController.text.trim();
    if (content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Vui lòng nhập nội dung đánh giá")),
      );
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Danh Gia San Pham"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Mức độ hài lòng",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
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
            const SizedBox(height: 24),
            const Text("Nội dung đánh giá",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            CustomTextField(
              borderColor: AppColor.primary,
              controller: _contentController,
              hintText: "Chia sẻ trải nghiệm của bạn về sản phẩm",
              maxLine: 5,
            ),
            const SizedBox(height: 24),
            const Text("Hình ảnh (tùy chọn)",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ..._images.map(
                  (file) => SizedBox(
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
              text: "Gửi đánh giá",
              onPressed: _submitReview,
            )
          ],
        ),
      ),
    );
  }
}
