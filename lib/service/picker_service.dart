import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
class PickerService {

  final ImagePicker _picker = ImagePicker();
  Future<void> requestStoragePermission() async {
    if (Platform.isAndroid) {

      if (await Permission.storage.isGranted) {
        print("Quyền lưu trữ đã được cấp.");
      } else {
        var status = await Permission.storage.request();
        if (status.isPermanentlyDenied) openAppSettings();
      }
    }
  }

  Future<List<String>> pickMultipleFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpeg','png', 'mp4'],
    );
    if (result != null) {
      log("${result.paths[0]}");
      return result.paths.whereType<String>().toList();
    } else {
      print('Người dùng đã không chọn tệp nào.');
      return [];
    }
  }

  Future<String> captureImageFromCamera() async {
    final XFile? pickedFile =
    await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      return pickedFile.path;
    }
    return "";
  }

  Future<String> captureVideo() async {
    final XFile? video = await _picker.pickVideo(source: ImageSource.camera);
    if (video != null) {
      return video.path;
    }
    return "";
  }


}
