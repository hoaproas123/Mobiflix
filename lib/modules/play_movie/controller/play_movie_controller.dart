

import 'package:better_player/better_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mobi_phim/controller/movie_controller.dart';
import 'package:mobi_phim/models/episodes_movie.dart';
import 'package:mobi_phim/models/user_model.dart';
import 'package:mobi_phim/routes/app_pages.dart';
import 'package:mobi_phim/widgets/custom_Controls_Video.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wakelock_plus/wakelock_plus.dart';



class PlayMovieController extends GetxController {
  int currentServer=Get.arguments[0];
  int currentEpisode=Get.arguments[1];
  final String slug=Get.arguments[2];
  final List<EpisodesMovieModel>? listEpisodes=Get.arguments[3];

  late BetterPlayerController betterPlayerController;
  bool canNext=true;

  late UserModel user;
  @override
  void onInit() async {
    super.onInit();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    WakelockPlus.enable();
    _initializePlayer();
    await getTokenLogin();
    if(currentEpisode==listEpisodes![currentServer].server_data!.length-1) {
      update();
      canNext=false;
    }
  }
  Future<void> getTokenLogin() async {
    final prefs = await SharedPreferences.getInstance();
    user=UserModel(id: prefs.getString('id'));
  }
  void _initializePlayer()  {
    betterPlayerController = BetterPlayerController(
      const BetterPlayerConfiguration(
        autoPlay: true,
        controlsConfiguration: BetterPlayerControlsConfiguration(
          showControls: false,
        ),
      ),
      betterPlayerDataSource: BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        listEpisodes![currentServer].server_data![currentEpisode].link_m3u8!,
      ),
    );
  }
  Widget customButtonVideo(){
    return CustomControls(
        controller: betterPlayerController,
        onBack: (){
          WakelockPlus.disable();
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge); // Hiển thị lại khi thoát trang
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
            DeviceOrientation.landscapeLeft,
            DeviceOrientation.landscapeRight
          ]);
          Get.back(result: false);
        },
        canNext: canNext,
        onNextEpisode: (){
          MovieController _controller=Get.put(MovieController());
          _controller.saveEpisode(user.id!,currentServer,currentEpisode+1,slug,listEpisodes!);
          Get.offNamed(Routes.PLAY_MOVIE,arguments: [currentServer,currentEpisode+1,slug,listEpisodes],preventDuplicates: false);
        },
        listNameOfEpisodes: listEpisodes![currentServer].server_data!.map((item) => item.name!,).toList(),
        currentEpisode: currentEpisode,
        onShowEpisodeList: (value){
          MovieController _controller=Get.put(MovieController());
          _controller.saveEpisode(user.id!,currentServer,value,slug,listEpisodes!);
          Get.offNamed(Routes.PLAY_MOVIE,arguments: [currentServer,value,slug,listEpisodes],preventDuplicates: false);
        },
        title: listEpisodes![currentServer].server_data![currentEpisode].name!,
      );
  }

  @override
  void onClose() {

    super.onClose();
  }
  @override
  void dispose() {
    betterPlayerController.dispose();
    super.dispose();
  }
}