import 'package:bais_mobile/features/task/controllers/create_task_controller.dart';
import 'package:get/get.dart';

class CreateTaskBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateTaskController());
  }
}