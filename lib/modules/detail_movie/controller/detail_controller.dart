
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mobi_phim/constant/app_interger.dart';
import 'package:mobi_phim/constant/app_string.dart';
import 'package:mobi_phim/core/alert.dart';
import 'package:mobi_phim/core/base_response.dart';
import 'package:mobi_phim/models/episodes_movie.dart';
import 'package:mobi_phim/models/infor_movie.dart';
import 'package:mobi_phim/models/item_movie.dart';
import 'package:mobi_phim/models/movies_model.dart';
import 'package:mobi_phim/models/user_model.dart';
import 'package:mobi_phim/modules/detail_movie/model/detail_model.dart';
import 'package:mobi_phim/modules/detail_movie/repository/detail_repository.dart';
import 'package:mobi_phim/routes/app_pages.dart';
import 'package:mobi_phim/services/db_mongo_service.dart';
import 'package:mobi_phim/services/domain_service.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class DetailController extends GetxController with GetTickerProviderStateMixin{
  final DetailRepository detailRepository;
  DetailModel? detailModel;
  DetailController({required this.detailRepository});

  String slug=Get.arguments;
  ItemMovieModel? movieFromSlug;
  List<EpisodesMovieModel> listEpisodesMovieFromSlug=[];
  late TabController tabController;
  late TabController tabEpisodeController;

  var textColor = Colors.black.obs;
  var hslText = HSLColor.fromColor(Colors.white).obs;

  YoutubePlayerController?  youtubePlayerController;
  var isPlaying = false.obs; // Trạng thái video (đang phát / dừng)

  List<String> listSlugContinueMovie=[];

  double heightEpisodes=AppNumber.AVG_NUMBER_OF_HEIGHT_PER_ROW;

  RxBool isFavorite=false.obs;

  RxBool isFullscreen=false.obs;

  RxBool isMoviescreen=false.obs;

  late UserModel user;
  @override
  void onInit() async {
    super.onInit();
    await getTokenLogin();
    tabController = TabController(length: 2, vsync: this);
    isFavorite.value= await DbMongoService().isFavoriteMovie(InforMovie(profile_id: user.id,slug: slug));
    await getMovieFromSlug(slug);
    await _updateTextColor(movieFromSlug!.poster_url!);
    if(movieFromSlug!.trailer_url != '') {
      playVideo(movieFromSlug!.trailer_url!);
    }
    if(listEpisodesMovieFromSlug.isNotEmpty) {
      (listEpisodesMovieFromSlug[0].server_data?.length??AppNumber.NUMBER_OF_CHIP_EPOSIDES_PER_ROW) <=AppNumber.NUMBER_OF_CHIP_EPOSIDES_PER_ROW ? heightEpisodes : heightEpisodes=((listEpisodesMovieFromSlug[0].server_data?.length??AppNumber.NUMBER_OF_CHIP_EPOSIDES_PER_ROW)/AppNumber.NUMBER_OF_CHIP_EPOSIDES_PER_ROW).ceil()*heightEpisodes ;
    }
  }
  Future<void> getTokenLogin() async {
    final prefs = await SharedPreferences.getInstance();
    user=UserModel(id: prefs.getString('id')); // Mặc định là tập 1 nếu chưa lưu
  }
  ///***************************
  Future<void> getMovieFromSlug(String slug) async {
    listEpisodesMovieFromSlug=[];
    final BaseResponse? response;
    response = await detailRepository.loadData(DetailModel(
      url: DomainProvider.detailMovie + slug,
    ));
    update();
    if (response?.statusCode == HttpStatus.ok) {
      if(response?.status == true.toString()) {//success with 'data' and true with 'items' and 'movies'
        if(response?.movies !=null){
          movieFromSlug= ItemMovieModel.fromJson(response?.movies);
        }
        if(response?.movies_episodes !=null){
          response?.movies_episodes.forEach((item){
            listEpisodesMovieFromSlug.add(EpisodesMovieModel.fromJson(item));
          });
          tabEpisodeController = TabController(length: listEpisodesMovieFromSlug.length, vsync: this);
        }

      }
      else {
        Alert.showError(
            title: CommonString.ERROR,
            message: CommonString.ERROR_DATA_MESSAGE,
            buttonText:  CommonString.CANCEL);
      }
    } else {
      Alert.showError(
          title: CommonString.ERROR,
          message:CommonString.ERROR_URL_MESSAGE,
          buttonText:  CommonString.CANCEL);
    }
  }

  Future<void> _updateTextColor(String imageUrl) async {
    update();
    final PaletteGenerator paletteGenerator =
    await PaletteGenerator.fromImageProvider(NetworkImage(imageUrl));
    textColor.value = paletteGenerator.dominantColor?.color ?? Colors.white;
    hslText.value = HSLColor.fromColor(textColor.value);
  }
  void playVideo(String url)
  {
    youtubePlayerController = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(url)!,
      flags: const YoutubePlayerFlags(
        autoPlay: false, // Tự động phát
        mute: false,    // Không tắt tiếng
      ),
    )..addListener(() {
      if (!youtubePlayerController!.value.isFullScreen ) {
        isFullscreen.value=false;
        // Khi thoát chế độ toàn màn hình, khôi phục xoay dọc
        isMoviescreen.value==false ?
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ])
        :
        SystemChrome.setPreferredOrientations([

          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ])
        ;
      }
      else{
        isFullscreen.value=true;
      }

    });
    // ..loadApiKey('AIzaSyD1qeKOmospREbLGzWbM9p2xhqbcC-ew7Y');
  }
  Future<void> saveEpisode(int serverNumber,int episodeNumber,String slug, List<EpisodesMovieModel> listEpisodes) async {
    final prefs = await SharedPreferences.getInstance();
    InforMovie newMovie=InforMovie(profile_id: user?.id,slug: slug,episode: episodeNumber,serverNumber: serverNumber );
    DbMongoService().addContinueMovie(newMovie);
    if(prefs.containsKey(slug)){
      if(episodeNumber==listEpisodes[0].server_data!.length-1 ) {
        await prefs.remove(slug);
      }
      else{
        await prefs.remove(slug).then((value) {
          prefs.setStringList(slug, [serverNumber.toString(),episodeNumber.toString()]);
        },);
      }
    }
    else{
      await prefs.setStringList(slug, [serverNumber.toString(),episodeNumber.toString()]);
    }
  }
  Future<List> getSavedEpisode(String slug) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(slug) ?? [0.toString(),(-1).toString()]; // Mặc định là tập 1 nếu chưa lưu
  }

  onPlayButtonPress() async {
    List inforSave=await getSavedEpisode(slug);
    int server = int.parse(inforSave[0]);
    int episode = int.parse(inforSave[1]);
    saveEpisode(server,episode+1,slug,listEpisodesMovieFromSlug);
    isMoviescreen.value=true;
    isMoviescreen.value = await Get.toNamed(Routes.PLAY_MOVIE, arguments: [server,episode+1, slug, listEpisodesMovieFromSlug]);
  }
  onFavoriteButtonPress(){
    InforMovie newMovie=InforMovie(profile_id: user.id,slug: slug);
    if(isFavorite.value==false){
      DbMongoService().addFavoriteMovie(newMovie);
    }
    else{
      DbMongoService().removeFavoriteMovie(newMovie);
    }
    isFavorite.value= !isFavorite.value;
  }

  onEpisodeButtonPress(int server, int episode) async{
    saveEpisode(server,episode,slug,listEpisodesMovieFromSlug);
    isMoviescreen.value=true;
    isMoviescreen.value = await Get.toNamed(Routes.PLAY_MOVIE,arguments: [server,episode,slug,listEpisodesMovieFromSlug]);
  }
  @override

  @override
  void onClose() {
    // Kiểm tra và dừng YoutubePlayerController
    if(youtubePlayerController!=null) {
      youtubePlayerController?.dispose();
    }
    // Hủy bỏ TabController nếu có
    tabController.dispose();

    // Xóa dữ liệu và hủy tất cả các biến Rx đang quan sát
    listEpisodesMovieFromSlug.clear();
    movieFromSlug = null;

    super.onClose();
  }
}