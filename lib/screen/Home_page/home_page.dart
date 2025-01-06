import 'package:flutter/material.dart';
import 'package:thuongmaidientu/screen/Home_page/home_screen.dart';
import 'package:thuongmaidientu/screen/Notification/notification_screen.dart';
import 'package:thuongmaidientu/screen/account/account_screen.dart';
import 'package:thuongmaidientu/screen/live/live_screen.dart';
import 'package:thuongmaidientu/screen/videos/videos_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  final List<Widget> _screens = [
    HomeScreen(),
    LiveScreen(),
    VideosScreen(),
    NotificationScreen(),
    AccountScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            children: _screens,
          ),
          Positioned(
            bottom: 2,
            left: 2,
            right: 2,
            child: Center(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: const Offset(0, 4),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  currentIndex: _selectedIndex,
                  onTap: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                    // move page when selected
                    _pageController.jumpToPage(index);
                  },
                  items: [
                    _buildNavItem(
                      icon: Icons.home_outlined,
                      index: 0,
                      label: 'Trang Chu',
                    ),
                    _buildNavItem(
                      icon: Icons.video_call,
                      index: 1,
                      label: 'Live',
                    ),
                    _buildNavItem(
                      icon: Icons.live_tv_outlined,
                      index: 2,
                      label: 'Video',
                    ),
                    _buildNavItem(
                      icon: Icons.notifications,
                      index: 3,
                      label: 'Thong bao',
                    ),
                    _buildNavItem(
                      icon: Icons.account_circle_outlined,
                      index: 4,
                      label: 'Tai khoan',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem({
    required IconData icon,
    required int index,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: ShaderMask(
        shaderCallback: (bounds) => LinearGradient(
          colors: _selectedIndex == index
              ? [Colors.purple, Colors.blue]
              : [Colors.white.withOpacity(0.7), Colors.white.withOpacity(0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(bounds),
        child: Icon(
          icon,
          size: 30,
          color: Colors.white,
        ),
      ),
      label: label,
    );
  }

}
