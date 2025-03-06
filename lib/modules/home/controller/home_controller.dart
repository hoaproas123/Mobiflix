
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi_phim/constant/app_interger.dart';
import 'package:mobi_phim/constant/app_string.dart';
import 'package:mobi_phim/core/alert.dart';
import 'package:mobi_phim/core/base_response.dart';
import 'package:mobi_phim/data/country_data.dart';
import 'package:mobi_phim/data/genre_data.dart';
import 'package:mobi_phim/data/option_view_data.dart';
import 'package:mobi_phim/models/country_item.dart';
import 'package:mobi_phim/models/episodes_movie.dart';
import 'package:mobi_phim/models/item_movie.dart';
import 'package:mobi_phim/models/option_view_model.dart';
import 'package:mobi_phim/modules/home/model/home_model.dart';
import 'package:mobi_phim/modules/home/repository/home_repository.dart';
import 'package:mobi_phim/routes/app_pages.dart';
import 'package:mobi_phim/services/domain_service.dart';
import 'package:palette_generator/palette_generator.dart';

import 'package:mobi_phim/models/movies_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController  with GetTickerProviderStateMixin{
  final HomeRepository homeRepository;
  HomeModel? homeModel;
  HomeController({required this.homeRepository});
  List<MoviesModel> listMovieModel =[];
  List<ItemMovieModel> listNewUpdateMovie=[];
  ItemMovieModel? firstMovieItem;
  List<ItemMovieModel> listGenreMovie=[];
  List<CountryItemModel> listCountry=countryList;
  List<int> listYear=[];
  List<OptionViewModel> listOptionView=listOption;

  var selectYear=DefaultString.YEAR.obs;
  var selectCountry=DefaultString.COUNTRY.obs;

  var backgroundColor = Colors.white.obs;
  var hsl = HSLColor.fromColor(Colors.white).obs;

  ItemMovieModel? movieFromSlug;
  List<EpisodesMovieModel> listEpisodesMovieFromSlug=[];

  List<String> listSlugContinueMovie=[];

  RxBool isSplash=true.obs;

  final ScrollController scrollController = ScrollController();

  late AnimationController animationController;
  late Animation<double> fadeAnimation;
  @override
  Future<void> onInit() async {
    super.onInit();
    // Khởi tạo animation mờ dần của Splash
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: AppNumber.NUMBER_OF_DURATION_FADE_IN_MILLISECONDS), // Hiệu ứng mờ dần
    );

    fadeAnimation = Tween<double>(begin: 1, end: 0).animate(animationController);
    listYear=generateYearsList(range: AppNumber.TOTAL_YEAR_RENDER_IN_LIST_YEAR);
    onLoading();
    Future.delayed(const Duration(seconds: AppNumber.NUMBER_OF_DURATION_WAIT_SPLASH_SCREEN_SECONDS),() {
      isSplash.value=false;
    },);
  }
  onLoading(){
    listNewUpdateMovie=[];
    listMovieModel=[];
    listEpisodesMovieFromSlug=[];
    newUpdateMovieData(null);
    loadGenreMovie();
  }
  ///***************************
  Future<void> newUpdateMovieData(HomeModel? data) async {
    final BaseResponse? response;
    if(data!=null) {
      response = await homeRepository.loadData(data);
    } else {
      response = await homeRepository.loadData(HomeModel(
        url: DomainProvider.newUpdateMovieV2,
      ));
    }
    update();
    if (response?.statusCode == HttpStatus.ok) {
      if(response?.status == AppReponseString.STATUS_TRUE) {//success with 'data' and true with 'items' and 'movies'
          // print(response!.items!);
        if(response?.items !=null){
          response?.items.forEach((item){
            listNewUpdateMovie.add(ItemMovieModel.fromJson(item));
          });
        }
        firstMovieItem=listNewUpdateMovie[0];
        getMovieFromSlug(firstMovieItem!.slug!);
        await _updateBackgroundColor(listNewUpdateMovie[0].poster_url??"");
        // print(listNewUpdateMovie[2].poster_url);
          // moviesModel=MoviesModel.fromJson(response!.data!);
          // print(moviesModel!.list_movie?[1].name);
          // homeModel = HomeModel.fromJson(response!.data!);
      }
      else {
        Alert.showError(
            title: CommonString.ERROR,
            message:CommonString.ERROR_DATA_MESSAGE,
            buttonText:  CommonString.CANCEL);
      }
    } else {
      Alert.showError(
          title: CommonString.ERROR,
          message: CommonString.ERROR_URL_MESSAGE,
          buttonText:  CommonString.CANCEL);
    }
    // Alert.closeLoadingIndicator();
  }



  ///***************************************
  Future<void> genreMovie(String genre) async {
    final BaseResponse? response;
    response = await homeRepository.loadData(HomeModel(
        url: '${DomainProvider.moviesByGenre}the-loai/$genre',
    ));
    update();
    if (response?.statusCode == HttpStatus.ok) {
      if(response?.status == AppReponseString.STATUS_SUCCESS) {//success with 'data' and true with 'items' and 'movies'
        listMovieModel.add( MoviesModel.fromJson(response!.data!,DefaultString.NULL));
      }
      else {
        Alert.showError(
            title: CommonString.ERROR,
            message:CommonString.ERROR_DATA_MESSAGE,
            buttonText:  CommonString.CANCEL);
      }
    } else {
      Alert.showError(
          title: CommonString.ERROR,
          message: CommonString.ERROR_URL_MESSAGE,
          buttonText:  CommonString.CANCEL);
    }
  }
  void loadGenreMovie(){
    for(int i=0;i<genresList.length;i++)
    {
      genreMovie(genresList[i].slug!);
    }
  }


  ///***************************
  Future<void> getMovieFromSlug(String slug) async {
    listEpisodesMovieFromSlug=[];
    final BaseResponse? response;
    response = await homeRepository.loadData(HomeModel(
      url: DomainProvider.detailMovie + slug,
    ));
    update();
    if (response?.statusCode == HttpStatus.ok) {
      if(response?.status == AppReponseString.STATUS_TRUE) {//success with 'data' and true with 'items' and 'movies'
        if(response?.movies !=null){
          movieFromSlug= ItemMovieModel.fromJson(response?.movies);
        }
        if(response?.movies_episodes !=null){
          response?.movies_episodes.forEach((item){
            listEpisodesMovieFromSlug.add(EpisodesMovieModel.fromJson(item));
          });
        }
      }
      else {
        Alert.showError(
            title: CommonString.ERROR,
            message:CommonString.ERROR_DATA_MESSAGE,
            buttonText:  CommonString.CANCEL);
      }
    } else {
      Alert.showError(
          title: CommonString.ERROR,
          message: CommonString.ERROR_URL_MESSAGE,
          buttonText:  CommonString.CANCEL);
    }
  }

  Future<List> getSavedEpisode(String slug) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(slug) ?? [0.toString(),(-1).toString()]; // Mặc định là tập 1 nếu chưa lưu
  }
  Future<void> saveEpisode(int serverNumber,int episodeNumber) async {
    final prefs = await SharedPreferences.getInstance();
    if(episodeNumber==listEpisodesMovieFromSlug[0].server_data!.length-1) {
      await prefs.remove(firstMovieItem!.slug!);
    }
    else{
      await prefs.setStringList(firstMovieItem!.slug!, [serverNumber.toString(),episodeNumber.toString()]);
    }
  }
  Future<void> getListSlugContinueMovie() async {
    final prefs = await SharedPreferences.getInstance();
    listSlugContinueMovie=prefs.getKeys().toList();
    printInfo(info: "Meo ${listSlugContinueMovie[0]}");
  }

  List<int> generateYearsList({int range = AppNumber.DEFAULT_TOTAL_YEAR_RENDER_IN_LIST_YEAR}) {
    int currentYear = DateTime.now().year;
    return List.generate(range + 1, (index) => currentYear - index);
  }




  Future<void> _updateBackgroundColor(String imageUrl) async {
    update();
    final PaletteGenerator paletteGenerator =
    await PaletteGenerator.fromImageProvider(NetworkImage(imageUrl));
    backgroundColor.value = paletteGenerator.dominantColor?.color ?? Colors.white;
    hsl.value = HSLColor.fromColor(backgroundColor.value);
  }

  void onSelectYear(int result,String tag){
    selectYear.value=listYear[result].toString();
    Future.delayed(const Duration(milliseconds: 100),() {
      Get.toNamed(Routes.OPTION_MOVIE,arguments: [selectYear.value,tag,listOptionView[4].url! + selectYear.value]);
    },).then((_) {
      Future.delayed(const Duration(milliseconds: 300),() {
        selectYear.value=DefaultString.YEAR;
      },);
    },);
  }
  void onSelectCountry(int result,String tag){
    selectCountry.value=listCountry[result].name!;
    Future.delayed(const Duration(milliseconds: 100),() {
      Get.toNamed(Routes.OPTION_MOVIE,arguments: [selectCountry.value,tag,listOptionView[5].url! + listCountry[result].slug!]);
    },).then((_) {
      Future.delayed(const Duration(milliseconds: 300),() {
        selectCountry.value=DefaultString.COUNTRY;
      },);
    },);
  }

  void scrollToTop() {
    scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: AppNumber.NUMBER_OF_DURATION_SCROLL_MILLISECONDS),
      curve: Curves.easeInOut,
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
