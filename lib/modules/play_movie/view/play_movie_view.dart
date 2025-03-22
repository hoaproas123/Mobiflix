import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
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
        canPop: true,
        onPopInvoked: (didPop) {
            controller.onClose();
            WakelockPlus.disable();
            SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge); // Hiển thị lại khi thoát trang
                  },
        child: Scaffold(
          body: Container(
            color: Colors.black,
            child: Center(
                child: SizedBox(
                  width: context.width,
                  height: context.height,
                  child: Stack(
                    children: [
                      BetterPlayer(controller: controller.betterPlayerController),
                      controller.customButtonVideo(),
                    ],
                  ),
                )
            ),
          ),
        ),
      );
    },);
  }
}