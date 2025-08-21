import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thuongmaidientu/core/app_assets.dart';
import 'package:thuongmaidientu/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:thuongmaidientu/features/auth/presentation/page/verify_page.dart';
import 'package:thuongmaidientu/shared/service/navigator_service.dart';
import 'package:thuongmaidientu/shared/utils/extension.dart';
import 'package:thuongmaidientu/shared/utils/helper.dart';
import 'package:thuongmaidientu/shared/widgets/appbar_custom.dart';
import 'package:thuongmaidientu/shared/widgets/button_custom.dart';
import 'package:thuongmaidientu/shared/widgets/laoding_custom.dart';
import 'package:thuongmaidientu/shared/widgets/overlay_custom.dart';
import 'package:thuongmaidientu/shared/widgets/textfield_custom.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  late FocusNode _usernameNode;
  late FocusNode _emailNode;
  late FocusNode _passwordNode;
  late FocusNode _confirmPasswordNode;

  bool _isValidEmail = false, _isValidPassword = false, _isValidName = false;

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
    context.read<AuthBloc>().add(AuthRegister(
        email: _emailController.text,
        password: _passwordController.text,
        name: _emailController.text,
        onSuccess: () {
          NavigationService.instance.push(VerifyPage(
            email: _emailController.text,
          ));
        },
        onError: (val) {
          Helper.showToastBottom(message: val ?? "");
        }));
  }

  _enableButton() {
    return _isValidEmail &&
        _isValidPassword &&
        _isValidName &&
        (_passwordController.text == _confirmPasswordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return OverlayLoadingCustom(
      loadingWidget:
          BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
        return CustomLoading(
          isLoading: state.isLoading,
          isOverlay: true,
        );
      }),
      child: Scaffold(
        appBar: CustomAppBar(
          title: "key_register".tr(),
          isShowCartIcon: false,
          isShowChatIcon: false,
        ),
        body: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
          return SingleChildScrollView(
            padding: kIsWeb
                ? EdgeInsets.symmetric(
                    horizontal: context.widthScreen > 1000
                        ? context.widthScreen * 0.2
                        : context.widthScreen * 0.1)
                : const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                30.h,
                SvgPicture.asset(
                  AppAssets.addUserIcon,
                  height: 80,
                  width: 80,
                ),
                30.h,
                CustomTextField(
                    hintText: "key_name".tr(),
                    prefixIcon: const Icon(Icons.person_2_outlined),
                    labelText: "key_name".tr(),
                    controller: _usernameController,
                    focusNode: _usernameNode,
                    textInputAction: TextInputAction.next,
                    validType: ValidType.notEmpty,
                    isShowErrorMessage: true,
                    onFieldSubmitted: (p0) {
                      _emailNode.requestFocus();
                    },
                    validator: (value) {
                      setState(() {
                        _isValidName = value ?? false;
                      });
                    }),
                15.h,
                CustomTextField(
                    hintText: "key_email".tr(),
                    validType: ValidType.email,
                    isShowErrorMessage: true,
                    prefixIcon: const Icon(Icons.email_outlined),
                    labelText: "key_email".tr(),
                    controller: _emailController,
                    focusNode: _emailNode,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (p0) {
                      _passwordNode.requestFocus();
                    },
                    validator: (value) {
                      setState(() {
                        _isValidEmail = value ?? false;
                      });
                    }),
                15.h,
                CustomTextField(
                  hintText: "key_password".tr(),
                  isPassword: true,
                  prefixIcon: const Icon(Icons.lock_outline),
                  validType: ValidType.password,
                  isShowErrorMessage: true,
                  labelText: "key_password".tr(),
                  controller: _passwordController,
                  focusNode: _passwordNode,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (p0) {
                    _confirmPasswordNode.requestFocus();
                  },
                  validator: (value) {
                    setState(() {
                      _isValidPassword = value ?? false;
                    });
                  },
                ),
                15.h,
                CustomTextField(
                  hintText: "key_password".tr(),
                  validType: ValidType.notEmpty,
                  isShowErrorMessage: _passwordController.text !=
                      _confirmPasswordController.text,
                  errorMessage: "Mật khẩu không khớp",
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
                    setState(() {});
                    return;
                  },
                ),
                50.h,
                CustomButton(
                  isEnable: _enableButton(),
                  text: "key_register".tr(),
                  onPressed: () {
                    _submit();
                  },
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
