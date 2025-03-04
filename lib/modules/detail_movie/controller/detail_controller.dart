
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi_phim/constant/app_string.dart';
import 'package:mobi_phim/core/alert.dart';
import 'package:mobi_phim/core/base_response.dart';
import 'package:mobi_phim/models/episodes_movie.dart';
import 'package:mobi_phim/models/item_movie.dart';
import 'package:mobi_phim/modules/detail_movie/model/detail_model.dart';
import 'package:mobi_phim/modules/detail_movie/repository/detail_repository.dart';
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
  @override
  void onInit() async {
    super.onInit();
    await getMovieFromSlug(slug);
    await _updateTextColor(movieFromSlug!.poster_url!);
    if(movieFromSlug!.trailer_url != '') {
      playVideo(movieFromSlug!.trailer_url!);
    }
    tabController = TabController(length: 2, vsync: this);

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
        autoPlay: true, // Tự động phát
        mute: false,    // Không tắt tiếng
      ),
    );
    // ..loadApiKey('AIzaSyD1qeKOmospREbLGzWbM9p2xhqbcC-ew7Y');
  }
  Future<void> saveEpisode(int serverNumber,int episodeNumber) async {
    final prefs = await SharedPreferences.getInstance();
    if(episodeNumber==listEpisodesMovieFromSlug[0].server_data!.length-1) {
      await prefs.remove(slug);
    }
    else{
      await prefs.setStringList(slug, [serverNumber.toString(),episodeNumber.toString()]);
    }
  }
  Future<List> getSavedEpisode(String slug) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(slug) ?? [0.toString(),(-1).toString()]; // Mặc định là tập 1 nếu chưa lưu
  }


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