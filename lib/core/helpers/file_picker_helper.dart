import 'package:file_picker/file_picker.dart';

class FilePickerHelper {
  static Future<String?> pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null && result.files.single.path != null) {
        return result.files.single.path;
      }
    } catch (e) {
      // Handle any errors here
      print('Error picking file: $e');
    }
    return null;
  }
}