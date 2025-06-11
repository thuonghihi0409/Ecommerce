import 'package:flutter/material.dart';
import 'package:thuongmaidientu/features/auth/presentation/page/intro.dart';
import 'package:thuongmaidientu/shared/service/navigator_service.dart';

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
      NavigationService.instance.push(const IntroPage());
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
