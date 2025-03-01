import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mobi_phim/modules/play_movie/controller/play_movie_controller.dart';
import 'package:wakelock_plus/wakelock_plus.dart';


class PlayMovieView extends GetView<PlayMovieController> {
  const PlayMovieView({super.key});


  @override
  Widget build(BuildContext context) {
    return GetBuilder<PlayMovieController>(builder: (controller) {
      return PopScope(
        onPopInvoked: (didPop) {
            controller.onClose();
            WakelockPlus.disable();
            SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge); // Hiển thị lại khi thoát trang
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.portraitUp,
              DeviceOrientation.portraitDown,
            ]);
            controller.videoController.dispose();
                  },
        child: Scaffold(
          body: Container(
            color: Colors.black,
            child: Center(
                child: controller.chewieController == null ?
                CircularProgressIndicator(color: Colors.white,)
                    :
                Chewie(controller: controller.chewieController!)
            ),
          ),
        ),
      );
    },);
  }
}