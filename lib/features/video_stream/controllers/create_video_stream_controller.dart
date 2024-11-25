import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CreateVideoStreamController extends GetxController {
  final YoutubePlayerController videoController = YoutubePlayerController(
    initialVideoId: 'z7SiAaN4ogw',
    flags: const YoutubePlayerFlags(
      autoPlay: true,
      isLive: true,
      mute: true,
      showLiveFullscreenButton: true,
    ),
  );

  @override
  void dispose() {
    super.dispose();
    videoController.dispose();
  }

  @override
  void onClose() {
    super.onClose();
    videoController.dispose();
  }
}