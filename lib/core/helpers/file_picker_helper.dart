import 'package:file_picker/file_picker.dart';

class FilePickerHelper {
  static Future<String?> pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'],
      );

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