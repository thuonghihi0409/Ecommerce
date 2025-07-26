import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuongmaidientu/core/app_color.dart';
import 'package:thuongmaidientu/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:thuongmaidientu/features/auth/presentation/page/intro.dart';
import 'package:thuongmaidientu/features/auth/presentation/page/login_page.dart';
import 'package:thuongmaidientu/features/product/domain/entities/store.dart';
import 'package:thuongmaidientu/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:thuongmaidientu/main_tab.dart';
import 'package:thuongmaidientu/shared/service/navigator_service.dart';
import 'package:thuongmaidientu/shared/utils/helper.dart';
import 'package:thuongmaidientu/web_main_drawer.dart';

class InitPage extends StatefulWidget {
  const InitPage({super.key});

  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getData();
    });
  }

  void _getData() async {
    context
        .read<AuthBloc>()
        .add(AuthResumeSession(onSuccess: (bool isResume, String? email) {
          if (isResume) {
            context.read<ProfileBloc>().add(GetProfile(
                email: email ?? "",
                onSuccess: () {
                  if (kIsWeb) {
                    final bloc = context.read<ProfileBloc>();
                    List<Store> store = bloc.state.listStores ?? [];
                    if (store.isEmpty) {
                      // create business
                    } else if (store.length == 1) {
                      bloc.add(SetStore(store: store[0]));
                      NavigationService.instance
                          .popUntilRootAndReplace(const WebMainDrawer());
                    } else {
                      Helper.showCustomDialog(
                          context: context,
                          onPressPrimaryButton: () {},
                          message: "key_select_store".tr(),
                          headerCustom: Column(
                            children: store
                                .map((st) => InkWell(
                                      child: Text(st.name ?? ""),
                                      onTap: () {
                                        bloc.add(SetStore(store: st));
                                        NavigationService.instance.goBack();
                                        NavigationService.instance
                                            .popUntilRootAndReplace(
                                                const WebMainDrawer());
                                      },
                                    ))
                                .toList(),
                          ));
                    }
                  } else {
                    NavigationService.instance
                        .popUntilRootAndReplace(const MainTab());
                  }
                },
                onError: () {
                  NavigationService.instance
                      .popUntilRootAndReplace(const LoginScreen());
                }));
          } else {
            NavigationService.instance
                .popUntilRootAndReplace(const IntroPage());
          }
        }, onError: (message) {
          Helper.showToastBottom(message: message);
          NavigationService.instance.popUntilRootAndReplace(const IntroPage());
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.primary,
    );
  }
}
