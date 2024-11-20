import 'package:bais_mobile/core/helpers/image_picker_helper.dart';
import 'package:bais_mobile/core/helpers/utils/color_extensions.dart';
import 'package:bais_mobile/core/widgets/selectable_option_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class PhotoSectionInputModel {
  String nameId;
  String? selectedImagePath;

  PhotoSectionInputModel({
    required this.nameId,
    this.selectedImagePath,
  });
}

@immutable
class PhotoSectionInput extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final String? sampleText;
  final String? sampleImagePath;
  final bool isOther;
  final bool isRequired;
  final Rx<PhotoSectionInputModel>? inputModel;
  final bool isProfile;
  final String? identifier;

  const PhotoSectionInput({
    Key? key,
    this.title,
    this.subtitle,
    this.sampleText,
    this.sampleImagePath,
    this.inputModel,
    this.isOther = false,
    this.isRequired = false,
    this.isProfile = false,
    this.identifier
  }) : super(key: key);

  void setCameraImagePath(String? path) {
    if (inputModel != null) {
      inputModel!.update((model) {
        model?.selectedImagePath = path;
      });
    }
  }

  void _showImageSourceOptions(BuildContext context) {
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
              'Upload Photo Incident',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'You can upload photo from camera or gallery',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: _buildOptionButton(
                    icon: Icons.camera_alt,
                    label: 'Foto dari Kamera',
                    onTap: () async {
                      Get.back(); // Close the bottom sheet
                      final imagePath = await ImagePickerHelper.pickFromCamera(context);
                      if (imagePath != null) {
                        setCameraImagePath(imagePath);
                      }
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildOptionButton(
                    icon: Icons.photo,
                    label: 'Pilih dari Galeri',
                    onTap: () async {
                      Get.back(); // Close the bottom sheet
                      final imagePath = await ImagePickerHelper.pickFromGallery(context);
                      if (imagePath != null) {
                        setCameraImagePath(imagePath);
                      }
                    },
                  ),
                ),
              ],
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
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: HexColor("#EFF5FD"),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: HexColor("#0057B8"),
            width: 1.5,
            style: BorderStyle.solid,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30, color: HexColor("#0057B8")),
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
    // Existing UI code with modified onTap handler
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
              SvgPicture.asset(
                "assets/images/svg/ic_info.svg",
                height: 14,
              ),
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
                    aspectRatio: isOther ? 2 / 1 : 3 / 2,
                    child: Obx(
                          () => SelectableOptionCard(
                        label: 'Upload File / Image',
                        icon: SvgPicture.asset(
                          "assets/images/svg/ic_camera.svg",
                        ),
                        borderColor: Colors.grey[300]!,
                        imagePath: inputModel?.value.selectedImagePath,
                        onTap: () {
                          _showImageSourceOptions(context);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Ukuran maksimal 5 MB',
                    style: TextStyle(
                      color: HexColor('#667085'),
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
