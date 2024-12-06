import 'package:bais_mobile/core/helpers/file_picker_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FileSectionInputModel {
  String nameId;
  String? selectedFilePath;

  FileSectionInputModel({
    required this.nameId,
    this.selectedFilePath,
  });
}

@immutable
class FileSectionInput extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final bool isRequired;
  final Rx<FileSectionInputModel>? inputModel;

  const FileSectionInput({
    Key? key,
    this.title,
    this.subtitle,
    this.inputModel,
    this.isRequired = false,
  }) : super(key: key);

  void setFilePath(String? path) {
    if (inputModel != null) {
      inputModel!.update((model) {
        model?.selectedFilePath = path;
      });
    }
  }

  void _showFileSourceOptions(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 6,
                width: 48,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Upload File',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'You can upload a file from your device',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            _buildOptionButton(
              icon: Icons.file_upload,
              label: 'Select File',
              onTap: () async {
                Get.back(); // Close the bottom sheet
                final filePath = await FilePickerHelper.pickFile();
                if (filePath != null) {
                  setFilePath(filePath);
                }
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 164,
        width: MediaQuery.of(Get.context!).size.width,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.blue,
            width: 1.5,
            style: BorderStyle.solid,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30, color: Colors.blue),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Row(
            children: [
              Text(
                title!,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              isRequired
                  ? const Text(
                      '*',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        const SizedBox(height: 8),
        if (subtitle != null)
          Row(
            children: [
              Icon(Icons.info, size: 14),
              Text(
                subtitle!,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AspectRatio(
                    aspectRatio: 6 / 2,
                    child: Obx(
                      () => GestureDetector(
                        onTap: () async {
                          final filePath = await FilePickerHelper.pickFile();
                          if (filePath != null) {
                            setFilePath(filePath);
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300]!),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              inputModel?.value.selectedFilePath ??
                                  'Upload File',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Ukuran maksimal 10 MB',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
