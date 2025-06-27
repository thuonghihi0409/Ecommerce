import 'dart:async';

import 'package:flutter/material.dart';
import 'package:thuongmaidientu/core/app_color.dart';
import 'package:thuongmaidientu/core/app_text_style.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final bool obscureText;
  final bool isPassword;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final AutovalidateMode? autoValidateMode;

  // Style custom thêm
  final TextStyle? textStyle;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final Color? fillColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final EdgeInsetsGeometry? contentPadding;

  final int? maxLine;

  const CustomTextField(
      {super.key,
      this.controller,
      this.labelText,
      this.hintText,
      this.obscureText = false,
      this.isPassword = false,
      this.prefixIcon,
      this.suffixIcon,
      this.validator,
      this.onChanged,
      this.onFieldSubmitted,
      this.keyboardType = TextInputType.text,
      this.textInputAction,
      this.focusNode,
      this.autoValidateMode,
      this.textStyle,
      this.labelStyle,
      this.hintStyle,
      this.fillColor,
      this.borderColor,
      this.focusedBorderColor,
      this.contentPadding,
      this.maxLine = 1});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscure;

  @override
  void initState() {
    super.initState();
    _obscure = widget.obscureText;
  }

  void _toggleVisibility() {
    setState(() {
      _obscure = !_obscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    final defaultBorderColor = widget.borderColor ?? AppColor.greyColor;
    final defaultFocusedBorderColor =
        widget.focusedBorderColor ?? AppColor.primary;
    final defaultPadding = widget.contentPadding ??
        const EdgeInsets.symmetric(vertical: 14, horizontal: 16);

    return Column(
      children: [
        Row(
          children: [
            if (widget.labelText != null)
              Text(
                widget.labelText!,
                style: AppTextStyles.textSize14(),
              )
          ],
        ),
        const SizedBox(
          height: 2,
        ),
        TextFormField(
          maxLines: widget.maxLine,
          controller: widget.controller,
          obscureText: _obscure,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          focusNode: widget.focusNode,
          autovalidateMode: widget.autoValidateMode,
          validator: widget.validator,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onFieldSubmitted,
          style: widget.textStyle ?? const TextStyle(fontSize: 16),
          decoration: InputDecoration(
            labelStyle: widget.labelStyle,
            hintText: widget.hintText,
            hintStyle: widget.hintStyle,
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                        _obscure ? Icons.visibility_off : Icons.visibility),
                    onPressed: _toggleVisibility,
                  )
                : widget.suffixIcon,
            filled: widget.fillColor != null,
            fillColor: widget.fillColor,
            contentPadding: defaultPadding,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: defaultBorderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: defaultBorderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  BorderSide(color: defaultFocusedBorderColor, width: 1),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomSearchField extends StatefulWidget {
  final String? hintText;
  final void Function(String)? onSearchChanged;
  final TextEditingController? controller;

  const CustomSearchField({
    super.key,
    this.hintText,
    this.onSearchChanged,
    this.controller,
  });

  @override
  State<CustomSearchField> createState() => _CustomSearchFieldState();
}

class _CustomSearchFieldState extends State<CustomSearchField> {
  Timer? _debounce;

  void _onChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (widget.onSearchChanged != null) {
        widget.onSearchChanged!(value);
      }
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: widget.controller,
      hintText: widget.hintText ?? 'Tìm kiếm...',
      prefixIcon: const Icon(Icons.search),
      onChanged: _onChanged,
      borderColor: Colors.blue,
      focusedBorderColor: Colors.blue,
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
    );
  }
}
