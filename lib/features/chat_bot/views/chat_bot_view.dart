import 'package:bais_mobile/core/themes/app_theme.dart';
import 'package:bais_mobile/core/widgets/app_bar_general.dart';
import 'package:bais_mobile/features/chat_bot/controllers/create_chat_bot_controller.dart';
import 'package:chatview/chatview.dart';
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
            appBar: const AppBarGeneral(
              title: 'Chat Bot',
              withLeading: false,
            ),
            chatController: controller.chatController,
            chatViewState: controller.chatViewState.value,
            sendMessageConfig: const SendMessageConfiguration(
              textFieldConfig: TextFieldConfiguration(
                textStyle: TextStyle(
                  color: Colors.black,
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
