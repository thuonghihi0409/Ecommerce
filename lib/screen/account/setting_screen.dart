import 'package:flutter/material.dart';
import 'package:thuongmaidientu/screen/account/change_password_screen.dart';
import 'package:thuongmaidientu/screen/account/update_profile_screen.dart';

class AccountSettingsScreen extends StatefulWidget {
  const AccountSettingsScreen({super.key});

  @override
  _AccountSettingsScreenState createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
  bool _notificationsEnabled = true;
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Text('Cài đặt tài khoản'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cập nhật thông tin cá nhân
            ListTile(
              title: const Text(
                "Cập nhật thông tin",
                style: TextStyle(fontSize: 20),
              ),
              trailing: const Icon(Icons.arrow_forward_ios,
                  size: 16, color: Colors.grey),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UpdateProfileScreen()));
              },
            ),
            const SizedBox(height: 20),

            // Đổi mật khẩu
            ListTile(
              title: const Text(
                "Đổi mật khẩu",
                style: TextStyle(fontSize: 20),
              ),
              trailing: const Icon(Icons.arrow_forward_ios,
                  size: 16, color: Colors.grey),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChangePasswordScreen()));
              },
            ),
            const SizedBox(height: 20),

            SwitchListTile(
              title: const Text('Chế độ tối', style: TextStyle(fontSize: 20)),
              value: _isDarkMode,
              onChanged: (value) {
                setState(() {
                  _isDarkMode = value;
                  // Chuyển giữa chế độ sáng và tối
                });
              },
            ),
            const SizedBox(height: 20),

            SwitchListTile(
              title:
                  const Text('Bật thông báo', style: TextStyle(fontSize: 20)),
              value: _notificationsEnabled,
              onChanged: (value) {
                setState(() {
                  _notificationsEnabled = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
