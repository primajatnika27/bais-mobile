import 'package:bais_mobile/features/video_stream/controllers/create_video_stream_controller.dart';
import 'package:get/get.dart';

class VideoStreamBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateVideoStreamController());
  }
}