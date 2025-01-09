import 'package:flutter/material.dart';
import 'package:thuongmaidientu/screen/Authentication/login_screen.dart';
import 'package:thuongmaidientu/screen/account/purchase_history_screen.dart';
import 'package:thuongmaidientu/screen/account/setting_screen.dart';
import 'package:thuongmaidientu/service/picker_service.dart';

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
              Stack(
                children: [
                  InkWell(
                    child: Container(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.deepPurple,
                        // backgroundImage: AssetImage('assets/avatar_placeholder.png'),
                      ),
                    ),
                    onTap: () {},
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: IconButton(
                          onPressed: () {
                            _showImagePickerDialog(context);
                          },
                          icon: Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.black,
                          ))),
                ],
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AccountSettingsScreen()));
              }),
              _buildAccountOption(Icons.history, 'Lịch sử mua hàng', () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PurchaseHistoryScreen()));
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
                    MaterialPageRoute(builder: (context) => LoginScreen()),
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

  void _showImagePickerDialog(BuildContext context) {
    PickerService pickerService = PickerService();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            color: Colors.black.withOpacity(0.6),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: const Text('Chọn từ thư viện'),
                    leading: const Icon(Icons.photo_library),
                    onTap: (){pickerService.pickMultipleFiles();},
                  ),
                  const SizedBox(height: 20),
                  ListTile(
                    title: const Text('Mở camera'),
                    leading: const Icon(Icons.camera_alt_outlined),
                    onTap: (){
                      pickerService.captureImageFromCamera();
                    },
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
