import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:thuongmaidientu/shared/utils/extension.dart';
import 'package:thuongmaidientu/shared/widgets/appbar_custom.dart';
import 'package:thuongmaidientu/shared/widgets/button_custom.dart';
import 'package:thuongmaidientu/shared/widgets/textfield_custom.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  late FocusNode _usernameNode;
  late FocusNode _emailNode;
  late FocusNode _passwordNode;
  late FocusNode _confirmPasswordNode;
  final bool _showPassword = false;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _usernameNode = FocusNode();
    _emailNode = FocusNode();
    _passwordNode = FocusNode();
    _confirmPasswordNode = FocusNode();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _usernameNode.dispose();
    _emailNode.dispose();
    _passwordNode.dispose();
    _confirmPasswordNode.dispose();
    super.dispose();
  }

  void _submit() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Đăng ký thành công!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "key_register".tr(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            50.h,
            CustomTextField(
                prefixIcon: const Icon(Icons.person_2_outlined),
                labelText: "key_name".tr(),
                controller: _usernameController,
                focusNode: _usernameNode,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (p0) {
                  _emailNode.requestFocus();
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email không được để trống";
                  }
                  return null;
                }),
            15.h,
            CustomTextField(
              prefixIcon: const Icon(Icons.email_outlined),
              labelText: "key_email".tr(),
              controller: _emailController,
              focusNode: _emailNode,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (p0) {
                _passwordNode.requestFocus();
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Email không được để trống";
                }
                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                  return "Email không hợp lệ";
                }
                return null;
              },
            ),
            15.h,
            CustomTextField(
              isPassword: true,
              prefixIcon: const Icon(Icons.lock_outline),
              labelText: "key_password".tr(),
              controller: _passwordController,
              focusNode: _passwordNode,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (p0) {
                _confirmPasswordNode.requestFocus();
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Mật khẩu không được để trống";
                }
                if (value.length < 6) {
                  return "Mật khẩu phải chứa ít nhất 6 ký tự";
                }
                return null;
              },
            ),
            15.h,
            CustomTextField(
              isPassword: true,
              prefixIcon: const Icon(Icons.lock_outlined),
              labelText: "key_confirm_password".tr(),
              controller: _confirmPasswordController,
              focusNode: _confirmPasswordNode,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (p0) {
                _submit();
              },
              validator: (value) {
                if (value != _passwordController.text) {
                  return "Mật khẩu xác nhận không khớp";
                }
                return null;
              },
            ),
            50.h,
            CustomButton(
              text: "key_register".tr(),
              onPressed: () {
                _submit();
              },
            )
          ],
        ),
      ),
    );
  }
}
