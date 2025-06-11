import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:thuongmaidientu/features/auth/presentation/page/init_page.dart';
import 'package:thuongmaidientu/features/product/presentation/bloc/product_bloc/product_bloc.dart';
import 'package:thuongmaidientu/get_it.dart';
import 'package:thuongmaidientu/shared/service/navigator_service.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await init();
  runApp(EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('vi')],
      path: 'assets/translations',
      fallbackLocale: const Locale('vivi'),
      child: OverlaySupport.global(
        child: MultiBlocProvider(
            providers: [BlocProvider(create: (_) => sl<ProductBloc>())],
            child: const MyApp()),
      )));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: MaterialApp(
        locale: context.locale,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        navigatorKey: NavigationService.instance.navigatorKey,
        theme: ThemeData(
          useMaterial3: true, //
          // primarySwatch: Colors.blue,
          // brightness: Brightness.light,
        ),
        darkTheme: ThemeData(
            // primarySwatch: Colors.blue,
            // brightness: Brightness.dark,
            ),
        // themeMode: ThemeMode.system,

        home: const InitPage(),
      ),
    );
  }
}
