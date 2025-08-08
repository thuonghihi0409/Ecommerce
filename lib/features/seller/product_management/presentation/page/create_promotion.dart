import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuongmaidientu/core/app_color.dart';
import 'package:thuongmaidientu/core/app_text_style.dart';
import 'package:thuongmaidientu/features/customer/product/domain/entities/promotion.dart';
import 'package:thuongmaidientu/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:thuongmaidientu/features/seller/product_management/domain/entities/seller_product.dart';
import 'package:thuongmaidientu/features/seller/product_management/presentation/bloc/product_management_bloc/product_management_bloc.dart';
import 'package:thuongmaidientu/features/seller/product_management/presentation/bloc/promotion_bloc/promotion_bloc.dart';
import 'package:thuongmaidientu/shared/service/navigator_service.dart';
import 'package:thuongmaidientu/shared/utils/extension.dart';
import 'package:thuongmaidientu/shared/widgets/button_custom.dart';

class CreatePromotionPage extends StatefulWidget {
  const CreatePromotionPage({super.key});

  @override
  State<CreatePromotionPage> createState() => _CreatePromotionPageState();
}

class _CreatePromotionPageState extends State<CreatePromotionPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _discountController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  List<SellerProduct> allProducts = [];
  List<SellerProduct> selectedProducts = [];
  List<SellerProduct> availableProducts = [];

  bool applyToAll = false;

  @override
  void initState() {
    super.initState();

    allProducts =
        context.read<ProductManagementBloc>().state.listProduct.results ?? [];

    availableProducts = List.from(allProducts);
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 1)),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  void _submit() {
    if (_formKey.currentState?.validate() != true) return;
    if (!applyToAll && selectedProducts.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Vui lòng chọn ít nhất một sản phẩm")),
      );
      return;
    }
    if (_startDate == null || _endDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select start and end dates.")),
      );
      return;
    }

    if (_startDate!.isAfter(_endDate!)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Start date must be before end date.")),
      );
      return;
    }

    context.read<PromotionBloc>().add(SellerCreatePromotion(
        promotion: Promotion(
            id: "",
            name: _titleController.text,
            amount: double.tryParse(_discountController.text) ?? 0,
            startTime: _startDate,
            endTime: _endDate,
            type: "per",
            storeId: context.read<ProfileBloc>().state.store?.id),
        products: applyToAll ? allProducts : selectedProducts,
        onSuccess: () {
          NavigationService.instance.pushNamed("promotion_management");
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("key_create_promotion".tr()),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _titleController,
                      decoration: InputDecoration(
                          labelText: "key_promotion_title".tr(),
                          border: const OutlineInputBorder()),
                      validator: (value) => value == null || value.isEmpty
                          ? "Title is required"
                          : null,
                    ),
                  ),
                  30.w,
                  Expanded(
                    child: TextFormField(
                      controller: _discountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "key_discount_percent".tr(),
                          border: const OutlineInputBorder()),
                      validator: (value) {
                        final numValue = num.tryParse(value ?? '');
                        if (numValue == null ||
                            numValue <= 0 ||
                            numValue > 100) {
                          return "Enter valid discount (1-100)";
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              30.h,
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "key_start_date".tr(),
                          style: AppTextStyles.textSize16(),
                        ),
                        5.h,
                        InkWell(
                          onTap: () => _selectDate(context, true),
                          child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  color: AppColor.greyColor.withAlpha(50),
                                  borderRadius: BorderRadius.circular(5)),
                              padding: const EdgeInsets.all(8),
                              child: Text(_startDate != null
                                  ? DateFormat('yyyy-MM-dd').format(_startDate!)
                                  : "key_select_start_date".tr())),
                        ),
                      ],
                    ),
                  ),
                  30.w,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "key_end_date".tr(),
                          style: AppTextStyles.textSize16(),
                        ),
                        5.h,
                        InkWell(
                          onTap: () => _selectDate(context, false),
                          child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  color: AppColor.greyColor.withAlpha(50),
                                  borderRadius: BorderRadius.circular(5)),
                              padding: const EdgeInsets.all(8),
                              child: Text(_endDate != null
                                  ? DateFormat('yyyy-MM-dd').format(_endDate!)
                                  : "key_select_end_date".tr())),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              40.h,
              CustomButton(
                text: "key_create_promotion".tr(),
                onPressed: _submit,
              ),
              30.h,
              CheckboxListTile(
                value: applyToAll,
                onChanged: (value) {
                  setState(() {
                    applyToAll = value ?? false;
                    if (applyToAll) {
                      selectedProducts = List.from(allProducts);
                      availableProducts.clear();
                    } else {
                      selectedProducts.clear();
                      availableProducts = List.from(allProducts);
                    }
                  });
                },
                title: const Text("Áp dụng cho tất cả sản phẩm"),
              ),
              30.h,
              if (!applyToAll) ...[
                const Text("✅ Sản phẩm được chọn:",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: selectedProducts
                      .map((product) => Chip(
                            label: Text(product.productName ?? ""),
                            deleteIcon: const Icon(Icons.close),
                            onDeleted: () {
                              setState(() {
                                selectedProducts.remove(product);
                                availableProducts.add(product);
                              });
                            },
                          ))
                      .toList(),
                ),
                20.h,
                const Text("➕ Chọn thêm sản phẩm:",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: availableProducts.length,
                  itemBuilder: (context, index) {
                    final product = availableProducts[index];
                    return ListTile(
                      title: Text(product.productName ?? ""),
                      trailing: IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            availableProducts.remove(product);
                            selectedProducts.add(product);
                          });
                        },
                      ),
                    );
                  },
                ),
                30.h,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
