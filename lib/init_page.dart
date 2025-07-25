import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuongmaidientu/core/app_color.dart';
import 'package:thuongmaidientu/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:thuongmaidientu/features/auth/presentation/page/intro.dart';
import 'package:thuongmaidientu/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:thuongmaidientu/main_tab.dart';
import 'package:thuongmaidientu/shared/service/navigator_service.dart';
import 'package:thuongmaidientu/shared/utils/helper.dart';

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
                  NavigationService.instance
                      .popUntilRootAndReplace(const MainTab());
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
