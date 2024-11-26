import 'package:bais_mobile/core/themes/app_theme.dart';
import 'package:bais_mobile/core/widgets/app_bar_general.dart';
import 'package:bais_mobile/core/widgets/button_widget.dart';
import 'package:bais_mobile/features/chat_bot/controllers/create_chat_bot_controller.dart';
import 'package:chatview/chatview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatBotView extends StatelessWidget {
  const ChatBotView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      CreateChatBotController(),
    );

    return Scaffold(
      body: Obx(
        () {
          return ChatView(
            appBar: AppBarGeneral(
              title: 'Chat Bot',
              withLeading: false,
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: () {
                      controller.onUploadFile();
                    },
                    child: const Text(
                      'Upload Article',
                    ),
                  ),
                ),
              ],
            ),
            chatController: controller.chatController,
            chatViewState: controller.chatViewState.value,
            sendMessageConfig: const SendMessageConfiguration(
              imagePickerIconsConfig: ImagePickerIconsConfiguration(
                galleryIconColor: Colors.white,
                cameraIconColor: Colors.white,
              ),
              allowRecordingVoice: false,
              textFieldBackgroundColor: AppTheme.primary,
              textFieldConfig: TextFieldConfiguration(
                hintStyle: TextStyle(
                  color: Colors.white,
                ),
                textStyle: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            onSendTap: controller.onSendTap,
            chatBackgroundConfig: const ChatBackgroundConfiguration(
              backgroundColor: AppTheme.background,
            ),
          );
        },
      ),
    );
  }
}
