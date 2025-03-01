
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
import 'package:mobi_phim/models/country_item.dart';
import 'package:mobi_phim/models/item_movie.dart';
import 'package:mobi_phim/models/movies_model.dart';
import 'package:mobi_phim/modules/option_movie/model/option_movie_model.dart';
import 'package:mobi_phim/modules/option_movie/repository/option_movie_repository.dart';
import 'package:mobi_phim/services/domain_service.dart';
import 'package:palette_generator/palette_generator.dart';


class OptionMovieController extends GetxController with GetTickerProviderStateMixin{
  final OptionMovieRepository optionMovieRepository;
  OptionMovieModel? optionMovieModel;
  OptionMovieController({required this.optionMovieRepository});
  String title=Get.arguments[0];
  String tag= Get.arguments[1];
  String url=Get.arguments[2];
  List<MoviesModel> listMovieModel =[];
  Rx<MoviesModel> movieByOption=MoviesModel().obs;
  List<ItemMovieModel> listNewUpdateMovie=[];
  ItemMovieModel? firstMovieItem;
  var selectYear=DefaultString.YEAR.obs;
  Rx<CountryItemModel> selectCountry=CountryItemModel(name: DefaultString.COUNTRY,slug: DefaultString.COUNTRY).obs;
  List<int> listYear=[];

  var backgroundColor = Colors.white.obs;
  var hsl = HSLColor.fromColor(Colors.white).obs;

  @override
  void onInit() async {
    super.onInit();
    listYear=generateYearsList(range: AppNumber.TOTAL_YEAR_RENDER_IN_LIST_YEAR);
    optionMovieData();
    loadGenreMovie();
  }

  ///***************************
  Future<void> optionMovieData() async {
    await Future.delayed(const Duration(seconds: 1));
    final BaseResponse? response;
    response = await optionMovieRepository.loadData(
        OptionMovieModel(
          url: '$url?limit=20&sort_field=modified.time' )
    );
    if (response?.statusCode == HttpStatus.ok) {
      if(response?.status == AppReponseString.STATUS_SUCCESS) {//success with 'data' and true with 'items' and 'movies'
        if(response?.data !=null){
          movieByOption.value=MoviesModel.fromJson(response!.data!,DefaultString.NULL);
          for (var item in movieByOption.value.list_movie!) {
            listNewUpdateMovie.add(item);
          }
        }
        firstMovieItem=listNewUpdateMovie[0];

        await _updateBackgroundColor(DomainProvider.imgUrl+firstMovieItem!.poster_url!);
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
          message:CommonString.ERROR_URL_MESSAGE,
          buttonText:  CommonString.CANCEL);
    }
  }
  ///***************************************
  Future<void> genreMovie(String genre,String title) async {
    listMovieModel=[];
    final BaseResponse? response;
    response = await optionMovieRepository.loadData(OptionMovieModel(
      url: '$url?category=$genre${selectYear.value==DefaultString.YEAR? DefaultString.NULL : '&year=${selectYear.value}'}${selectCountry.value.slug==DefaultString.COUNTRY? DefaultString.NULL : '&country=${selectCountry.value.slug}'}',
    ));
    update();
    if (response?.statusCode == HttpStatus.ok) {
      if(response?.status == AppReponseString.STATUS_SUCCESS) {//success with 'data' and true with 'items' and 'movies'
        listMovieModel.add( MoviesModel.fromJson(response!.data!,title));

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
          message:CommonString.ERROR_URL_MESSAGE,
          buttonText:  CommonString.CANCEL);
    }


  }
  void loadGenreMovie(){
    for(int i=0;i<genresList.length;i++)
    {
      genreMovie(genresList[i].slug!,genresList[i].name!);
    }
  }
  Future<void> _updateBackgroundColor(String imageUrl) async {
    final PaletteGenerator paletteGenerator =
    await PaletteGenerator.fromImageProvider(NetworkImage(imageUrl));
    backgroundColor.value = paletteGenerator.dominantColor?.color ?? Colors.white;
    hsl.value = HSLColor.fromColor(backgroundColor.value);
  }
  void onSelectYear(int result){
    selectYear.value=listYear[result].toString();
    loadGenreMovie();
  }
  void onSelectCountry(int result){
    selectCountry.value=CountryItemModel(slug: countryList[result].slug,name:countryList[result].name );
    loadGenreMovie();
  }
  List<int> generateYearsList({int range = AppNumber.DEFAULT_TOTAL_YEAR_RENDER_IN_LIST_YEAR}) {
    int currentYear = DateTime.now().year;
    return List.generate(range + 1, (index) => currentYear - index);
  }
}