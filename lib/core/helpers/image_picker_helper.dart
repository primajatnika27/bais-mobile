import 'dart:io';
import 'dart:typed_data';
import 'package:bais_mobile/core/dialogs/general_dialogs.dart';
import 'package:bais_mobile/core/snackbar/general_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as path;

class ImagePickerHelper {
  static Future<String?> pickFromCamera(BuildContext context) async {
    return await _pickImage(context, ImageSource.camera);
  }

  static Future<String?> pickFromGallery(BuildContext context) async {
    return await _pickImage(context, ImageSource.gallery);
  }

  // Helper function to pick image from specified source
  static Future<String?> _pickImage(BuildContext context, ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      GeneralDialog.showLoadingDialog();
      final resizedImage = await _resizeImageIfNeeded(pickedFile.path);

      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      return resizedImage;
    } else {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      if (context.mounted) {
        _showError('No image selected.');
      }
    }

    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
    return null;
  }

  static Future<String> _resizeImageIfNeeded(String imagePath) async {
    print("Starting image resize process for path: $imagePath");

    final imageFile = File(imagePath);
    final imageBytes = await imageFile.readAsBytes();
    final originalImage = img.decodeImage(imageBytes);

    if (originalImage == null) {
      print("Failed to decode image, returning original path.");
      return imagePath;
    }

    print("Original image dimensions: ${originalImage.width}x${originalImage.height}");

    // Check if width or height exceeds 1024px
    if (originalImage.width > 1024 || originalImage.height > 1024) {
      print("Image exceeds 1024px, resizing needed.");

      // Calculate new dimensions while maintaining the aspect ratio
      final aspectRatio = originalImage.width / originalImage.height;
      int newWidth, newHeight;
      if (originalImage.width > originalImage.height) {
        newWidth = 1024;
        newHeight = (1024 / aspectRatio).round();
      } else {
        newHeight = 1024;
        newWidth = (1024 * aspectRatio).round();
      }

      print("New dimensions calculated: ${newWidth}x${newHeight}");

      // Resize the image
      final resizedImage = img.copyResize(originalImage, width: newWidth, height: newHeight);
      final resizedBytes = img.encodeJpg(resizedImage);

      // Save the resized image to a temporary file
      final tempDir = await getTemporaryDirectory();
      final uniqueFileName = 'resized_image_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final resizedImagePath = path.join(tempDir.path, uniqueFileName);
      final resizedImageFile = File(resizedImagePath);
      await resizedImageFile.writeAsBytes(resizedBytes);

      print("Image resized and saved to: $resizedImagePath");
      return resizedImagePath;
    }

    print("No resizing needed, returning original image path.");
    return imagePath; // Return original path if no resizing is needed
  }

  static void _handlePermissionStatus(BuildContext context, PermissionStatus status, String source) {
    if (status.isPermanentlyDenied) {
      _showError('$source access permission is permanently denied. Please enable it in settings.');
      openAppSettings();
    } else if (status.isDenied) {
      _showError('$source access permission denied. Please enable it in settings.');
    }
  }

  static void _showError(String message) {
    GeneralSnackbar.show(message: message);
  }
}
