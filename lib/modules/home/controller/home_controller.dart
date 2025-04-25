
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:mobi_phim/constant/app_colors.dart';
import 'package:mobi_phim/constant/app_interger.dart';
import 'package:mobi_phim/constant/app_string.dart';
import 'package:mobi_phim/core/alert.dart';
import 'package:mobi_phim/core/base_response.dart';
import 'package:mobi_phim/data/country_data.dart';
import 'package:mobi_phim/data/genre_data.dart';
import 'package:mobi_phim/data/option_view_data.dart';
import 'package:mobi_phim/models/country_item.dart';
import 'package:mobi_phim/models/episodes_movie.dart';
import 'package:mobi_phim/models/infor_movie.dart';
import 'package:mobi_phim/models/item_movie.dart';
import 'package:mobi_phim/models/option_view_model.dart';
import 'package:mobi_phim/models/user_model.dart';
import 'package:mobi_phim/modules/home/model/home_model.dart';
import 'package:mobi_phim/modules/home/repository/home_repository.dart';
import 'package:mobi_phim/modules/home/view/home_page.dart';
import 'package:mobi_phim/modules/home/view/user_page.dart';
import 'package:mobi_phim/modules/home/widgets/home_appbar_widget.dart';
import 'package:mobi_phim/modules/login/controller/login_controller.dart';
import 'package:mobi_phim/routes/app_pages.dart';
import 'package:mobi_phim/services/db_mongo_service.dart';
import 'package:mobi_phim/services/domain_service.dart';
import 'package:mobi_phim/widgets/widgets.dart';
import 'package:palette_generator/palette_generator.dart';

