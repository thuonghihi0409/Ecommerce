import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:thuongmaidientu/core/app_color.dart';
import 'package:thuongmaidientu/core/app_text_style.dart';
import 'package:thuongmaidientu/features/auth/presentation/page/forgot_password.dart';
import 'package:thuongmaidientu/features/auth/presentation/page/home_page.dart';
import 'package:thuongmaidientu/features/auth/presentation/page/register_page.dart';
import 'package:thuongmaidientu/shared/service/navigator_service.dart';
import 'package:thuongmaidientu/shared/widgets/appbar_custom.dart';
import 'package:thuongmaidientu/shared/widgets/button_custom.dart';
import 'package:thuongmaidientu/shared/widgets/textfield_custom.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  late FocusNode _usernameFocus;
  late FocusNode _passwordFocus;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _usernameFocus = FocusNode();
    _passwordFocus = FocusNode();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    // if (!_formKey.currentState!.validate()) {
    //   return;
    // }
    // try {
    //   print(_usernameController.text + _passwordController.text);
    //   bool loginResponse = await context
    //       .read<LoginService>()
    //       .login(_usernameController.text, _passwordController.text);
    //   if (loginResponse == false) {
    //     await showErrorDialog(context, "Đăng nhập không thành công!");
    //   }
    // } catch (error) {
    //   if (mounted) {
    //     print("Đã xảy ra lỗi: $error");
    //     await showErrorDialog(context, "Đăng nhập không thành công!");
    //   }
    // }
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "key_login".tr(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                        "Chào mừng bạn đến với nền tảng mua sắm trực tuyến của chúng tôi !",
                        style: AppTextStyles.textSize14()),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                controller: _usernameController,
                labelText: "key_email".tr(),
                prefixIcon: const Icon(Icons.email_outlined),
                focusNode: _usernameFocus,
                onFieldSubmitted: (p0) {
                  _passwordFocus.requestFocus();
                },
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(
                height: 40,
              ),
              CustomTextField(
                isPassword: true,
                focusNode: _passwordFocus,
                controller: _passwordController,
                labelText: "key_password".tr(),
                prefixIcon: const Icon(Icons.lock_outlined),
                onFieldSubmitted: (val) {
                  _submit();
                },
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(
                height: 40,
              ),
              CustomButton(
                text: "key_login".tr(),
                onPressed: () {
                  NavigationService.instance
                      .popUntilRootAndReplace(const HomePage());
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        NavigationService.instance.push(const ForgotPassword());
                      },
                      child: Text(
                        "key_forgot_password".tr(),
                        style:
                            AppTextStyles.textSize20(color: AppColor.secondary),
                      ))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Đăng nhập với | ',
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: AssetImage(
                                  'assets/logo/facebook.png',
                                ),
                                radius: 20,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              CircleAvatar(
                                backgroundImage: AssetImage(
                                  'assets/logo/google.png',
                                ),
                                radius: 17,
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                thickness: 0.5,
                color: Colors.black,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Bạn không có tài khoản? ",
                    style: TextStyle(fontSize: 17),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterScreen(),
                        ),
                      );
                    },
                    child: Text("Đăng ký ",
                        style: AppTextStyles.textSize20(
                            color: AppColor.greenColor)),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
