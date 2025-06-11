import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:thuongmaidientu/core/app_color.dart';
import 'package:thuongmaidientu/features/auth/presentation/page/home_page.dart';
import 'package:thuongmaidientu/features/auth/presentation/page/login_page.dart';
import 'package:thuongmaidientu/shared/service/navigator_service.dart';
import 'package:thuongmaidientu/shared/utils/extension.dart';
import 'package:thuongmaidientu/shared/widgets/button_custom.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final PageController _controller = PageController();
  bool isLastPage = false;

  final List<Map<String, dynamic>> pages = [
    {
      'image': 'assets/logo/image1.jpg',
      'title': 'Mua sắm đồ công nghệ dễ dàng',
      'desc': 'Chỉ vài cú chạm là bạn đã có thể sở hữu sản phẩm yêu thích.'
    },
    {
      'image': 'assets/logo/image2.jpg',
      'title': 'Sản phẩm đa dạng, chính hãng',
      'desc': 'Từ điện thoại, laptop đến thiết bị thông minh - tất cả đều có.'
    },
    {
      'image': 'assets/logo/image3.jpg',
      'title': 'Giao hàng nhanh & tiện lợi',
      'desc': 'Giao tận nhà trong 1-2 ngày với dịch vụ uy tín và đảm bảo.'
    },
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: pages.length,
                  onPageChanged: (index) {
                    setState(() => isLastPage = index == pages.length - 1);
                  },
                  itemBuilder: (_, index) {
                    final page = pages[index];
                    return Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            page["image"],
                          ),
                          const SizedBox(height: 32),
                          Text(
                            page['title'],
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            page['desc'],
                            style: const TextStyle(fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SmoothPageIndicator(
                controller: _controller,
                count: pages.length,
                effect: const WormEffect(
                  activeDotColor: Colors.deepOrange,
                  dotHeight: 10,
                  dotWidth: 10,
                ),
              ),
              const SizedBox(height: 24),
              CustomButton(
                text: isLastPage ? 'key_login'.tr() : 'Tiếp theo',
                onPressed: () {
                  if (isLastPage) {
                    NavigationService.instance.push(const LoginScreen());
                  } else {
                    _controller.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut);
                  }
                },
              ),
              20.h,
              if (isLastPage)
                CustomButton(
                  backgroundColor: AppColor.greyColor,
                  text: "key_skip".tr(),
                  onPressed: () {
                    NavigationService.instance.push(const HomePage());
                  },
                ),
              20.h,
            ],
          ),
        ),
      ),
    );
  }
}
