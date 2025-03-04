

import 'package:chewie/chewie.dart';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mobi_phim/models/episodes_movie.dart';
import 'package:mobi_phim/routes/app_pages.dart';
import 'package:mobi_phim/widgets/custom_Controls_Video.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock_plus/wakelock_plus.dart';



class PlayMovieController extends GetxController {
  int currentServer=Get.arguments[0];
  int currentEpisode=Get.arguments[1];
  final String slug=Get.arguments[2];
  final List<EpisodesMovieModel>? listEpisodes=Get.arguments[3];

  late VideoPlayerController videoController;
  ChewieController? chewieController;
  bool canNext=true;

  @override
  void onInit() async {
    super.onInit();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    WakelockPlus.enable();
    _initializePlayer();
    if(currentEpisode==listEpisodes![currentServer].server_data!.length-1) {
      canNext=false;
    }
  }
  Future<void> _initializePlayer() async {
    videoController = VideoPlayerController.networkUrl(
      Uri.parse(listEpisodes![currentServer].server_data![currentEpisode].link_m3u8!),
    );

    await videoController.initialize();
    update();
    chewieController = ChewieController(
        videoPlayerController: videoController,
        autoPlay: true,
        looping: false,
        aspectRatio: videoController.value.aspectRatio,
        customControls: CustomControls(
            controller: videoController,
            onBack: (){
              WakelockPlus.disable();
              SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge); // Hiển thị lại khi thoát trang
              SystemChrome.setPreferredOrientations([
                DeviceOrientation.portraitUp,
                DeviceOrientation.portraitDown,
              ]);
              Get.back();
            },
          canNext: canNext,
          onNextEpisode: (){
                saveEpisode(currentServer,currentEpisode+1);
                Get.offNamed(Routes.PLAY_MOVIE,arguments: [currentServer,currentEpisode+1,slug,listEpisodes],preventDuplicates: false);
            },
          listNameOfEpisodes: listEpisodes![currentServer].server_data!.map((item) => item.name!,).toList(),
          currentEpisode: currentEpisode,
          onShowEpisodeList: (value){
            saveEpisode(currentServer,value);
            Get.offNamed(Routes.PLAY_MOVIE,arguments: [currentServer,value,slug,listEpisodes],preventDuplicates: false);
          },
            title: listEpisodes![currentServer].server_data![currentEpisode].name!,
        )
    );

  }
  Future<void> saveEpisode(int serverNumber,int episodeNumber) async {
    final prefs = await SharedPreferences.getInstance();
    if(episodeNumber==listEpisodes![currentServer].server_data!.length-1) {
      await prefs.remove(slug);
    }
    else{
      await prefs.setStringList(slug, [serverNumber.toString(),episodeNumber.toString()]);
    }
  }


  @override
  void onClose() {
    if(chewieController!=null) {
    }
    super.onClose();
  }
}