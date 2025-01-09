import 'package:flutter/material.dart';
import 'package:thuongmaidientu/screen/Authentication/login_screen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tài khoản của tôi', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.cyan,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Avatar và tên người dùng
              CircleAvatar(
                radius: 50,
               backgroundColor: Colors.deepPurple,
               // backgroundImage: AssetImage('assets/avatar_placeholder.png'),
              ),
              SizedBox(height: 16),
              Text(
                'Nguyễn Văn A', // Thay bằng tên người dùng
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'email@example.com', // Thay bằng email người dùng
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              Divider(height: 32, color: Colors.grey[400]),

              // Danh sách các tùy chọn
              _buildAccountOption(Icons.settings, 'Cài đặt tài khoản', () {
                // Xử lý nhấn vào
              }),
              _buildAccountOption(Icons.history, 'Lịch sử mua hàng', () {
                // Xử lý nhấn vào
              }),
              _buildAccountOption(Icons.favorite, 'Danh sách yêu thích', () {
                // Xử lý nhấn vào
              }),
              _buildAccountOption(Icons.help_outline, 'Trợ giúp', () {
                // Xử lý nhấn vào
              }),
              Divider(height: 32, color: Colors.grey[400]),

              // Nút đăng xuất
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoginScreen()),
                  );
                },
                icon: Icon(Icons.logout),
                label: Text('Đăng xuất'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  textStyle: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAccountOption(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.orange),
      title: Text(
        title,
        style: TextStyle(fontSize: 16),
      ),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }
}
