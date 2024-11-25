import 'package:bais_mobile/features/chat_bot/controllers/create_chat_bot_controller.dart';
import 'package:bais_mobile/features/dashboard/controllers/dashboard_controller.dart';
import 'package:bais_mobile/features/home/controllers/navigation_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NavigationController());
    Get.lazyPut(() => DashboardController());
    Get.lazyPut(() => CreateChatBotController());
  }
}