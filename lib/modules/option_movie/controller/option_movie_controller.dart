
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:mobi_phim/constant/app_colors.dart';
import 'package:mobi_phim/constant/app_interger.dart';
import 'package:mobi_phim/constant/app_string.dart';
import 'package:mobi_phim/controller/movie_controller.dart';
import 'package:mobi_phim/core/alert.dart';
import 'package:mobi_phim/core/base_response.dart';
import 'package:mobi_phim/data/country_data.dart';
import 'package:mobi_phim/data/genre_data.dart';
import 'package:mobi_phim/models/country_item.dart';
import 'package:mobi_phim/models/episodes_movie.dart';
import 'package:mobi_phim/models/infor_movie.dart';
import 'package:mobi_phim/models/item_movie.dart';
import 'package:mobi_phim/models/movies_model.dart';
import 'package:mobi_phim/models/user_model.dart';
import 'package:mobi_phim/modules/option_movie/model/option_movie_model.dart';
import 'package:mobi_phim/modules/option_movie/repository/option_movie_repository.dart';
import 'package:mobi_phim/routes/app_pages.dart';
import 'package:mobi_phim/services/db_mongo_service.dart';
import 'package:mobi_phim/services/domain_service.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:shared_preferences/shared_preferences.dart';


class OptionMovieController extends GetxController with GetTickerProviderStateMixin{
  final OptionMovieRepository optionMovieRepository;
  OptionMovieModel? optionMovieModel;
  OptionMovieController({required this.optionMovieRepository});
  String title=Get.arguments[0];
  String tag= Get.arguments[1];
  String url=Get.arguments[2];
  List<MoviesModel> listMovieModel =[];
  Rx<MoviesModel> movieByOption=MoviesModel().obs;
  RxList<ItemMovieModel> listNewUpdateMovie = <ItemMovieModel>[].obs;
  Rx<ItemMovieModel?> firstMovieItem = Rx<ItemMovieModel?>(null);
  var selectYear=DefaultString.YEAR.obs;
  Rx<CountryItemModel> selectCountry=CountryItemModel(name: DefaultString.COUNTRY,slug: DefaultString.COUNTRY).obs;
  List<int> listYear=[];

  var backgroundColor = AppColors.DEFAULT_APPBAR_COLOR.obs;
  var hsl = HSLColor.fromColor(Colors.white).obs;

  Rx<ItemMovieModel?> movieFromSlug = Rx<ItemMovieModel?>(null);
  RxList<EpisodesMovieModel> listEpisodesMovieFromSlug = <EpisodesMovieModel>[].obs;

  late RxBool accessScroll;