import 'package:mobi_phim/models/movies_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController  with GetTickerProviderStateMixin{
  final HomeRepository homeRepository;
  HomeModel? homeModel;
  HomeController({required this.homeRepository});

  UserModel? user=Get.arguments;
  List<MoviesModel> listMovieModel =[];
  RxList<ItemMovieModel> listNewUpdateMovie = <ItemMovieModel>[].obs;
  Rx<ItemMovieModel?> firstMovieItem = Rx<ItemMovieModel?>(null);
  List<ItemMovieModel> listGenreMovie=[];
  List<CountryItemModel> listCountry=countryList;
  List<int> listYear=[];
  List<OptionViewModel> listOptionView=listOption;

  RxList<ItemMovieModel> listContinueMovieModel =<ItemMovieModel>[].obs;
  RxList<List<EpisodesMovieModel>> listContinueEpisodeModel =<List<EpisodesMovieModel>>[].obs;

  RxList<String> listFavoriteSlug =<String>[].obs;

  var selectYear=DefaultString.YEAR.obs;
  var selectCountry=DefaultString.COUNTRY.obs;

  var backgroundColor = AppColors.DEFAULT_APPBAR_COLOR.obs;
  var hsl = HSLColor.fromColor(Colors.white).obs;

  Rx<ItemMovieModel?> movieFromSlug = Rx<ItemMovieModel?>(null);
  RxList<EpisodesMovieModel> listEpisodesMovieFromSlug = <EpisodesMovieModel>[].obs;


  RxBool isLoading=true.obs;

  final ScrollController scrollController = ScrollController();

  late RxBool accessScroll;

  late AnimationController animationController;
  late Animation<double> fadeAnimation;

  RxInt currentIndex = 0.obs;
  late List listPages;
  late List listAppbars;
  late Widget currentPage;
  late Widget currentAppbar;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Future<void> onInit() async {
    super.onInit();
    listPages = [];
    listPages
      ..add(const HomePage())
      ..add(const UserPage());
    currentPage = const HomePage();
    listAppbars = [];
    listAppbars
      ..add(HomeAppbarWidget(
        actions: [
          IconButton(
          onPressed: () => onSearchPress(),
          icon: const Icon(
            Icons.search,
            size: 30,
            color: Colors.white,
            ),
          ),
          WidgetSize.sizedBoxWidth_10,
        ],
      )
      )
      ..add(HomeAppbarWidget(
        title: 'Mobiflix của tôi',
        actions: [
          IconButton(
            onPressed: () {
              LoginController _controller=Get.find();
              _controller.logout();
            },
            icon: const Icon(
              Icons.logout_rounded,
              size: 30,
              color: Colors.white,
            ),
          ),
          WidgetSize.sizedBoxWidth_10,
        ],
      ));
    currentAppbar = HomeAppbarWidget(
      actions: [
        IconButton(
          onPressed: () => onSearchPress(),
          icon: const Icon(
            Icons.search,
            size: 30,
            color: Colors.white,
          ),
        ),
        WidgetSize.sizedBoxWidth_10,
      ],
    );
    accessScroll=false.obs;
    // Khởi tạo animation mờ dần của Splash
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: AppNumber.NUMBER_OF_DURATION_FADE_IN_MILLISECONDS), // Hiệu ứng mờ dần
    );

    fadeAnimation = Tween<double>(begin: 1, end: 0).animate(animationController);
    listYear=generateYearsList(range: AppNumber.TOTAL_YEAR_RENDER_IN_LIST_YEAR);
    onLoading();
    Future.delayed(const Duration(seconds: AppNumber.NUMBER_OF_DURATION_WAIT_SPLASH_SCREEN_SECONDS),() {
      isLoading.value=false;
    },);
  }
  onLoading()  {
    firstMovieItem.value=null;
    movieFromSlug.value=null;
    listNewUpdateMovie.value=[];
    listMovieModel=[];
    listContinueMovieModel.value =[];
    listContinueEpisodeModel.value=[];
    listEpisodesMovieFromSlug.value=[];
    newUpdateMovieData(null);
    loadGenreMovie();
    getListContinueMovie();
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
        if(response?.items !=null){
          response?.items.forEach((item){
            listNewUpdateMovie.add(ItemMovieModel.fromJson(item));
          });
        }
        firstMovieItem.value=listNewUpdateMovie[0];
        getMovieFromSlug(firstMovieItem.value!.slug!);
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
    listEpisodesMovieFromSlug.value=[];
    final BaseResponse? response;
    response = await homeRepository.loadData(HomeModel(
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
            buttonText:  CommonString.CANCEL);
      }
    } else {
      Alert.showError(
          title: CommonString.ERROR,
          message: CommonString.ERROR_URL_MESSAGE,
          buttonText:  CommonString.CANCEL);
    }
  }

  ///***************************
  Future<void> getContinueMovieFromSlug(String slug) async {
    final BaseResponse? response;
    response = await homeRepository.loadData(HomeModel(
      url: DomainProvider.detailMovie + slug,
    ));
    update();
    if (response?.statusCode == HttpStatus.ok) {
      if(response?.status == AppReponseString.STATUS_TRUE) {//success with 'data' and true with 'items' and 'movies'
        if(response?.movies !=null){
          listContinueMovieModel.add(ItemMovieModel.fromJson(response?.movies));
        }
        if(response?.movies_episodes !=null){
          List<EpisodesMovieModel> listEpisode=[];
          response?.movies_episodes.forEach((item){
            listEpisode.add(EpisodesMovieModel.fromJson(item));
          });
          listContinueEpisodeModel.add(listEpisode);
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
  Future<void> getListContinueMovie() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> listSlugContinueMovie=prefs.getKeys().toList().reversed.toList();
    for(int i=0;i<listSlugContinueMovie.length;i++){
      getContinueMovieFromSlug(listSlugContinueMovie[i]);
    }
  }
  Future<void> getListFavoriteMovie() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> listSlugContinueMovie=prefs.getKeys().toList().reversed.toList();
    for(int i=0;i<listSlugContinueMovie.length;i++){
      getContinueMovieFromSlug(listSlugContinueMovie[i]);
    }
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
  onSearchPress(){
    String addQuery=DefaultString.NULL;
    Get.toNamed(Routes.SEARCH_MOVIE,arguments: [backgroundColor.value,hsl.value,addQuery]);
  }
  onOptionButtonPress(int index){
    Get.toNamed(
        Routes.OPTION_MOVIE,
        arguments: [
          listOptionView[index].optionName.toString(),
          listOptionView[index].optionName.toString(),
          listOptionView[index].url
        ]
    );
  }
  onPlayButtonPress(String slug,List<EpisodesMovieModel> listEpisodes) async {
    if(listEpisodes.isEmpty){
      Alert.showError(
          title: CommonString.ERROR,
          message:CommonString.ERROR_DATA_MESSAGE,
          buttonText:  CommonString.CANCEL);
    }
    else{
      List inforSave=await getSavedEpisode(slug);
      int server = int.parse(inforSave[0]);
      int episode = int.parse(inforSave[1]);
      saveEpisode(server,episode+1,slug,listEpisodes);
      Get.toNamed(Routes.PLAY_MOVIE, arguments: [server,episode+1, slug,listEpisodes]);
    }

  }
  void scrollToTop() {
    scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: AppNumber.NUMBER_OF_DURATION_SCROLL_MILLISECONDS),
      curve: Curves.easeInOut,
    );
  }

  void changePage(int selectedIndex) {
      currentIndex.value = selectedIndex;
      currentPage = listPages[selectedIndex];
      currentAppbar=listAppbars[selectedIndex];
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
