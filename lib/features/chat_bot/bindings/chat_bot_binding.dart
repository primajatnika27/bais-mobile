import 'package:bais_mobile/features/chat_bot/controllers/create_chat_bot_controller.dart';
import 'package:get/get.dart';

class ChatBotBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateChatBotController());
  }
}