  late UserModel user;
  @override
  void onInit() async {
    super.onInit();
    await getTokenLogin();
    accessScroll=false.obs;
    listYear=generateYearsList(range: AppNumber.TOTAL_YEAR_RENDER_IN_LIST_YEAR);
    onLoading();
  }
  Future<void> getTokenLogin() async {
    final prefs = await SharedPreferences.getInstance();
    user=UserModel(id: prefs.getString('id')); // Mặc định là tập 1 nếu chưa lưu
  }
  onLoading()  {
    firstMovieItem.value=null;
    movieFromSlug.value=null;
    listEpisodesMovieFromSlug.value=[];
    listNewUpdateMovie.value=[];
    Future.wait([
      optionMovieData(),
      loadGenreMovie(),
    ]);


  }
  ///***************************
  Future<void> optionMovieData() async {
    final BaseResponse? response;
    response = await optionMovieRepository.loadData(
        OptionMovieModel(
          url: '$url?limit=20&sort_field=modified.time${selectYear.value==DefaultString.YEAR? DefaultString.NULL : '&year=${selectYear.value}'}${selectCountry.value.slug==DefaultString.COUNTRY? DefaultString.NULL : '&country=${selectCountry.value.slug}'}' )
    );
    if (response?.statusCode == HttpStatus.ok) {
      if(response?.status == AppReponseString.STATUS_TRUE) {//success with 'data' and true with 'items' and 'movies'
        if(response?.data !=null){
          movieByOption.value=MoviesModel.fromJson(response!.data!,DefaultString.NULL);
          for (var item in movieByOption.value.list_movie!) {
            listNewUpdateMovie.add(item);
          }
        }
        firstMovieItem.value=listNewUpdateMovie[0];
        getMovieFromSlug(firstMovieItem.value!.slug!);
        await _updateBackgroundColor(DomainProvider.imgUrl+firstMovieItem.value!.poster_url!);
        update();
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
  ///***************************
  Future<void> getMovieFromSlug(String slug) async {
    final BaseResponse? response;
    response = await optionMovieRepository.loadData(OptionMovieModel(
      url: DomainProvider.detailMovie + slug,
    ));
    update();
    if (response?.statusCode == HttpStatus.ok) {
      if(response?.status == AppReponseString.STATUS_TRUE) {//success with 'data' and true with 'items' and 'movies'
        if(response?.movies !=null){
          movieFromSlug.value= ItemMovieModel.fromJson(response?.movies);
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
            buttonText:  CommonString.ERROR);
      }
    } else {
      Alert.showError(
          title: CommonString.ERROR,
          message: CommonString.ERROR_URL_MESSAGE,
          buttonText:  CommonString.ERROR);
    }
  }
  ///***************************************
  Future<void> genreMovie(String genre,String title) async {
    listMovieModel=[];
    final BaseResponse? response;
    response = await optionMovieRepository.loadData(OptionMovieModel(
      url: '$url?category=$genre${selectYear.value==DefaultString.YEAR? DefaultString.NULL : '&year=${selectYear.value}'}${selectCountry.value.slug==DefaultString.COUNTRY? DefaultString.NULL : '&country=${selectCountry.value.slug}'}',
    ));
    if (response?.statusCode == HttpStatus.ok) {
      if(response?.status == AppReponseString.STATUS_TRUE) {//success with 'data' and true with 'items' and 'movies'
        if((MoviesModel.fromJson(response!.data!,title).pagination?.totalPages ?? 0) > 0){
          listMovieModel.add( MoviesModel.fromJson(response!.data!,title));
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
          message:CommonString.ERROR_URL_MESSAGE,
          buttonText:  CommonString.CANCEL);
    }


  }
  Future<void> loadGenreMovie()async {
    List<Future> futures = [];

    for (int i = 0; i < genresList.length; i++) {
      genreMovie(genresList[i].slug!,genresList[i].name!);
    }
    await Future.wait(futures);
  }
  Future<void> _updateBackgroundColor(String imageUrl) async {
    final PaletteGenerator paletteGenerator =
    await PaletteGenerator.fromImageProvider(NetworkImage(imageUrl));
    backgroundColor.value = paletteGenerator.dominantColor?.color ?? Colors.white;
    hsl.value = HSLColor.fromColor(backgroundColor.value);
  }
  void onSelectYear(int result){
    selectYear.value=listYear[result].toString();
    onLoading();
  }
  void onSelectCountry(int result){
    selectCountry.value=CountryItemModel(slug: countryList[result].slug,name:countryList[result].name );
    onLoading();
  }
  onSearchPress(){
    String addYearQuery=selectYear.value==DefaultString.YEAR ? DefaultString.NULL:'&year=${selectYear.value}';
    String addCountryQuery=selectCountry.value.slug==DefaultString.COUNTRY ? DefaultString.NULL : '&country=${selectCountry.value.slug}';
    String addQuery= addYearQuery + addCountryQuery;
    Get.toNamed(Routes.SEARCH_MOVIE,arguments: [backgroundColor.value,hsl.value,addQuery]);
  }
  onPlayButtonPress(String slug,List<EpisodesMovieModel> listEpisodes) async {
    MovieController _controller=Get.put(MovieController());
    Alert.showLoadingIndicator(message: '');
    List inforSave=await _controller.getSavedEpisode(user.id!,slug);
    int server = int.parse(inforSave[0]);
    int episode = int.parse(inforSave[1]);
    _controller.saveEpisode(user.id!,server,episode+1,slug,listEpisodes);
    Get.toNamed(Routes.PLAY_MOVIE, arguments: [server,episode+1, slug,listEpisodes]);
  }
  List<int> generateYearsList({int range = AppNumber.DEFAULT_TOTAL_YEAR_RENDER_IN_LIST_YEAR}) {
    int currentYear = DateTime.now().year;
    return List.generate(range + 1, (index) => currentYear - index);
  }
}