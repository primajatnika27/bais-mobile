import 'package:bais_mobile/core/widgets/app_bar_general.dart';
import 'package:bais_mobile/features/video_stream/controllers/create_video_stream_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoStreamView extends GetView<CreateVideoStreamController> {
  const VideoStreamView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarGeneral(
        title: 'Stream',
        onTapLeading: () {
          Get.back();
        },
      ),
      body: YoutubePlayer(
        controller: controller.videoController,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.amber,
        progressColors: const ProgressBarColors(
          playedColor: Colors.amber,
          handleColor: Colors.amberAccent,
        ),
        aspectRatio: 9 / 16,
        onReady: () {
          // Logika tambahan jika diperlukan saat video siap
        },
      ),
    );
  }
}
