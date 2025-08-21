import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:thuongmaidientu/shared/utils/extension.dart';
import 'package:thuongmaidientu/shared/widgets/upload_image_widget.dart';

class CategoryCreate extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  late Uint8List image;

  final String? id;
  final String? imageInput;
  final String? name;

  CategoryCreate({
    super.key,
    this.id,
    this.imageInput,
    this.name,
  });

  @override
  Widget build(BuildContext context) {
    nameController.text = name ?? "";

    return Column(
      children: [
        TextFormField(
          controller: nameController,
          decoration: const InputDecoration(
            labelText: 'Tên danh mục',
            border: OutlineInputBorder(),
          ),
          validator: (value) =>
              value == null || value.isEmpty ? 'Bắt buộc' : null,
        ),
        20.h,
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: priceController,
                decoration: const InputDecoration(
                  labelText: 'mô tả',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
        30.h,
        MultiImagePickerWidget(
          allowMultiple: false,
          onSuccess: (p0) {
            if (p0.isNotEmpty) {
              image = p0[0];
            }
          },
        ),
        30.h,
      ],
    );
  }
}
