import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:thuongmaidientu/features/auth/presentation/page/login_page.dart';
import 'package:thuongmaidientu/features/profile/presentation/page/chat_bot_page.dart';
import 'package:thuongmaidientu/features/profile/presentation/page/purchase_history_screen.dart';
import 'package:thuongmaidientu/features/profile/presentation/page/setting_screen.dart';
import 'package:thuongmaidientu/shared/service/navigator_service.dart';
import 'package:thuongmaidientu/shared/service/picker_service.dart';
import 'package:thuongmaidientu/shared/widgets/appbar_custom.dart';
import 'package:thuongmaidientu/shared/widgets/button_custom.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String _avt = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "key_setting".tr(),
        showLeading: false,
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
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.deepPurple,
                      backgroundImage:
                          _avt.isEmpty ? NetworkImage(_avt) : AssetImage(_avt),
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
                          icon: const Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.black,
                          ))),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Nguyễn Văn A', // Thay bằng tên người dùng
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'email@example.com', // Thay bằng email người dùng
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              Divider(height: 32, color: Colors.grey[400]),

              // Danh sách các tùy chọn
              _buildAccountOption(Icons.settings, "key_account_setting".tr(),
                  () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AccountSettingsScreen()));
              }),
              _buildAccountOption(Icons.history, "key_history".tr(), () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PurchaseHistoryScreen()));
              }),
              _buildAccountOption(Icons.favorite, "key_list_favorite".tr(), () {
                // Xử lý nhấn vào
              }),
              _buildAccountOption(Icons.help_outline, "key_help".tr(), () {
                NavigationService.instance.push(const GeminiChatPage());
              }),
              Divider(height: 32, color: Colors.grey[400]),
              CustomButton(
                text: "key_logout".tr(),
                onPressed: () {
                  NavigationService.instance.push(const LoginScreen());
                },
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
        style: const TextStyle(fontSize: 16),
      ),
      trailing:
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
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
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: const Text('Chọn từ thư viện'),
                  leading: const Icon(Icons.photo_library),
                  onTap: () async {
                    NavigationService.instance.goBack();
                    final path =
                        await pickerService.pickSingleImageFromGallery();
                    setState(() {
                      _avt = path ?? "";
                    });
                  },
                ),
                const SizedBox(height: 20),
                ListTile(
                  title: const Text('Mở camera'),
                  leading: const Icon(Icons.camera_alt_outlined),
                  onTap: () {
                    NavigationService.instance.goBack();
                    pickerService.captureImageFromCamera();
                  },
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }
}
